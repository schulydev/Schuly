# schuly_api.api.PushApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsSchulwarePushAccountIdPost**](PushApi.md#apipluginsschulwarepushaccountidpost) | **POST** /api/plugins/schulware/push/{accountId} | 


# **apiPluginsSchulwarePushAccountIdPost**
> apiPluginsSchulwarePushAccountIdPost(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getPushApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsSchulwarePushAccountIdPost(accountId);
} catch on DioException (e) {
    print('Exception when calling PushApi->apiPluginsSchulwarePushAccountIdPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

