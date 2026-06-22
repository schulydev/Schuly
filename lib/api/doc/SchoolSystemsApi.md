# schuly_api.api.SchoolSystemsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSchoolSystemsGet**](SchoolSystemsApi.md#apischoolsystemsget) | **GET** /api/SchoolSystems | 
[**apiSchoolSystemsIdDelete**](SchoolSystemsApi.md#apischoolsystemsiddelete) | **DELETE** /api/SchoolSystems/{id} | 
[**apiSchoolSystemsIdGet**](SchoolSystemsApi.md#apischoolsystemsidget) | **GET** /api/SchoolSystems/{id} | 
[**apiSchoolSystemsPost**](SchoolSystemsApi.md#apischoolsystemspost) | **POST** /api/SchoolSystems | 
[**apiSchoolSystemsPut**](SchoolSystemsApi.md#apischoolsystemsput) | **PUT** /api/SchoolSystems | 


# **apiSchoolSystemsGet**
> BuiltList<SchoolSystemDto> apiSchoolSystemsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolSystemsApi();

try {
    final response = api.apiSchoolSystemsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolSystemsApi->apiSchoolSystemsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SchoolSystemDto&gt;**](SchoolSystemDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolSystemsIdDelete**
> apiSchoolSystemsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolSystemsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiSchoolSystemsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling SchoolSystemsApi->apiSchoolSystemsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolSystemsIdGet**
> SchoolSystemDto apiSchoolSystemsIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolSystemsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolSystemsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolSystemsApi->apiSchoolSystemsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SchoolSystemDto**](SchoolSystemDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolSystemsPost**
> String apiSchoolSystemsPost(createSchoolSystemCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolSystemsApi();
final CreateSchoolSystemCommand createSchoolSystemCommand = ; // CreateSchoolSystemCommand | 

try {
    final response = api.apiSchoolSystemsPost(createSchoolSystemCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolSystemsApi->apiSchoolSystemsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createSchoolSystemCommand** | [**CreateSchoolSystemCommand**](CreateSchoolSystemCommand.md)|  | 

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolSystemsPut**
> apiSchoolSystemsPut(updateSchoolSystemCommand)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getSchoolSystemsApi();
final UpdateSchoolSystemCommand updateSchoolSystemCommand = ; // UpdateSchoolSystemCommand | 

try {
    api.apiSchoolSystemsPut(updateSchoolSystemCommand);
} catch on DioException (e) {
    print('Exception when calling SchoolSystemsApi->apiSchoolSystemsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateSchoolSystemCommand** | [**UpdateSchoolSystemCommand**](UpdateSchoolSystemCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

