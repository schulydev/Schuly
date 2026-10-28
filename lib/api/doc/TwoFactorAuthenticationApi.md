# schuly_api.api.TwoFactorAuthenticationApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**toamaisutaaStepUp**](TwoFactorAuthenticationApi.md#toamaisutaastepup) | **POST** /auth/2fa/step-up | Asks for a second factor from a session that is already signed in.
[**toamaisutaaStepUpVerify**](TwoFactorAuthenticationApi.md#toamaisutaastepupverify) | **POST** /auth/2fa/step-up/verify | Completes a step-up and returns a new access token for the same session.
[**toamaisutaaTwoFactorBegin**](TwoFactorAuthenticationApi.md#toamaisutaatwofactorbegin) | **POST** /auth/2fa/begin | Generates a secret and stores it unconfirmed. Enables nothing.
[**toamaisutaaTwoFactorConfirm**](TwoFactorAuthenticationApi.md#toamaisutaatwofactorconfirm) | **POST** /auth/2fa/confirm | Proves the authenticator holds the secret, and turns the second factor on.
[**toamaisutaaTwoFactorDisable**](TwoFactorAuthenticationApi.md#toamaisutaatwofactordisable) | **POST** /auth/2fa/disable | Turns the second factor off. Requires a current code as proof.
[**toamaisutaaTwoFactorRecoveryCodes**](TwoFactorAuthenticationApi.md#toamaisutaatwofactorrecoverycodes) | **POST** /auth/2fa/recovery-codes | Issues a fresh set of recovery codes and invalidates every previous one.
[**toamaisutaaTwoFactorStatus**](TwoFactorAuthenticationApi.md#toamaisutaatwofactorstatus) | **GET** /auth/2fa | Whether the caller has enrolled, and how many recovery codes remain.
[**toamaisutaaTwoFactorVerify**](TwoFactorAuthenticationApi.md#toamaisutaatwofactorverify) | **POST** /auth/2fa/verify | Finishes a sign-in that stopped for a second factor.


# **toamaisutaaStepUp**
> StepUpChallengeResponse toamaisutaaStepUp()

Asks for a second factor from a session that is already signed in.

For satisfying a freshness policy without signing out. Takes no body: who you are and which session you are on both come from your token. Present the challenge with a code to `/auth/2fa/step-up/verify`.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();

try {
    final response = api.toamaisutaaStepUp();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaStepUp: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**StepUpChallengeResponse**](StepUpChallengeResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaStepUpVerify**
> StepUpResponse toamaisutaaStepUpVerify(stepUpVerifyRequest)

Completes a step-up and returns a new access token for the same session.

**No refresh token comes back and none is needed** - your existing one keeps working. Replace only the access token. A wrong code counts toward lockout, and a recovery code works here and un-trusts every device, exactly as it does at sign-in.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final StepUpVerifyRequest stepUpVerifyRequest = ; // StepUpVerifyRequest | 

try {
    final response = api.toamaisutaaStepUpVerify(stepUpVerifyRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaStepUpVerify: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stepUpVerifyRequest** | [**StepUpVerifyRequest**](StepUpVerifyRequest.md)|  | 

### Return type

[**StepUpResponse**](StepUpResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorBegin**
> TwoFactorEnrolmentStarted toamaisutaaTwoFactorBegin(beginTwoFactorRequest)

Generates a secret and stores it unconfirmed. Enables nothing.

The response carries the TOTP secret in plaintext, twice - as base32 and inside the URI - because an authenticator cannot be enrolled without it. It is the one response here that is itself a long-lived credential. Never log it, and keep it out of any generic request or response logging you have.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final BeginTwoFactorRequest beginTwoFactorRequest = ; // BeginTwoFactorRequest | 

try {
    final response = api.toamaisutaaTwoFactorBegin(beginTwoFactorRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorBegin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **beginTwoFactorRequest** | [**BeginTwoFactorRequest**](BeginTwoFactorRequest.md)|  | [optional] 

### Return type

[**TwoFactorEnrolmentStarted**](TwoFactorEnrolmentStarted.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorConfirm**
> TwoFactorEnrolmentCompleted toamaisutaaTwoFactorConfirm(confirmTwoFactorRequest)

Proves the authenticator holds the secret, and turns the second factor on.

Returns the recovery codes, shown exactly once. Confirming also moves the user's security stamp, which invalidates the access token used to call this - refresh before the next request.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final ConfirmTwoFactorRequest confirmTwoFactorRequest = ; // ConfirmTwoFactorRequest | 

try {
    final response = api.toamaisutaaTwoFactorConfirm(confirmTwoFactorRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorConfirm: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **confirmTwoFactorRequest** | [**ConfirmTwoFactorRequest**](ConfirmTwoFactorRequest.md)|  | 

### Return type

[**TwoFactorEnrolmentCompleted**](TwoFactorEnrolmentCompleted.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorDisable**
> toamaisutaaTwoFactorDisable(disableTwoFactorRequest)

Turns the second factor off. Requires a current code as proof.

An authenticated session is not enough: a stolen access token must not be able to do this. Wrong codes count toward the account lockout.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final DisableTwoFactorRequest disableTwoFactorRequest = ; // DisableTwoFactorRequest | 

try {
    api.toamaisutaaTwoFactorDisable(disableTwoFactorRequest);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorDisable: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **disableTwoFactorRequest** | [**DisableTwoFactorRequest**](DisableTwoFactorRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorRecoveryCodes**
> TwoFactorEnrolmentCompleted toamaisutaaTwoFactorRecoveryCodes(regenerateRecoveryCodesRequest)

Issues a fresh set of recovery codes and invalidates every previous one.

Shown exactly once, and never logged. Same proof requirement as disabling.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final RegenerateRecoveryCodesRequest regenerateRecoveryCodesRequest = ; // RegenerateRecoveryCodesRequest | 

try {
    final response = api.toamaisutaaTwoFactorRecoveryCodes(regenerateRecoveryCodesRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorRecoveryCodes: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **regenerateRecoveryCodesRequest** | [**RegenerateRecoveryCodesRequest**](RegenerateRecoveryCodesRequest.md)|  | 

### Return type

[**TwoFactorEnrolmentCompleted**](TwoFactorEnrolmentCompleted.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorStatus**
> TwoFactorStatus toamaisutaaTwoFactorStatus()

Whether the caller has enrolled, and how many recovery codes remain.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();

try {
    final response = api.toamaisutaaTwoFactorStatus();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorStatus: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**TwoFactorStatus**](TwoFactorStatus.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTwoFactorVerify**
> TokenResponse toamaisutaaTwoFactorVerify(verifyTwoFactorRequest)

Finishes a sign-in that stopped for a second factor.

Anonymous, because the caller holds no token yet - the challenge is the credential. `code` takes a TOTP code or a recovery code. Set `rememberDevice` to receive a `device_token` alongside the tokens.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTwoFactorAuthenticationApi();
final VerifyTwoFactorRequest verifyTwoFactorRequest = ; // VerifyTwoFactorRequest | 

try {
    final response = api.toamaisutaaTwoFactorVerify(verifyTwoFactorRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TwoFactorAuthenticationApi->toamaisutaaTwoFactorVerify: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **verifyTwoFactorRequest** | [**VerifyTwoFactorRequest**](VerifyTwoFactorRequest.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

