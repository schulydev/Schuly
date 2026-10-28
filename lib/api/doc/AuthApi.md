# schuly_api.api.AuthApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAuthLoginPost**](AuthApi.md#apiauthloginpost) | **POST** /api/Auth/login | 
[**apiAuthMeDelete**](AuthApi.md#apiauthmedelete) | **DELETE** /api/Auth/me | 
[**apiAuthMeExportGet**](AuthApi.md#apiauthmeexportget) | **GET** /api/Auth/me/export | 
[**apiAuthMeGet**](AuthApi.md#apiauthmeget) | **GET** /api/Auth/me | 
[**apiAuthSyncGet**](AuthApi.md#apiauthsyncget) | **GET** /api/Auth/sync | 


# **apiAuthLoginPost**
> apiAuthLoginPost(unifiedLoginRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthApi();
final UnifiedLoginRequest unifiedLoginRequest = ; // UnifiedLoginRequest | 

try {
    api.apiAuthLoginPost(unifiedLoginRequest);
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **unifiedLoginRequest** | [**UnifiedLoginRequest**](UnifiedLoginRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthMeDelete**
> apiAuthMeDelete()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthApi();

try {
    api.apiAuthMeDelete();
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthMeDelete: $e\n');
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
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthMeExportGet**
> AccountExportDto apiAuthMeExportGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthApi();

try {
    final response = api.apiAuthMeExportGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthMeExportGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountExportDto**](AccountExportDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthMeGet**
> ApplicationUserDto apiAuthMeGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthApi();

try {
    final response = api.apiAuthMeGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ApplicationUserDto**](ApplicationUserDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAuthSyncGet**
> apiAuthSyncGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAuthApi();

try {
    api.apiAuthSyncGet();
} catch on DioException (e) {
    print('Exception when calling AuthApi->apiAuthSyncGet: $e\n');
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
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

