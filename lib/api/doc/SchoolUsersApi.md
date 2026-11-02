# schuly_api.api.SchoolUsersApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSchoolUsersGet**](SchoolUsersApi.md#apischoolusersget) | **GET** /api/SchoolUsers | 
[**apiSchoolUsersIdGet**](SchoolUsersApi.md#apischoolusersidget) | **GET** /api/SchoolUsers/{id} | 


# **apiSchoolUsersGet**
> BuiltList<SchoolUserDto> apiSchoolUsersGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSchoolUsersApi();

try {
    final response = api.apiSchoolUsersGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SchoolUserDto&gt;**](SchoolUserDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolUsersIdGet**
> SchoolUserDto apiSchoolUsersIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSchoolUsersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolUsersIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolUsersApi->apiSchoolUsersIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SchoolUserDto**](SchoolUserDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

