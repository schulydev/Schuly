# schuly_api.api.StatelessAuthApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsSchulwareStatelessLoginMethodGet**](StatelessAuthApi.md#apipluginsschulwarestatelessloginmethodget) | **GET** /api/plugins/schulware/stateless/login-method | 
[**apiPluginsSchulwareStatelessLoginPost**](StatelessAuthApi.md#apipluginsschulwarestatelessloginpost) | **POST** /api/plugins/schulware/stateless/login | 
[**apiPluginsSchulwareStatelessRefreshPost**](StatelessAuthApi.md#apipluginsschulwarestatelessrefreshpost) | **POST** /api/plugins/schulware/stateless/refresh | 


# **apiPluginsSchulwareStatelessLoginMethodGet**
> apiPluginsSchulwareStatelessLoginMethodGet(baseUrl)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getStatelessAuthApi();
final String baseUrl = baseUrl_example; // String | 

try {
    api.apiPluginsSchulwareStatelessLoginMethodGet(baseUrl);
} catch on DioException (e) {
    print('Exception when calling StatelessAuthApi->apiPluginsSchulwareStatelessLoginMethodGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **baseUrl** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchulwareStatelessLoginPost**
> apiPluginsSchulwareStatelessLoginPost(statelessLoginRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getStatelessAuthApi();
final StatelessLoginRequest statelessLoginRequest = ; // StatelessLoginRequest | 

try {
    api.apiPluginsSchulwareStatelessLoginPost(statelessLoginRequest);
} catch on DioException (e) {
    print('Exception when calling StatelessAuthApi->apiPluginsSchulwareStatelessLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statelessLoginRequest** | [**StatelessLoginRequest**](StatelessLoginRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchulwareStatelessRefreshPost**
> apiPluginsSchulwareStatelessRefreshPost(statelessRefreshRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getStatelessAuthApi();
final StatelessRefreshRequest statelessRefreshRequest = ; // StatelessRefreshRequest | 

try {
    api.apiPluginsSchulwareStatelessRefreshPost(statelessRefreshRequest);
} catch on DioException (e) {
    print('Exception when calling StatelessAuthApi->apiPluginsSchulwareStatelessRefreshPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **statelessRefreshRequest** | [**StatelessRefreshRequest**](StatelessRefreshRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

