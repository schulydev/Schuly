# schuly_api.api.LinkedAccountsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiMeLinkedAccountsGet**](LinkedAccountsApi.md#apimelinkedaccountsget) | **GET** /api/me/linked-accounts | 
[**apiMeLinkedAccountsIdDelete**](LinkedAccountsApi.md#apimelinkedaccountsiddelete) | **DELETE** /api/me/linked-accounts/{id} | 


# **apiMeLinkedAccountsGet**
> BuiltList<LinkedAccountDto> apiMeLinkedAccountsGet(provider)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkedAccountsApi();
final String provider = provider_example; // String | 

try {
    final response = api.apiMeLinkedAccountsGet(provider);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LinkedAccountsApi->apiMeLinkedAccountsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **provider** | **String**|  | [optional] 

### Return type

[**BuiltList&lt;LinkedAccountDto&gt;**](LinkedAccountDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMeLinkedAccountsIdDelete**
> apiMeLinkedAccountsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getLinkedAccountsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiMeLinkedAccountsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling LinkedAccountsApi->apiMeLinkedAccountsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

