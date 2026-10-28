import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for TwoFactorAuthenticationApi
void main() {
  final instance = SchulyApi().getTwoFactorAuthenticationApi();

  group(TwoFactorAuthenticationApi, () {
    // Asks for a second factor from a session that is already signed in.
    //
    // For satisfying a freshness policy without signing out. Takes no body: who you are and which session you are on both come from your token. Present the challenge with a code to `/auth/2fa/step-up/verify`.
    //
    //Future<StepUpChallengeResponse> toamaisutaaStepUp() async
    test('test toamaisutaaStepUp', () async {
      // TODO
    });

    // Completes a step-up and returns a new access token for the same session.
    //
    // **No refresh token comes back and none is needed** - your existing one keeps working. Replace only the access token. A wrong code counts toward lockout, and a recovery code works here and un-trusts every device, exactly as it does at sign-in.
    //
    //Future<StepUpResponse> toamaisutaaStepUpVerify(StepUpVerifyRequest stepUpVerifyRequest) async
    test('test toamaisutaaStepUpVerify', () async {
      // TODO
    });

    // Generates a secret and stores it unconfirmed. Enables nothing.
    //
    // The response carries the TOTP secret in plaintext, twice - as base32 and inside the URI - because an authenticator cannot be enrolled without it. It is the one response here that is itself a long-lived credential. Never log it, and keep it out of any generic request or response logging you have.
    //
    //Future<TwoFactorEnrolmentStarted> toamaisutaaTwoFactorBegin({ BeginTwoFactorRequest beginTwoFactorRequest }) async
    test('test toamaisutaaTwoFactorBegin', () async {
      // TODO
    });

    // Proves the authenticator holds the secret, and turns the second factor on.
    //
    // Returns the recovery codes, shown exactly once. Confirming also moves the user's security stamp, which invalidates the access token used to call this - refresh before the next request.
    //
    //Future<TwoFactorEnrolmentCompleted> toamaisutaaTwoFactorConfirm(ConfirmTwoFactorRequest confirmTwoFactorRequest) async
    test('test toamaisutaaTwoFactorConfirm', () async {
      // TODO
    });

    // Turns the second factor off. Requires a current code as proof.
    //
    // An authenticated session is not enough: a stolen access token must not be able to do this. Wrong codes count toward the account lockout.
    //
    //Future toamaisutaaTwoFactorDisable(DisableTwoFactorRequest disableTwoFactorRequest) async
    test('test toamaisutaaTwoFactorDisable', () async {
      // TODO
    });

    // Issues a fresh set of recovery codes and invalidates every previous one.
    //
    // Shown exactly once, and never logged. Same proof requirement as disabling.
    //
    //Future<TwoFactorEnrolmentCompleted> toamaisutaaTwoFactorRecoveryCodes(RegenerateRecoveryCodesRequest regenerateRecoveryCodesRequest) async
    test('test toamaisutaaTwoFactorRecoveryCodes', () async {
      // TODO
    });

    // Whether the caller has enrolled, and how many recovery codes remain.
    //
    //Future<TwoFactorStatus> toamaisutaaTwoFactorStatus() async
    test('test toamaisutaaTwoFactorStatus', () async {
      // TODO
    });

    // Finishes a sign-in that stopped for a second factor.
    //
    // Anonymous, because the caller holds no token yet - the challenge is the credential. `code` takes a TOTP code or a recovery code. Set `rememberDevice` to receive a `device_token` alongside the tokens.
    //
    //Future<TokenResponse> toamaisutaaTwoFactorVerify(VerifyTwoFactorRequest verifyTwoFactorRequest) async
    test('test toamaisutaaTwoFactorVerify', () async {
      // TODO
    });

  });
}
