# schuly_api.api.TeachersApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTeachersGet**](TeachersApi.md#apiteachersget) | **GET** /api/Teachers | 
[**apiTeachersIdGet**](TeachersApi.md#apiteachersidget) | **GET** /api/Teachers/{id} | 


# **apiTeachersGet**
> BuiltList<TeacherDto> apiTeachersGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTeachersApi();

try {
    final response = api.apiTeachersGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TeacherDto&gt;**](TeacherDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTeachersIdGet**
> TeacherDto apiTeachersIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTeachersApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiTeachersIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling TeachersApi->apiTeachersIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TeacherDto**](TeacherDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

