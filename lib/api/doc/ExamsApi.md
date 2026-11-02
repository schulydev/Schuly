# schuly_api.api.ExamsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiExamsGet**](ExamsApi.md#apiexamsget) | **GET** /api/Exams | 
[**apiExamsSearchGet**](ExamsApi.md#apiexamssearchget) | **GET** /api/Exams/search | 


# **apiExamsGet**
> BuiltList<ExamDto> apiExamsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExamsApi();

try {
    final response = api.apiExamsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;ExamDto&gt;**](ExamDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiExamsSearchGet**
> ExamDto apiExamsSearchGet(examId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExamsApi();
final String examId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiExamsSearchGet(examId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ExamsApi->apiExamsSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **examId** | **String**|  | [optional] 

### Return type

[**ExamDto**](ExamDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

