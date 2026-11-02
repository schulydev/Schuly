import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/private_link_service.dart';

void main() {
  const redirect = 'https://login.microsoftonline.com/common/oauth2/nativeclient';

  test('captures the authorization code from the redirect', () {
    final r = privateLinkRedirect('$redirect?code=abc123&state=xyz', redirect);
    expect(r, isNotNull);
    expect(r!.code, 'abc123');
    expect(r.error, isNull);
  });

  test('ignores pages that are not the redirect', () {
    expect(privateLinkRedirect('https://login.microsoftonline.com/common/oauth2/v2.0/authorize?x=1', redirect), isNull);
    expect(privateLinkRedirect('https://login.live.com/ppsecure/post.srf', redirect), isNull);
  });

  test('ignores the redirect page before it carries a code', () {
    expect(privateLinkRedirect(redirect, redirect), isNull);
  });

  test('surfaces an error from the redirect', () {
    final r = privateLinkRedirect('$redirect?error=access_denied&error_description=blocked+by+policy', redirect);
    expect(r, isNotNull);
    expect(r!.code, isNull);
    expect(r.error, 'blocked by policy');
  });
}
