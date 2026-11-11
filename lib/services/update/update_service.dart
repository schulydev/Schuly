import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show appFlavor;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/distribution.dart';
import 'apk_installer.dart';
import 'app_version.dart';
import 'release_info.dart';

sealed class UpdateCheckResult {
  const UpdateCheckResult();
}

class UpdateAvailable extends UpdateCheckResult {
  const UpdateAvailable(this.release);
  final ReleaseInfo release;
}

class UpToDate extends UpdateCheckResult {
  const UpToDate();
}

class UpdateCheckFailed extends UpdateCheckResult {
  const UpdateCheckFailed();
}

class UpdateException implements Exception {
  const UpdateException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Checks GitHub releases for a newer app version and, on Android, downloads,
/// verifies and installs the APK. Mirrors the legacy updater (latest release ->
/// compare -> download APK -> system installer), with verification and throttling.
class UpdateService extends ChangeNotifier with WidgetsBindingObserver {
  UpdateService({http.Client? client, Dio? dio, ApkInstaller installer = const ApkInstaller(), DateTime Function()? clock, bool? supported, bool? androidInstall})
      : _client = client ?? http.Client(),
        _dio = dio ?? Dio(),
        _installer = installer,
        _now = clock ?? DateTime.now,
        _supported = supported ?? (!storeBuild && !kIsWeb && (Platform.isAndroid || Platform.isIOS)),
        _androidInstall = androidInstall ?? (!kIsWeb && Platform.isAndroid);

  static final UpdateService instance = UpdateService();

  /// Minimum gap between automatic checks.
  static const checkInterval = Duration(hours: 6);

  /// After the user taps Later, the same version is not offered again automatically for this long.
  static const snoozeFor = Duration(hours: 24);

  static final latestReleaseUrl = Uri.parse('https://api.github.com/repos/$updateRepo/releases/latest');

  static const _autoKey = 'update.auto_check';
  static const _lastCheckKey = 'update.last_check';
  static const _snoozedVersionKey = 'update.snoozed_version';
  static const _snoozedAtKey = 'update.snoozed_at';

  final http.Client _client;
  final Dio _dio;
  final ApkInstaller _installer;
  final DateTime Function() _now;
  final bool _supported;
  final bool _androidInstall;

  /// The dev flavor checks the same repo but never nags: auto-check starts off.
  bool get isDevFlavor => appFlavor == 'dev';

  bool get supported => _supported;

  /// True when the update can be installed from inside the app (Android sideload).
  bool get canInstallInApp => _supported && _androidInstall;

  bool _autoCheck = true;
  bool get autoCheck => _autoCheck;

  String _installedVersion = '';
  String get installedVersion => _installedVersion;

  bool _checking = false;
  bool get checking => _checking;

  ReleaseInfo? _available;
  ReleaseInfo? get available => _available;

  DateTime? _lastCheck;
  DateTime? get lastCheck => _lastCheck;

  bool _dialogOpen = false;

  /// Set by the UI layer: shows the update dialog for a release.
  Future<void> Function(ReleaseInfo release)? presenter;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _autoCheck = prefs.getBool(_autoKey) ?? !isDevFlavor;
    final last = prefs.getInt(_lastCheckKey);
    _lastCheck = last == null ? null : DateTime.fromMillisecondsSinceEpoch(last);
    try {
      final info = await PackageInfo.fromPlatform().timeout(const Duration(seconds: 3));
      _installedVersion = info.version;
    } catch (_) {
      _installedVersion = '';
    }
    notifyListeners();
  }

  /// Starts the automatic check on launch and again when the app returns to the foreground.
  void start() {
    if (!_supported) return;
    WidgetsBinding.instance.addObserver(this);
    unawaited(autoCheckIfDue());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(autoCheckIfDue());
  }

