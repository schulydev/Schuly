# schuly_api.api.SchulyAPIApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsExampleVaultDemoGet**](SchulyAPIApi.md#apipluginsexamplevaultdemoget) | **GET** /api/plugins/example/vault-demo | 


# **apiPluginsExampleVaultDemoGet**
> apiPluginsExampleVaultDemoGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getSchulyAPIApi();

try {
    api.apiPluginsExampleVaultDemoGet();
} catch on DioException (e) {
    print('Exception when calling SchulyAPIApi->apiPluginsExampleVaultDemoGet: $e\n');
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

