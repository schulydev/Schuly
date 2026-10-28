# schuly_api.api.LinkApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsMicrosoftLinkCompletePost**](LinkApi.md#apipluginsmicrosoftlinkcompletepost) | **POST** /api/plugins/microsoft/link/complete | 
[**apiPluginsMicrosoftLinkStartPost**](LinkApi.md#apipluginsmicrosoftlinkstartpost) | **POST** /api/plugins/microsoft/link/start | 


# **apiPluginsMicrosoftLinkCompletePost**
> apiPluginsMicrosoftLinkCompletePost(completeRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkApi();
final CompleteRequest completeRequest = ; // CompleteRequest | 

try {
    api.apiPluginsMicrosoftLinkCompletePost(completeRequest);
} catch on DioException (e) {
    print('Exception when calling LinkApi->apiPluginsMicrosoftLinkCompletePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **completeRequest** | [**CompleteRequest**](CompleteRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsMicrosoftLinkStartPost**
> apiPluginsMicrosoftLinkStartPost()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkApi();

try {
    api.apiPluginsMicrosoftLinkStartPost();
} catch on DioException (e) {
    print('Exception when calling LinkApi->apiPluginsMicrosoftLinkStartPost: $e\n');
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

