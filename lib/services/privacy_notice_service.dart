import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';
import 'app_mode_service.dart';
import 'backend_dio.dart';

const kPrivacyPolicyUrl = 'https://schuly.dev/privacy';

/// The notice a user still has to confirm: its version, where the policy is, and
/// whether this server also asks for the Swiss-school confirmation.
@immutable
class PrivacyNoticeInfo {
  final String version;
  final String url;
  final bool swissSchoolConfirmationRequired;
  const PrivacyNoticeInfo({required this.version, required this.url, required this.swissSchoolConfirmationRequired});
}

/// The server calls behind [PrivacyNoticeService], a seam for tests.
abstract class PrivacyNoticeBackend {
  /// Account mode: what is still open for the signed-in user, or null.
  Future<PrivacyNoticeInfo?> fetchForAccount();
  Future<void> acceptForAccount(String version, bool swissSchoolConfirmed);

  /// Private mode: what the server asks of everyone. Anonymous, on a clean client.
  Future<PrivacyNoticeInfo?> fetchPublic();
}

class HttpPrivacyNoticeBackend implements PrivacyNoticeBackend {
  static final Dio _dio = backendDio(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 15));
  static const _handled = <String, dynamic>{ApiClient.handlesErrors: true};

  @override
  Future<PrivacyNoticeInfo?> fetchForAccount() async {
    final status = (await ApiClient.instance.api.getAuthApi().apiAuthMePrivacyNoticeGet(extra: _handled)).data;
    if (status == null || !status.acceptanceRequired) return null;
    return PrivacyNoticeInfo(version: status.policyVersion, url: status.policyUrl, swissSchoolConfirmationRequired: status.swissSchoolConfirmationRequired);
  }

  @override
  Future<void> acceptForAccount(String version, bool swissSchoolConfirmed) async {
    await ApiClient.instance.api.getAuthApi().apiAuthMePrivacyNoticePost(
          acceptPrivacyNoticeCommand: AcceptPrivacyNoticeCommand((b) => b
            ..policyVersion = version
            ..swissSchoolConfirmed = swissSchoolConfirmed),
          extra: _handled,
        );
  }

  @override
  Future<PrivacyNoticeInfo?> fetchPublic() async {
    final app = (await _dio.get<Map<String, dynamic>>('/api/app')).data;
    final version = app?['policyVersion'] as String?;
    // A server from before the notice has nothing to ask.
    if (version == null) return null;
    return PrivacyNoticeInfo(
      version: version,
      url: app?['policyUrl'] as String? ?? kPrivacyPolicyUrl,
      swissSchoolConfirmationRequired: app?['swissSchoolConfirmationRequired'] as bool? ?? false,
    );
  }
}

/// Decides whether the user still has to confirm the notice, and records it: on the
/// server in account mode, and on this device in private mode, which has no server record.
class PrivacyNoticeService {
  PrivacyNoticeService(this._backend);

  static PrivacyNoticeService instance = PrivacyNoticeService(HttpPrivacyNoticeBackend());

  static const versionKey = 'privacy.notice.version';
  static const acceptedAtKey = 'privacy.notice.acceptedAt';
  static const swissConfirmedAtKey = 'privacy.notice.swissConfirmedAt';

  final PrivacyNoticeBackend _backend;

  /// What is still open, or null. A failed check asks nothing: the notice must never keep anyone from their data.
  Future<PrivacyNoticeInfo?> pending() async {
    try {
      if (!AppModeService.instance.isPrivate) return await _backend.fetchForAccount();

      final info = await _backend.fetchPublic();
      if (info == null) return null;
      final prefs = await SharedPreferences.getInstance();
      final confirmed = prefs.getString(versionKey) == info.version;
      final swissOpen = info.swissSchoolConfirmationRequired && prefs.getString(swissConfirmedAtKey) == null;
      return confirmed && !swissOpen ? null : info;
    } catch (e) {
      debugPrint('PrivacyNoticeService: check skipped ($e)');
      return null;
    }
  }

  Future<void> accept(PrivacyNoticeInfo info, {required bool swissSchoolConfirmed}) async {
    if (!AppModeService.instance.isPrivate) {
      await _backend.acceptForAccount(info.version, swissSchoolConfirmed);
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toUtc().toIso8601String();
    await prefs.setString(versionKey, info.version);
    await prefs.setString(acceptedAtKey, now);
    if (info.swissSchoolConfirmationRequired && swissSchoolConfirmed) await prefs.setString(swissConfirmedAtKey, now);
  }

  /// Forgets the device record when private mode is left, so the next person is asked.
  static Future<void> clearDeviceRecord() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(versionKey);
    await prefs.remove(acceptedAtKey);
    await prefs.remove(swissConfirmedAtKey);
  }
}
