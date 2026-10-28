# schuly_api.api.OdaorgStatelessApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsOdaorgStatelessDataPost**](OdaorgStatelessApi.md#apipluginsodaorgstatelessdatapost) | **POST** /api/plugins/odaorg/stateless/data | 


# **apiPluginsOdaorgStatelessDataPost**
> OdaorgStatelessData apiPluginsOdaorgStatelessDataPost(odaorgStatelessRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getOdaorgStatelessApi();
final OdaorgStatelessRequest odaorgStatelessRequest = ; // OdaorgStatelessRequest | 

try {
    final response = api.apiPluginsOdaorgStatelessDataPost(odaorgStatelessRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OdaorgStatelessApi->apiPluginsOdaorgStatelessDataPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **odaorgStatelessRequest** | [**OdaorgStatelessRequest**](OdaorgStatelessRequest.md)|  | 

### Return type

[**OdaorgStatelessData**](OdaorgStatelessData.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

