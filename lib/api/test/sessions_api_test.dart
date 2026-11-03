import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for SessionsApi
void main() {
  final instance = SchulyApi().getSessionsApi();

  group(SessionsApi, () {
    // Signs out everywhere else, keeping the calling session.
    //
    // Every other session ends; the refresh token the caller is holding keeps working. A caller whose token carries no `toa_sid` has no session to keep, so every one of them is revoked.
    //
    //Future toamaisutaaRevokeOtherSessions() async
    test('test toamaisutaaRevokeOtherSessions', () async {
      // TODO
    });

    // Revokes one session by its id.
    //
    // 404 covers both a session that does not exist and one belonging to someone else, so this cannot be used to discover another account's session ids. Revoking the caller's own is allowed and is exactly a sign-out.
    //
    //Future toamaisutaaRevokeSession(String sessionId) async
    test('test toamaisutaaRevokeSession', () async {
      // TODO
    });

    // Lists the sessions this user has open.
    //
    // One entry per refresh family, which is what `toa_sid` names - so a session here survives every rotation. The caller's own comes back with `isCurrent` true, unless their token was issued by an identity provider rather than by this application, in which case no entry is current.
    //
    //Future<BuiltList<SessionSummary>> toamaisutaaSessions() async
    test('test toamaisutaaSessions', () async {
      // TODO
    });

  });
}
