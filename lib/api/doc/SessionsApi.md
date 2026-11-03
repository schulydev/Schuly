# schuly_api.api.SessionsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**toamaisutaaRevokeOtherSessions**](SessionsApi.md#toamaisutaarevokeothersessions) | **DELETE** /auth/sessions | Signs out everywhere else, keeping the calling session.
[**toamaisutaaRevokeSession**](SessionsApi.md#toamaisutaarevokesession) | **DELETE** /auth/sessions/{sessionId} | Revokes one session by its id.
[**toamaisutaaSessions**](SessionsApi.md#toamaisutaasessions) | **GET** /auth/sessions | Lists the sessions this user has open.


# **toamaisutaaRevokeOtherSessions**
> toamaisutaaRevokeOtherSessions()

Signs out everywhere else, keeping the calling session.

Every other session ends; the refresh token the caller is holding keeps working. A caller whose token carries no `toa_sid` has no session to keep, so every one of them is revoked.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSessionsApi();

try {
    api.toamaisutaaRevokeOtherSessions();
} catch on DioException (e) {
    print('Exception when calling SessionsApi->toamaisutaaRevokeOtherSessions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaRevokeSession**
> toamaisutaaRevokeSession(sessionId)

Revokes one session by its id.

404 covers both a session that does not exist and one belonging to someone else, so this cannot be used to discover another account's session ids. Revoking the caller's own is allowed and is exactly a sign-out.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSessionsApi();
final String sessionId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.toamaisutaaRevokeSession(sessionId);
} catch on DioException (e) {
    print('Exception when calling SessionsApi->toamaisutaaRevokeSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaSessions**
> BuiltList<SessionSummary> toamaisutaaSessions()

Lists the sessions this user has open.

One entry per refresh family, which is what `toa_sid` names - so a session here survives every rotation. The caller's own comes back with `isCurrent` true, unless their token was issued by an identity provider rather than by this application, in which case no entry is current.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSessionsApi();

try {
    final response = api.toamaisutaaSessions();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SessionsApi->toamaisutaaSessions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SessionSummary&gt;**](SessionSummary.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

