import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AuthenticationApi
void main() {
  final instance = SchulyApi().getAuthenticationApi();

  group(AuthenticationApi, () {
    // Sends a verification link to an address, and changes nothing yet.
    //
    // `currentPassword` is required, including when `newEmail` is the address the account already has - which is how a verification link is asked for again. The account moves only when the link is redeemed at /auth/email/verify. A wrong `currentPassword` counts toward the account lockout.
    //
    //Future toamaisutaaChangeEmail(ChangeEmailRequest changeEmailRequest) async
    test('test toamaisutaaChangeEmail', () async {
      // TODO
    });

    // Sets a first password or changes an existing one.
    //
    // Send `currentPassword` when the account already has one and omit it when an identity provider owns the account and it is gaining its first. A wrong `currentPassword` counts toward the account lockout.
    //
    //Future toamaisutaaChangePassword(ChangePasswordRequest changePasswordRequest) async
    test('test toamaisutaaChangePassword', () async {
      // TODO
    });

    // Requests a password reset link.
    //
    // Always 204 - for an unknown address and for an account an identity provider owns alike. The log says which.
    //
    //Future toamaisutaaForgotPassword(ForgotPasswordRequest forgotPasswordRequest) async
    test('test toamaisutaaForgotPassword', () async {
      // TODO
    });

    // Signs in with a password, or asks for a second factor.
    //
    // **Two success shapes, both 200.** Usually a token pair. For a user with a confirmed second factor it is instead a challenge and no tokens:  ```json { \"two_factor_required\": true, \"challenge\": \"No1CXq9-...\", \"expires_in\": 300 } ```  Branch on `two_factor_required`, which is absent from the token shape. Present the challenge with a code to `/auth/2fa/verify` to finish signing in.
    //
    //Future<TokenResponse> toamaisutaaLogin(LoginRequest loginRequest) async
    test('test toamaisutaaLogin', () async {
      // TODO
    });

    // Revokes the presented refresh token's family.
    //
    // Always 204. Whether that token existed is not the caller's business. Trusted devices are deliberately left alone - signing out is not a security event.
    //
    //Future toamaisutaaLogout(LogoutRequest logoutRequest) async
    test('test toamaisutaaLogout', () async {
      // TODO
    });

    // Exchanges a refresh token for a new pair, rotating it.
    //
    // Presenting a token that has already been rotated revokes the whole family, and every trusted device with it.
    //
    //Future<TokenResponse> toamaisutaaRefresh(RefreshRequest refreshRequest) async
    test('test toamaisutaaRefresh', () async {
      // TODO
    });

    // Creates a local account and signs it in.
    //
    // Mapped only when `LocalLogin:AllowSelfRegistration` is true.
    //
    //Future<TokenResponse> toamaisutaaRegister(RegisterRequest registerRequest) async
    test('test toamaisutaaRegister', () async {
      // TODO
    });

    // Redeems a reset token and sets a new password.
    //
    //Future toamaisutaaResetPassword(ResetPasswordRequest resetPasswordRequest) async
    test('test toamaisutaaResetPassword', () async {
      // TODO
    });

    // Redeems a verification token and writes the address it names.
    //
    // Anonymous, because the link is opened from a mailbox and often on another device. The token is what proves anything here.
    //
    //Future toamaisutaaVerifyEmail(VerifyEmailRequest verifyEmailRequest) async
    test('test toamaisutaaVerifyEmail', () async {
      // TODO
    });

  });
}
