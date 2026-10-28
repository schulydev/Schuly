# schuly_api.api.StatelessLinkApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsMicrosoftStatelessLinkCompletePost**](StatelessLinkApi.md#apipluginsmicrosoftstatelesslinkcompletepost) | **POST** /api/plugins/microsoft/stateless/link/complete | 
[**apiPluginsMicrosoftStatelessLinkStartPost**](StatelessLinkApi.md#apipluginsmicrosoftstatelesslinkstartpost) | **POST** /api/plugins/microsoft/stateless/link/start | 


# **apiPluginsMicrosoftStatelessLinkCompletePost**
> apiPluginsMicrosoftStatelessLinkCompletePost(completeRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getStatelessLinkApi();
final CompleteRequest completeRequest = ; // CompleteRequest | 

try {
    api.apiPluginsMicrosoftStatelessLinkCompletePost(completeRequest);
} catch on DioException (e) {
    print('Exception when calling StatelessLinkApi->apiPluginsMicrosoftStatelessLinkCompletePost: $e\n');
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

# **apiPluginsMicrosoftStatelessLinkStartPost**
> apiPluginsMicrosoftStatelessLinkStartPost()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getStatelessLinkApi();

try {
    api.apiPluginsMicrosoftStatelessLinkStartPost();
} catch on DioException (e) {
    print('Exception when calling StatelessLinkApi->apiPluginsMicrosoftStatelessLinkStartPost: $e\n');
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

