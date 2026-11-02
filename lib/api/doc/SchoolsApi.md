# schuly_api.api.SchoolsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSchoolsIdGet**](SchoolsApi.md#apischoolsidget) | **GET** /api/Schools/{id} | 
[**apiSchoolsMySchoolsGet**](SchoolsApi.md#apischoolsmyschoolsget) | **GET** /api/Schools/my-schools | 


# **apiSchoolsIdGet**
> SchoolDto apiSchoolsIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSchoolsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiSchoolsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**SchoolDto**](SchoolDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiSchoolsMySchoolsGet**
> BuiltList<MySchoolDto> apiSchoolsMySchoolsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSchoolsApi();

try {
    final response = api.apiSchoolsMySchoolsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SchoolsApi->apiSchoolsMySchoolsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;MySchoolDto&gt;**](MySchoolDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

