/// A `major.minor.patch` version, parsed leniently from a release tag (`v3.1.0`),
/// a build name (`3.0.0`, `v3.0.0`) or a flavored build name (`3.0.0-DEV`, `3.0.0+1`).
///
/// Anything after the third number (a `-DEV` flavor suffix, `+build`) is ignored on
/// purpose: the dev flavor must compare equal to the release it was built from.
class AppVersion implements Comparable<AppVersion> {
  const AppVersion(this.major, this.minor, this.patch);

  final int major;
  final int minor;
  final int patch;

  static final _pattern = RegExp(r'^[vV]?(\d+)(?:\.(\d+))?(?:\.(\d+))?(?:[-+].*)?$');

  /// Returns null when [raw] is not a version.
  static AppVersion? tryParse(String? raw) {
    final match = _pattern.firstMatch((raw ?? '').trim());
    if (match == null) return null;
    int part(int i) => int.tryParse(match.group(i) ?? '0') ?? 0;
    return AppVersion(part(1), part(2), part(3));
  }

  bool isNewerThan(AppVersion other) => compareTo(other) > 0;

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  @override
  bool operator ==(Object other) => other is AppVersion && compareTo(other) == 0;

  @override
  int get hashCode => Object.hash(major, minor, patch);

  @override
  String toString() => '$major.$minor.$patch';
}
