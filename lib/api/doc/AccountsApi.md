# schuly_api.api.AccountsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsMicrosoftAccountsAccountIdCalendarGet**](AccountsApi.md#apipluginsmicrosoftaccountsaccountidcalendarget) | **GET** /api/plugins/microsoft/accounts/{accountId}/calendar | 
[**apiPluginsMicrosoftAccountsAccountIdFilesGet**](AccountsApi.md#apipluginsmicrosoftaccountsaccountidfilesget) | **GET** /api/plugins/microsoft/accounts/{accountId}/files | 
[**apiPluginsMicrosoftAccountsAccountIdMailGet**](AccountsApi.md#apipluginsmicrosoftaccountsaccountidmailget) | **GET** /api/plugins/microsoft/accounts/{accountId}/mail | 
[**apiPluginsOdaorgAccountsAccountIdDelete**](AccountsApi.md#apipluginsodaorgaccountsaccountiddelete) | **DELETE** /api/plugins/odaorg/accounts/{accountId} | 
[**apiPluginsOdaorgAccountsGet**](AccountsApi.md#apipluginsodaorgaccountsget) | **GET** /api/plugins/odaorg/accounts | 
[**apiPluginsSchulwareAccountsAccountIdDelete**](AccountsApi.md#apipluginsschulwareaccountsaccountiddelete) | **DELETE** /api/plugins/schulware/accounts/{accountId} | 
[**apiPluginsSchulwareAccountsGet**](AccountsApi.md#apipluginsschulwareaccountsget) | **GET** /api/plugins/schulware/accounts | 


# **apiPluginsMicrosoftAccountsAccountIdCalendarGet**
> apiPluginsMicrosoftAccountsAccountIdCalendarGet(accountId, top, start, end)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final int top = 56; // int | 
final DateTime start = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime end = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    api.apiPluginsMicrosoftAccountsAccountIdCalendarGet(accountId, top, start, end);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsMicrosoftAccountsAccountIdCalendarGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **top** | **int**|  | [optional] [default to 25]
 **start** | **DateTime**|  | [optional] 
 **end** | **DateTime**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsMicrosoftAccountsAccountIdFilesGet**
> apiPluginsMicrosoftAccountsAccountIdFilesGet(accountId, path, top)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String path = path_example; // String | 
final int top = 56; // int | 

try {
    api.apiPluginsMicrosoftAccountsAccountIdFilesGet(accountId, path, top);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsMicrosoftAccountsAccountIdFilesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **path** | **String**|  | [optional] [default to 'root']
 **top** | **int**|  | [optional] [default to 100]

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiPluginsMicrosoftAccountsAccountIdMailGet**
> apiPluginsMicrosoftAccountsAccountIdMailGet(accountId, folder, top, unread, search)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String folder = folder_example; // String | 
final int top = 56; // int | 
final bool unread = true; // bool | 
final String search = search_example; // String | 

try {
    api.apiPluginsMicrosoftAccountsAccountIdMailGet(accountId, folder, top, unread, search);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsMicrosoftAccountsAccountIdMailGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountId** | **String**|  | 
 **folder** | **String**|  | [optional] [default to 'inbox']
 **top** | **int**|  | [optional] [default to 25]
 **unread** | **bool**|  | [optional] [default to false]
 **search** | **String**|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **apiPluginsSchulwareAccountsAccountIdDelete**
> apiPluginsSchulwareAccountsAccountIdDelete(accountId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();
final String accountId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiPluginsSchulwareAccountsAccountIdDelete(accountId);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsSchulwareAccountsAccountIdDelete: $e\n');
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

# **apiPluginsSchulwareAccountsGet**
> apiPluginsSchulwareAccountsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getAccountsApi();

try {
    api.apiPluginsSchulwareAccountsGet();
} catch on DioException (e) {
    print('Exception when calling AccountsApi->apiPluginsSchulwareAccountsGet: $e\n');
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

