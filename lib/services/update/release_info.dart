import 'app_version.dart';

/// The only repository updates are ever taken from.
const updateRepo = 'schulydev/Schuly';

/// A downloadable file attached to a release.
class ReleaseAsset {
  const ReleaseAsset({required this.name, required this.url, required this.size, this.sha256});

  final String name;
  final Uri url;
  final int size;

  /// Lower-case hex SHA-256 from the GitHub API `digest` field, when GitHub provides one.
  final String? sha256;
}

/// The latest published release, reduced to what the updater needs and only if it
/// passes every check: right repo, https, and an APK that matches `schuly-vX.Y.Z.apk`.
class ReleaseInfo {
  const ReleaseInfo({required this.tag, required this.version, required this.notes, required this.pageUrl, this.apk, this.checksumFile});

  final String tag;
  final AppVersion version;
  final String notes;

  /// The human-readable release page (used on iOS, and as a fallback everywhere).
  final Uri pageUrl;

  /// Null when the release carries no valid APK (e.g. assets are still uploading).
  final ReleaseAsset? apk;

  /// The `schuly-vX.Y.Z.apk.sha256` sidecar, used when the API gave no digest.
  final ReleaseAsset? checksumFile;

  static final _tagPattern = RegExp(r'^v\d+\.\d+\.\d+$');
  static final _digestPattern = RegExp(r'^sha256:([0-9a-fA-F]{64})$');
  static const _maxApkBytes = 500 * 1024 * 1024;

  /// Parses a GitHub `releases/latest` JSON object. Returns null for anything that is
  /// not a stable, well-formed release of [repo].
  static ReleaseInfo? tryParse(Object? json, {String repo = updateRepo}) {
    if (json is! Map) return null;
    if (json['draft'] == true || json['prerelease'] == true) return null;

    final tag = json['tag_name'];
    if (tag is! String || !_tagPattern.hasMatch(tag)) return null;
    final version = AppVersion.tryParse(tag);
    if (version == null) return null;

    final pageUrl = Uri.tryParse('${json['html_url']}');
    if (pageUrl == null || !_isRepoUrl(pageUrl, repo, '/releases/')) return null;

    final apkName = 'schuly-$tag.apk';
    ReleaseAsset? apk;
    ReleaseAsset? checksum;
    final assets = json['assets'];
    if (assets is List) {
      for (final raw in assets) {
        if (raw is! Map) continue;
        final name = raw['name'];
        if (name == apkName) {
          apk ??= _asset(raw, repo, tag, requireSize: true);
        } else if (name == '$apkName.sha256') {
          checksum ??= _asset(raw, repo, tag, requireSize: false);
        }
      }
    }
    if (apk != null && apk.size > _maxApkBytes) apk = null;

    final body = json['body'];
    return ReleaseInfo(
      tag: tag,
      version: version,
      notes: body is String ? body.trim() : '',
      pageUrl: pageUrl,
      apk: apk,
      checksumFile: apk == null ? null : checksum,
    );
  }

  static ReleaseAsset? _asset(Map raw, String repo, String tag, {required bool requireSize}) {
    final name = raw['name'] as String;
    final url = Uri.tryParse('${raw['browser_download_url']}');
    if (url == null || !_isRepoUrl(url, repo, '/releases/download/$tag/$name', exact: true)) return null;
    final size = raw['size'];
    if (size is! int || (requireSize && size <= 0)) return null;
    final digest = raw['digest'];
    final hex = digest is String ? _digestPattern.firstMatch(digest)?.group(1) : null;
    return ReleaseAsset(name: name, url: url, size: size, sha256: hex?.toLowerCase());
  }

  /// True only for https://github.com/REPO plus PATH, and nothing else.
  static bool _isRepoUrl(Uri url, String repo, String path, {bool exact = false}) {
    if (url.scheme != 'https' || url.host != 'github.com' || url.hasPort || url.userInfo.isNotEmpty) return false;
    final prefix = '/$repo$path';
    return exact ? url.path == prefix : url.path.startsWith(prefix);
  }
}
