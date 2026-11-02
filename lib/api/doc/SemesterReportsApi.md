# schuly_api.api.SemesterReportsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiSemesterReportsGet**](SemesterReportsApi.md#apisemesterreportsget) | **GET** /api/SemesterReports | 


# **apiSemesterReportsGet**
> BuiltList<SemesterReportDto> apiSemesterReportsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSemesterReportsApi();

try {
    final response = api.apiSemesterReportsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SemesterReportsApi->apiSemesterReportsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;SemesterReportDto&gt;**](SemesterReportDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

