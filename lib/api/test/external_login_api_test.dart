import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for ExternalLoginApi
void main() {
  final instance = SchulyApi().getExternalLoginApi();

  group(ExternalLoginApi, () {
    // Where the provider sends the browser back. Register this address with the provider.
    //
    // Not for clients to call. Redirects to the `returnUrl` the sign-in began with; answers 400 only when the answer belongs to no sign-in begun here, since then there is nowhere safe to send it.
    //
    //Future toamaisutaaExternalCallback(String provider, { String code, String state, String error }) async
    test('test toamaisutaaExternalCallback', () async {
      // TODO
    });

    // Exchanges the code a provider sign-in returned for tokens.
    //
    // Send `{ \"code\": \"...\", \"codeVerifier\": \"...\" }`. Returns the same two shapes `/auth/login` does: tokens with `fed` in `amr`, or a second-factor challenge for `/auth/2fa/verify`. A code is spent by the first attempt, right verifier or not.
    //
    //Future<TwoFactorChallengeResponse> toamaisutaaExternalExchange(ExternalLoginExchangeRequest externalLoginExchangeRequest) async
    test('test toamaisutaaExternalExchange', () async {
      // TODO
    });

    // Starts linking a provider to the caller's account.
    //
    // Send `returnUrl` and the proof passkey registration takes: `code` where the account has a second factor, `currentPassword` where it has a password, otherwise nothing beyond a sign-in within `ExternalLogin:LinkProofWindow`. Navigate the browser to `authorization_url`; it comes back to `returnUrl` with `linked`, or `error`: `linked_to_another_account`, `provider_already_linked` or `external_login_failed`.
    //
    //Future<ExternalLinkResponse> toamaisutaaExternalLink(String provider, LinkExternalLoginRequest linkExternalLoginRequest) async
    test('test toamaisutaaExternalLink', () async {
      // TODO
    });

    // Lists the providers linked to the caller's account.
    //
    //Future<BuiltList<ExternalLoginResponse>> toamaisutaaExternalLogins() async
    test('test toamaisutaaExternalLogins', () async {
      // TODO
    });

    // Lists the identity providers a user can sign in with.
    //
    // Anonymous, so a sign-in page can draw a button per entry. `key` is what the other routes take.
    //
    //Future<BuiltList<ExternalProviderResponse>> toamaisutaaExternalProviders() async
    test('test toamaisutaaExternalProviders', () async {
      // TODO
    });

    // Sends the browser to a provider to sign in.
    //
    // Navigate here, do not fetch it. Query: `returnUrl`, exactly one of `ExternalLogin:AllowedReturnUrls`; `codeChallenge`, the base64url SHA-256 of a random verifier the client keeps; `codeChallengeMethod=S256`; and optionally `state`, handed back untouched.  The browser comes back to `returnUrl` with `code`, to exchange at `/exchange` with the verifier, or with `error`: `access_denied`, `account_exists`, `account_not_found` or `external_login_failed`.
    //
    //Future toamaisutaaExternalStart(String provider, { String returnUrl, String codeChallenge, String codeChallengeMethod, String state }) async
    test('test toamaisutaaExternalStart', () async {
      // TODO
    });

    // Unlinks a provider. Takes the same proof linking does.
    //
    // Refused with 400 when it is the account's only way to sign in. Unlinking ends every session on the account, this one included, since the usual reason to remove a provider is that somebody else linked it.
    //
    //Future toamaisutaaExternalUnlink(String provider, { UnlinkExternalLoginRequest unlinkExternalLoginRequest }) async
    test('test toamaisutaaExternalUnlink', () async {
      // TODO
    });

  });
}
