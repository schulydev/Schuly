# schuly_api.api.MeApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiMeAvatarDelete**](MeApi.md#apimeavatardelete) | **DELETE** /api/me/avatar | 
[**apiMeAvatarPut**](MeApi.md#apimeavatarput) | **PUT** /api/me/avatar | 
[**apiMeGradesIdDelete**](MeApi.md#apimegradesiddelete) | **DELETE** /api/me/grades/{id} | 
[**apiMeGradesPost**](MeApi.md#apimegradespost) | **POST** /api/me/grades | 
[**apiMeGradesPut**](MeApi.md#apimegradesput) | **PUT** /api/me/grades | 
[**apiMeSchoolsPost**](MeApi.md#apimeschoolspost) | **POST** /api/me/schools | 


# **apiMeAvatarDelete**
> apiMeAvatarDelete()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();

try {
    api.apiMeAvatarDelete();
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeAvatarDelete: $e\n');
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
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeAvatarPut**
> apiMeAvatarPut(file)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    api.apiMeAvatarPut(file);
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeAvatarPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeGradesIdDelete**
> apiMeGradesIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiMeGradesIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeGradesIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeGradesPost**
> String apiMeGradesPost(addMyGradeCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();
final AddMyGradeCommand addMyGradeCommand = ; // AddMyGradeCommand | 

try {
    final response = api.apiMeGradesPost(addMyGradeCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeGradesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **addMyGradeCommand** | [**AddMyGradeCommand**](AddMyGradeCommand.md)|  | 

### Return type

**String**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeGradesPut**
> apiMeGradesPut(updateMyGradeCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();
final UpdateMyGradeCommand updateMyGradeCommand = ; // UpdateMyGradeCommand | 

try {
    api.apiMeGradesPut(updateMyGradeCommand);
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeGradesPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMyGradeCommand** | [**UpdateMyGradeCommand**](UpdateMyGradeCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeSchoolsPost**
> String apiMeSchoolsPost(createMySchoolCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMeApi();
final CreateMySchoolCommand createMySchoolCommand = ; // CreateMySchoolCommand | 

try {
    final response = api.apiMeSchoolsPost(createMySchoolCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->apiMeSchoolsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createMySchoolCommand** | [**CreateMySchoolCommand**](CreateMySchoolCommand.md)|  | 

### Return type

**String**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

