# schuly_api.api.PluginsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsGet**](PluginsApi.md#apipluginsget) | **GET** /api/Plugins | 
[**apiPluginsInstallPost**](PluginsApi.md#apipluginsinstallpost) | **POST** /api/Plugins/install | 
[**apiPluginsNameDelete**](PluginsApi.md#apipluginsnamedelete) | **DELETE** /api/Plugins/{name} | 
[**apiPluginsNameUpdatePost**](PluginsApi.md#apipluginsnameupdatepost) | **POST** /api/Plugins/{name}/update | 
[**apiPluginsRegistryGet**](PluginsApi.md#apipluginsregistryget) | **GET** /api/Plugins/registry | 
[**apiPluginsSchedulerGet**](PluginsApi.md#apipluginsschedulerget) | **GET** /api/Plugins/scheduler | 


# **apiPluginsGet**
> BuiltList<PluginDto> apiPluginsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();

try {
    final response = api.apiPluginsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;PluginDto&gt;**](PluginDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsInstallPost**
> apiPluginsInstallPost(installPluginRequest)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();
final InstallPluginRequest installPluginRequest = ; // InstallPluginRequest | 

try {
    api.apiPluginsInstallPost(installPluginRequest);
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsInstallPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **installPluginRequest** | [**InstallPluginRequest**](InstallPluginRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsNameDelete**
> apiPluginsNameDelete(name)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();
final String name = name_example; // String | 

try {
    api.apiPluginsNameDelete(name);
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsNameDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsNameUpdatePost**
> apiPluginsNameUpdatePost(name)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();
final String name = name_example; // String | 

try {
    api.apiPluginsNameUpdatePost(name);
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsNameUpdatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **name** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsRegistryGet**
> apiPluginsRegistryGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();

try {
    api.apiPluginsRegistryGet();
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsRegistryGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsSchedulerGet**
> BuiltList<PluginTaskStatus> apiPluginsSchedulerGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getPluginsApi();

try {
    final response = api.apiPluginsSchedulerGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling PluginsApi->apiPluginsSchedulerGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;PluginTaskStatus&gt;**](PluginTaskStatus.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

