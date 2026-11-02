# schuly_api.api.LinkingApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiLinkingAccountsGet**](LinkingApi.md#apilinkingaccountsget) | **GET** /api/linking/accounts | 
[**apiLinkingAccountsProviderIdAccountIdDelete**](LinkingApi.md#apilinkingaccountsprovideridaccountiddelete) | **DELETE** /api/linking/accounts/{providerId}/{accountId} | 
[**apiLinkingCallbackGet**](LinkingApi.md#apilinkingcallbackget) | **GET** /api/linking/callback | 
[**apiLinkingProvidersGet**](LinkingApi.md#apilinkingprovidersget) | **GET** /api/linking/providers | 
[**apiLinkingProvidersProviderIdIconSvgGet**](LinkingApi.md#apilinkingprovidersprovideridiconsvgget) | **GET** /api/linking/providers/{providerId}/icon.svg | 
[**apiLinkingProvidersProviderIdStartPost**](LinkingApi.md#apilinkingprovidersprovideridstartpost) | **POST** /api/linking/providers/{providerId}/start | 
[**apiLinkingSessionsSessionIdDelete**](LinkingApi.md#apilinkingsessionssessioniddelete) | **DELETE** /api/linking/sessions/{sessionId} | 
[**apiLinkingSessionsSessionIdGet**](LinkingApi.md#apilinkingsessionssessionidget) | **GET** /api/linking/sessions/{sessionId} | 
[**apiLinkingSessionsSessionIdSubmitPost**](LinkingApi.md#apilinkingsessionssessionidsubmitpost) | **POST** /api/linking/sessions/{sessionId}/submit | 


# **apiLinkingAccountsGet**
> BuiltList<LinkProviderAccountDto> apiLinkingAccountsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();

try {
    final response = api.apiLinkingAccountsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingAccountsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;LinkProviderAccountDto&gt;**](LinkProviderAccountDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingAccountsProviderIdAccountIdDelete**
> apiLinkingAccountsProviderIdAccountIdDelete(providerId, accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String providerId = providerId_example; // String | 
final String accountId = accountId_example; // String | 

try {
    api.apiLinkingAccountsProviderIdAccountIdDelete(providerId, accountId);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingAccountsProviderIdAccountIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **providerId** | **String**|  | 
 **accountId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingCallbackGet**
> apiLinkingCallbackGet(session)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String session = session_example; // String | 

try {
    api.apiLinkingCallbackGet(session);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingCallbackGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **session** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingProvidersGet**
> BuiltList<LinkProviderDto> apiLinkingProvidersGet(platform)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String platform = platform_example; // String | 

try {
    final response = api.apiLinkingProvidersGet(platform);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingProvidersGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **platform** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;LinkProviderDto&gt;**](LinkProviderDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingProvidersProviderIdIconSvgGet**
> String apiLinkingProvidersProviderIdIconSvgGet(providerId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String providerId = providerId_example; // String | 

try {
    final response = api.apiLinkingProvidersProviderIdIconSvgGet(providerId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingProvidersProviderIdIconSvgGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **providerId** | **String**|  | 

### Return type

**String**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: image/svg+xml

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingProvidersProviderIdStartPost**
> LinkSessionDto apiLinkingProvidersProviderIdStartPost(providerId, startLinkRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String providerId = providerId_example; // String | 
final StartLinkRequest startLinkRequest = ; // StartLinkRequest | 

try {
    final response = api.apiLinkingProvidersProviderIdStartPost(providerId, startLinkRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingProvidersProviderIdStartPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **providerId** | **String**|  | 
 **startLinkRequest** | [**StartLinkRequest**](StartLinkRequest.md)|  | 

### Return type

[**LinkSessionDto**](LinkSessionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingSessionsSessionIdDelete**
> apiLinkingSessionsSessionIdDelete(sessionId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String sessionId = sessionId_example; // String | 

try {
    api.apiLinkingSessionsSessionIdDelete(sessionId);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingSessionsSessionIdDelete: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingSessionsSessionIdGet**
> LinkSessionDto apiLinkingSessionsSessionIdGet(sessionId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String sessionId = sessionId_example; // String | 

try {
    final response = api.apiLinkingSessionsSessionIdGet(sessionId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingSessionsSessionIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **String**|  | 

### Return type

[**LinkSessionDto**](LinkSessionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiLinkingSessionsSessionIdSubmitPost**
> LinkSessionDto apiLinkingSessionsSessionIdSubmitPost(sessionId, submitLinkRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkingApi();
final String sessionId = sessionId_example; // String | 
final SubmitLinkRequest submitLinkRequest = ; // SubmitLinkRequest | 

try {
    final response = api.apiLinkingSessionsSessionIdSubmitPost(sessionId, submitLinkRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkingApi->apiLinkingSessionsSessionIdSubmitPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionId** | **String**|  | 
 **submitLinkRequest** | [**SubmitLinkRequest**](SubmitLinkRequest.md)|  | 

### Return type

[**LinkSessionDto**](LinkSessionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

