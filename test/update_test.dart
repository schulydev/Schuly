import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/update/app_version.dart';
import 'package:schuly/services/update/release_info.dart';

const _sha = 'a3f1c0d2e4b5a6978877665544332211a3f1c0d2e4b5a6978877665544332211';

Map<String, dynamic> _release({String tag = 'v3.1.0', List<Map<String, dynamic>>? assets, bool draft = false, bool pre = false, String? htmlUrl}) => {
      'tag_name': tag,
      'draft': draft,
      'prerelease': pre,
      'body': '  ## Highlights\n- Auto update\n',
      'html_url': htmlUrl ?? 'https://github.com/schulydev/Schuly/releases/tag/$tag',
      'assets': assets ??
          [
            _asset('schuly-$tag.apk', tag, size: 1000, digest: 'sha256:$_sha'),
            _asset('schuly-$tag.aab', tag, size: 900),
            _asset('schuly-$tag.apk.sha256', tag, size: 90),
          ],
    };

Map<String, dynamic> _asset(String name, String tag, {int size = 1, String? digest, String? url}) => {
      'name': name,
      'size': size,
      'digest': digest,
      'browser_download_url': url ?? 'https://github.com/schulydev/Schuly/releases/download/$tag/$name',
    };

void main() {
  group('AppVersion', () {
    test('parses tags, build names and flavored names', () {
      expect(AppVersion.tryParse('v3.1.0'), const AppVersion(3, 1, 0));
      expect(AppVersion.tryParse('3.0.0'), const AppVersion(3, 0, 0));
      expect(AppVersion.tryParse('3.0.0-DEV'), const AppVersion(3, 0, 0));
      expect(AppVersion.tryParse('3.0.0+7'), const AppVersion(3, 0, 0));
      expect(AppVersion.tryParse('3.1'), const AppVersion(3, 1, 0));
      expect(AppVersion.tryParse('nightly'), isNull);
      expect(AppVersion.tryParse(''), isNull);
      expect(AppVersion.tryParse(null), isNull);
    });

    test('compares numerically, not lexically', () {
      expect(AppVersion.tryParse('v3.10.0')!.isNewerThan(AppVersion.tryParse('3.9.9')!), isTrue);
      expect(AppVersion.tryParse('v3.0.1')!.isNewerThan(AppVersion.tryParse('3.0.0')!), isTrue);
      expect(AppVersion.tryParse('v4.0.0')!.isNewerThan(AppVersion.tryParse('3.99.99')!), isTrue);
      expect(AppVersion.tryParse('v3.0.0')!.isNewerThan(AppVersion.tryParse('3.0.0-DEV')!), isFalse);
      expect(AppVersion.tryParse('v2.7.0')!.isNewerThan(AppVersion.tryParse('3.0.0')!), isFalse);
    });
  });

  group('ReleaseInfo.tryParse', () {
    test('accepts a well-formed release', () {
      final r = ReleaseInfo.tryParse(_release())!;
      expect(r.tag, 'v3.1.0');
      expect(r.version, const AppVersion(3, 1, 0));
      expect(r.notes, startsWith('## Highlights'));
      expect(r.apk!.name, 'schuly-v3.1.0.apk');
      expect(r.apk!.size, 1000);
      expect(r.apk!.sha256, _sha);
      expect(r.checksumFile!.name, 'schuly-v3.1.0.apk.sha256');
    });

    test('works from raw JSON text', () {
      expect(ReleaseInfo.tryParse(jsonDecode(jsonEncode(_release()))), isNotNull);
    });

    test('ignores aab and picks only the matching apk', () {
      final r = ReleaseInfo.tryParse(_release(assets: [
        _asset('schuly-v3.1.0.aab', 'v3.1.0', size: 5),
        _asset('other.apk', 'v3.1.0', size: 5),
        _asset('schuly-v3.0.0.apk', 'v3.1.0', size: 5),
      ]))!;
      expect(r.apk, isNull);
    });

    test('release without assets parses but has no apk', () {
      final r = ReleaseInfo.tryParse(_release(assets: []))!;
      expect(r.apk, isNull);
      expect(r.checksumFile, isNull);
    });

    test('rejects drafts, prereleases and bad tags', () {
      expect(ReleaseInfo.tryParse(_release(draft: true)), isNull);
      expect(ReleaseInfo.tryParse(_release(pre: true)), isNull);
      expect(ReleaseInfo.tryParse(_release(tag: 'v3.1')), isNull);
      expect(ReleaseInfo.tryParse(_release(tag: 'nightly')), isNull);
      expect(ReleaseInfo.tryParse('nope'), isNull);
      expect(ReleaseInfo.tryParse(null), isNull);
    });

    test('rejects assets from another repo, host or scheme', () {
      for (final url in [
        'https://github.com/evil/Schuly/releases/download/v3.1.0/schuly-v3.1.0.apk',
        'http://github.com/schulydev/Schuly/releases/download/v3.1.0/schuly-v3.1.0.apk',
        'https://evil.com/schulydev/Schuly/releases/download/v3.1.0/schuly-v3.1.0.apk',
        'https://github.com.evil.com/schulydev/Schuly/releases/download/v3.1.0/schuly-v3.1.0.apk',
        'https://github.com/schulydev/Schuly/releases/download/v3.0.0/schuly-v3.1.0.apk',
      ]) {
        final r = ReleaseInfo.tryParse(_release(assets: [_asset('schuly-v3.1.0.apk', 'v3.1.0', size: 10, url: url)]))!;
        expect(r.apk, isNull, reason: url);
      }
    });

    test('rejects a release page outside the repo', () {
      expect(ReleaseInfo.tryParse(_release(htmlUrl: 'https://evil.com/schulydev/Schuly/releases/tag/v3.1.0')), isNull);
    });

    test('ignores malformed digests and zero-size apks', () {
      var r = ReleaseInfo.tryParse(_release(assets: [_asset('schuly-v3.1.0.apk', 'v3.1.0', size: 10, digest: 'sha1:abc')]))!;
      expect(r.apk!.sha256, isNull);
      r = ReleaseInfo.tryParse(_release(assets: [_asset('schuly-v3.1.0.apk', 'v3.1.0', size: 0)]))!;
      expect(r.apk, isNull);
    });
  });
}
