# schuly_api.api.ExternalLoginApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**toamaisutaaExternalCallback**](ExternalLoginApi.md#toamaisutaaexternalcallback) | **GET** /auth/external/{provider}/callback | Where the provider sends the browser back. Register this address with the provider.
[**toamaisutaaExternalExchange**](ExternalLoginApi.md#toamaisutaaexternalexchange) | **POST** /auth/external/exchange | Exchanges the code a provider sign-in returned for tokens.
[**toamaisutaaExternalLink**](ExternalLoginApi.md#toamaisutaaexternallink) | **POST** /auth/external/{provider}/link | Starts linking a provider to the caller&#39;s account.
[**toamaisutaaExternalLogins**](ExternalLoginApi.md#toamaisutaaexternallogins) | **GET** /auth/external/logins | Lists the providers linked to the caller&#39;s account.
[**toamaisutaaExternalProviders**](ExternalLoginApi.md#toamaisutaaexternalproviders) | **GET** /auth/providers | Lists the identity providers a user can sign in with.
[**toamaisutaaExternalStart**](ExternalLoginApi.md#toamaisutaaexternalstart) | **GET** /auth/external/{provider}/start | Sends the browser to a provider to sign in.
[**toamaisutaaExternalUnlink**](ExternalLoginApi.md#toamaisutaaexternalunlink) | **DELETE** /auth/external/logins/{provider} | Unlinks a provider. Takes the same proof linking does.


# **toamaisutaaExternalCallback**
> toamaisutaaExternalCallback(provider, code, state, error)

Where the provider sends the browser back. Register this address with the provider.

Not for clients to call. Redirects to the `returnUrl` the sign-in began with; answers 400 only when the answer belongs to no sign-in begun here, since then there is nowhere safe to send it.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();
final String provider = provider_example; // String | 
final String code = code_example; // String | 
final String state = state_example; // String | 
final String error = error_example; // String | 

try {
    api.toamaisutaaExternalCallback(provider, code, state, error);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalCallback: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **provider** | **String**|  | 
 **code** | **String**|  | [optional] 
 **state** | **String**|  | [optional] 
 **error** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalExchange**
> TwoFactorChallengeResponse toamaisutaaExternalExchange(externalLoginExchangeRequest)

Exchanges the code a provider sign-in returned for tokens.

Send `{ \"code\": \"...\", \"codeVerifier\": \"...\" }`. Returns the same two shapes `/auth/login` does: tokens with `fed` in `amr`, or a second-factor challenge for `/auth/2fa/verify`. A code is spent by the first attempt, right verifier or not.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();
final ExternalLoginExchangeRequest externalLoginExchangeRequest = ; // ExternalLoginExchangeRequest | 

try {
    final response = api.toamaisutaaExternalExchange(externalLoginExchangeRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalExchange: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **externalLoginExchangeRequest** | [**ExternalLoginExchangeRequest**](ExternalLoginExchangeRequest.md)|  | 

### Return type

[**TwoFactorChallengeResponse**](TwoFactorChallengeResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalLink**
> ExternalLinkResponse toamaisutaaExternalLink(provider, linkExternalLoginRequest)

Starts linking a provider to the caller's account.

Send `returnUrl` and the proof passkey registration takes: `code` where the account has a second factor, `currentPassword` where it has a password, otherwise nothing beyond a sign-in within `ExternalLogin:LinkProofWindow`. Navigate the browser to `authorization_url`; it comes back to `returnUrl` with `linked`, or `error`: `linked_to_another_account`, `provider_already_linked` or `external_login_failed`.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();
final String provider = provider_example; // String | 
final LinkExternalLoginRequest linkExternalLoginRequest = ; // LinkExternalLoginRequest | 

try {
    final response = api.toamaisutaaExternalLink(provider, linkExternalLoginRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalLink: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **provider** | **String**|  | 
 **linkExternalLoginRequest** | [**LinkExternalLoginRequest**](LinkExternalLoginRequest.md)|  | 

### Return type

[**ExternalLinkResponse**](ExternalLinkResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalLogins**
> BuiltList<ExternalLoginResponse> toamaisutaaExternalLogins()

Lists the providers linked to the caller's account.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();

try {
    final response = api.toamaisutaaExternalLogins();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalLogins: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ExternalLoginResponse&gt;**](ExternalLoginResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalProviders**
> BuiltList<ExternalProviderResponse> toamaisutaaExternalProviders()

Lists the identity providers a user can sign in with.

Anonymous, so a sign-in page can draw a button per entry. `key` is what the other routes take.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();

try {
    final response = api.toamaisutaaExternalProviders();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalProviders: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ExternalProviderResponse&gt;**](ExternalProviderResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalStart**
> toamaisutaaExternalStart(provider, returnUrl, codeChallenge, codeChallengeMethod, state)

Sends the browser to a provider to sign in.

Navigate here, do not fetch it. Query: `returnUrl`, exactly one of `ExternalLogin:AllowedReturnUrls`; `codeChallenge`, the base64url SHA-256 of a random verifier the client keeps; `codeChallengeMethod=S256`; and optionally `state`, handed back untouched.  The browser comes back to `returnUrl` with `code`, to exchange at `/exchange` with the verifier, or with `error`: `access_denied`, `account_exists`, `account_not_found` or `external_login_failed`.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();
final String provider = provider_example; // String | 
final String returnUrl = returnUrl_example; // String | 
final String codeChallenge = codeChallenge_example; // String | 
final String codeChallengeMethod = codeChallengeMethod_example; // String | 
final String state = state_example; // String | 

try {
    api.toamaisutaaExternalStart(provider, returnUrl, codeChallenge, codeChallengeMethod, state);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalStart: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **provider** | **String**|  | 
 **returnUrl** | **String**|  | [optional] 
 **codeChallenge** | **String**|  | [optional] 
 **codeChallengeMethod** | **String**|  | [optional] 
 **state** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaExternalUnlink**
> toamaisutaaExternalUnlink(provider, unlinkExternalLoginRequest)

Unlinks a provider. Takes the same proof linking does.

Refused with 400 when it is the account's only way to sign in. Unlinking ends every session on the account, this one included, since the usual reason to remove a provider is that somebody else linked it.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExternalLoginApi();
final String provider = provider_example; // String | 
final UnlinkExternalLoginRequest unlinkExternalLoginRequest = ; // UnlinkExternalLoginRequest | 

try {
    api.toamaisutaaExternalUnlink(provider, unlinkExternalLoginRequest);
} catch on DioException (e) {
    print('Exception when calling ExternalLoginApi->toamaisutaaExternalUnlink: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **provider** | **String**|  | 
 **unlinkExternalLoginRequest** | [**UnlinkExternalLoginRequest**](UnlinkExternalLoginRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

