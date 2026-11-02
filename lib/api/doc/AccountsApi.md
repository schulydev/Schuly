# schuly_api.api.AccountsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsOdaorgAccountsAccountIdDelete**](AccountsApi.md#apipluginsodaorgaccountsaccountiddelete) | **DELETE** /api/plugins/odaorg/accounts/{accountId} | 
[**apiPluginsOdaorgAccountsGet**](AccountsApi.md#apipluginsodaorgaccountsget) | **GET** /api/plugins/odaorg/accounts | 


# **apiPluginsOdaorgAccountsAccountIdDelete**
> apiPluginsOdaorgAccountsAccountIdDelete(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsOdaorgAccountsAccountIdDelete(accountId);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsOdaorgAccountsAccountIdDelete: $e\n');
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

# **apiPluginsOdaorgAccountsGet**
> apiPluginsOdaorgAccountsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();

try {
    api.apiPluginsOdaorgAccountsGet();
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsOdaorgAccountsGet: $e\n');
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