  Future<void> setAutoCheck(bool value) async {
    if (_autoCheck == value) return;
    _autoCheck = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoKey, value);
  }

  /// Automatic check: only when enabled, at most once per [checkInterval], and quiet on failure.
  Future<void> autoCheckIfDue() async {
    if (!_supported || !_autoCheck || _checking || _dialogOpen) return;
    final last = _lastCheck;
    if (last != null && _now().difference(last) < checkInterval) return;

    final result = await check();
    if (result is! UpdateAvailable) return;
    if (await _isSnoozed(result.release)) return;
    await present(result.release);
  }

  /// Shows the update dialog, unless one is already open.
  Future<void> present(ReleaseInfo release) async {
    final show = presenter;
    if (show == null || _dialogOpen) return;
    _dialogOpen = true;
    try {
      await show(release);
    } finally {
      _dialogOpen = false;
    }
  }

  /// Checks GitHub for the latest release and compares it with the installed version.
  Future<UpdateCheckResult> check() async {
    if (!_supported) return const UpToDate();
    _checking = true;
    notifyListeners();
    try {
      final response = await _client.get(latestReleaseUrl, headers: const {
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
        'User-Agent': 'schuly-app',
      }).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return const UpdateCheckFailed();

      await _recordCheck();
      final release = ReleaseInfo.tryParse(jsonDecode(response.body));
      final installed = AppVersion.tryParse(_installedVersion);
      if (release == null || installed == null) return const UpdateCheckFailed();

      if (!release.version.isNewerThan(installed)) {
        _available = null;
        return const UpToDate();
      }
      // On Android an update needs the APK; without one (assets still uploading) there is nothing to install yet.
      if (canInstallInApp && release.apk == null) {
        _available = null;
        return const UpToDate();
      }
      _available = release;
      return UpdateAvailable(release);
    } catch (_) {
      return const UpdateCheckFailed();
    } finally {
      _checking = false;
      notifyListeners();
    }
  }

  Future<void> _recordCheck() async {
    _lastCheck = _now();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastCheckKey, _lastCheck!.millisecondsSinceEpoch);
  }

  Future<bool> _isSnoozed(ReleaseInfo release) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_snoozedVersionKey) != release.tag) return false;
    final at = prefs.getInt(_snoozedAtKey);
    if (at == null) return false;
    return _now().difference(DateTime.fromMillisecondsSinceEpoch(at)) < snoozeFor;
  }

  /// The user tapped Later: do not offer [release] again automatically for [snoozeFor].
  Future<void> snooze(ReleaseInfo release) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_snoozedVersionKey, release.tag);
    await prefs.setInt(_snoozedAtKey, _now().millisecondsSinceEpoch);
  }

  /// Downloads the APK into the app cache, verifies size and SHA-256, and returns the file path.
  Future<String> downloadAndVerify(ReleaseInfo release, {void Function(double progress)? onProgress, CancelToken? cancelToken}) async {
    final apk = release.apk;
    if (apk == null) throw const UpdateException('This release has no Android package yet.');

    final dir = Directory('${(await getTemporaryDirectory()).path}/updates');
    if (await dir.exists()) await dir.delete(recursive: true);
    await dir.create(recursive: true);
    final file = File('${dir.path}/${apk.name}');

    final expectedHash = apk.sha256 ?? await _fetchChecksum(release);

    try {
      await _dio.download(
        apk.url.toString(),
        file.path,
        cancelToken: cancelToken,
        // A stalled connection fails instead of leaving the progress bar frozen.
        options: Options(followRedirects: true, maxRedirects: 5, receiveTimeout: const Duration(seconds: 30)),
        onReceiveProgress: (received, total) {
          final denominator = total > 0 ? total : apk.size;
          if (denominator > 0) onProgress?.call((received / denominator).clamp(0.0, 1.0));
        },
      );
    } on DioException catch (e) {
      await _discard(file);
      if (CancelToken.isCancel(e)) rethrow;
      throw const UpdateException('The download failed. Check your connection and try again.');
    }

    if (await file.length() != apk.size) {
      await _discard(file);
      throw const UpdateException('The downloaded file is incomplete. Try again.');
    }
    if (expectedHash != null) {
      final actual = (await sha256.bind(file.openRead()).first).toString();
      if (actual != expectedHash) {
        await _discard(file);
        throw const UpdateException('The downloaded file failed its integrity check, so it was not installed.');
      }
    }
    return file.path;
  }

  Future<String?> _fetchChecksum(ReleaseInfo release) async {
    final asset = release.checksumFile;
    if (asset == null) return null;
    try {
      final response = await _client.get(asset.url).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return null;
      return RegExp(r'\b[0-9a-fA-F]{64}\b').firstMatch(response.body)?.group(0)?.toLowerCase();
    } catch (_) {
      return null;
    }
  }

  Future<void> _discard(File file) async {
    try {
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  Future<InstallLaunch> install(String path) => _installer.install(path);

  Future<void> openInstallSettings() => _installer.openInstallSettings();
}
