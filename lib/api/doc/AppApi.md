# schuly_api.api.AppApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppGet**](AppApi.md#apiappget) | **GET** /api/App | 
[**apiAppSchoolSystemsGet**](AppApi.md#apiappschoolsystemsget) | **GET** /api/App/school-systems | 


# **apiAppGet**
> AppDto apiAppGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAppApi();

try {
    final response = api.apiAppGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppApi->apiAppGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AppDto**](AppDto.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppSchoolSystemsGet**
> BuiltList<SchoolSystemDto> apiAppSchoolSystemsGet()



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getAppApi();

try {
    final response = api.apiAppSchoolSystemsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AppApi->apiAppSchoolSystemsGet: $e\n');
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

