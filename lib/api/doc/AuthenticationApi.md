# schuly_api.api.AuthenticationApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**toamaisutaaChangeEmail**](AuthenticationApi.md#toamaisutaachangeemail) | **POST** /auth/email | Sends a verification link to an address, and changes nothing yet.
[**toamaisutaaChangePassword**](AuthenticationApi.md#toamaisutaachangepassword) | **POST** /auth/password | Sets a first password or changes an existing one.
[**toamaisutaaForgotPassword**](AuthenticationApi.md#toamaisutaaforgotpassword) | **POST** /auth/password/forgot | Requests a password reset link.
[**toamaisutaaLogin**](AuthenticationApi.md#toamaisutaalogin) | **POST** /auth/login | Signs in with a password, or asks for a second factor.
[**toamaisutaaLogout**](AuthenticationApi.md#toamaisutaalogout) | **POST** /auth/logout | Revokes the presented refresh token&#39;s family.
[**toamaisutaaRefresh**](AuthenticationApi.md#toamaisutaarefresh) | **POST** /auth/refresh | Exchanges a refresh token for a new pair, rotating it.
[**toamaisutaaRegister**](AuthenticationApi.md#toamaisutaaregister) | **POST** /auth/register | Creates a local account and signs it in.
[**toamaisutaaResetPassword**](AuthenticationApi.md#toamaisutaaresetpassword) | **POST** /auth/password/reset | Redeems a reset token and sets a new password.
[**toamaisutaaVerifyEmail**](AuthenticationApi.md#toamaisutaaverifyemail) | **POST** /auth/email/verify | Redeems a verification token and writes the address it names.


# **toamaisutaaChangeEmail**
> toamaisutaaChangeEmail(changeEmailRequest)

Sends a verification link to an address, and changes nothing yet.

`currentPassword` is required, including when `newEmail` is the address the account already has - which is how a verification link is asked for again. The account moves only when the link is redeemed at /auth/email/verify. A wrong `currentPassword` counts toward the account lockout.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final ChangeEmailRequest changeEmailRequest = ; // ChangeEmailRequest | 

try {
    api.toamaisutaaChangeEmail(changeEmailRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaChangeEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changeEmailRequest** | [**ChangeEmailRequest**](ChangeEmailRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaChangePassword**
> toamaisutaaChangePassword(changePasswordRequest)

Sets a first password or changes an existing one.

Send `currentPassword` when the account already has one and omit it when an identity provider owns the account and it is gaining its first. A wrong `currentPassword` counts toward the account lockout.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final ChangePasswordRequest changePasswordRequest = ; // ChangePasswordRequest | 

try {
    api.toamaisutaaChangePassword(changePasswordRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaChangePassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **changePasswordRequest** | [**ChangePasswordRequest**](ChangePasswordRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaForgotPassword**
> toamaisutaaForgotPassword(forgotPasswordRequest)

Requests a password reset link.

Always 204 - for an unknown address and for an account an identity provider owns alike. The log says which.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final ForgotPasswordRequest forgotPasswordRequest = ; // ForgotPasswordRequest | 

try {
    api.toamaisutaaForgotPassword(forgotPasswordRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaForgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgotPasswordRequest** | [**ForgotPasswordRequest**](ForgotPasswordRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaLogin**
> TokenResponse toamaisutaaLogin(loginRequest)

Signs in with a password, or asks for a second factor.

**Two success shapes, both 200.** Usually a token pair. For a user with a confirmed second factor it is instead a challenge and no tokens:  ```json { \"two_factor_required\": true, \"challenge\": \"No1CXq9-...\", \"expires_in\": 300 } ```  Branch on `two_factor_required`, which is absent from the token shape. Present the challenge with a code to `/auth/2fa/verify` to finish signing in.  With `LocalLogin:RequireVerifiedEmailForSignIn` on, an account whose address was never confirmed gets a third: `{ \"email_verification_required\": true, \"challenge\": \"...\", \"method\": \"code\", ... }`, answered at `/auth/email/verify-code`.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final LoginRequest loginRequest = ; // LoginRequest | 

try {
    final response = api.toamaisutaaLogin(loginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequest** | [**LoginRequest**](LoginRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaLogout**
> toamaisutaaLogout(logoutRequest)

Revokes the presented refresh token's family.

Always 204. Whether that token existed is not the caller's business. Trusted devices are deliberately left alone - signing out is not a security event.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final LogoutRequest logoutRequest = ; // LogoutRequest | 

try {
    api.toamaisutaaLogout(logoutRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaLogout: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logoutRequest** | [**LogoutRequest**](LogoutRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaRefresh**
> TokenResponse toamaisutaaRefresh(refreshRequest)

Exchanges a refresh token for a new pair, rotating it.

Presenting a token that has already been rotated revokes the whole family, and every trusted device with it.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final RefreshRequest refreshRequest = ; // RefreshRequest | 

try {
    final response = api.toamaisutaaRefresh(refreshRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaRefresh: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshRequest** | [**RefreshRequest**](RefreshRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaRegister**
> TokenResponse toamaisutaaRegister(registerRequest)

Creates a local account and signs it in.

Mapped only when `LocalLogin:AllowSelfRegistration` is true. With `LocalLogin:RequireVerifiedEmailForSignIn` on, `email` is required and the 201 carries an email-verification challenge instead of tokens; a code has been mailed to the address.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final RegisterRequest registerRequest = ; // RegisterRequest | 

try {
    final response = api.toamaisutaaRegister(registerRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerRequest** | [**RegisterRequest**](RegisterRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaResetPassword**
> toamaisutaaResetPassword(resetPasswordRequest)

Redeems a reset token and sets a new password.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final ResetPasswordRequest resetPasswordRequest = ; // ResetPasswordRequest | 

try {
    api.toamaisutaaResetPassword(resetPasswordRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordRequest** | [**ResetPasswordRequest**](ResetPasswordRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaVerifyEmail**
> toamaisutaaVerifyEmail(verifyEmailRequest)

Redeems a verification token and writes the address it names.

Anonymous, because the link is opened from a mailbox and often on another device. The token is what proves anything here.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthenticationApi();
final VerifyEmailRequest verifyEmailRequest = ; // VerifyEmailRequest | 

try {
    api.toamaisutaaVerifyEmail(verifyEmailRequest);
} catch on DioException (e) {
    print('Exception when calling AuthenticationApi->toamaisutaaVerifyEmail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyEmailRequest** | [**VerifyEmailRequest**](VerifyEmailRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

