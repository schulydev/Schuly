# schuly_api.api.ClassApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiClassGet**](ClassApi.md#apiclassget) | **GET** /api/Class | 
[**apiClassSearchGet**](ClassApi.md#apiclasssearchget) | **GET** /api/Class/search | 


# **apiClassGet**
> BuiltList<ClassDto> apiClassGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getClassApi();

try {
    final response = api.apiClassGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ClassDto&gt;**](ClassDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiClassSearchGet**
> ClassDto apiClassSearchGet(classId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getClassApi();
final String classId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiClassSearchGet(classId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ClassApi->apiClassSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **classId** | **String**|  | [optional] 

### Return type

[**ClassDto**](ClassDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

