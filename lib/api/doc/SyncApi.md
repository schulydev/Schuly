# schuly_api.api.SyncApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsOdaorgAccountsAccountIdSyncGet**](SyncApi.md#apipluginsodaorgaccountsaccountidsyncget) | **GET** /api/plugins/odaorg/accounts/{accountId}/sync | 
[**apiPluginsOdaorgAccountsAccountIdSyncPost**](SyncApi.md#apipluginsodaorgaccountsaccountidsyncpost) | **POST** /api/plugins/odaorg/accounts/{accountId}/sync | 


# **apiPluginsOdaorgAccountsAccountIdSyncGet**
> apiPluginsOdaorgAccountsAccountIdSyncGet(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSyncApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsOdaorgAccountsAccountIdSyncGet(accountId);
} catch on DioException (e) {
    print('Exception when calling SyncApi->apiPluginsOdaorgAccountsAccountIdSyncGet: $e\n');
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

# **apiPluginsOdaorgAccountsAccountIdSyncPost**
> apiPluginsOdaorgAccountsAccountIdSyncPost(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSyncApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsOdaorgAccountsAccountIdSyncPost(accountId);
} catch on DioException (e) {
    print('Exception when calling SyncApi->apiPluginsOdaorgAccountsAccountIdSyncPost: $e\n');
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

