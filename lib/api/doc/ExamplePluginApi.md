# schuly_api.api.ExamplePluginApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsExampleHelloGet**](ExamplePluginApi.md#apipluginsexamplehelloget) | **GET** /api/plugins/example/hello | 
[**apiPluginsExampleInfoGet**](ExamplePluginApi.md#apipluginsexampleinfoget) | **GET** /api/plugins/example/info | 


# **apiPluginsExampleHelloGet**
> apiPluginsExampleHelloGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExamplePluginApi();

try {
    api.apiPluginsExampleHelloGet();
} catch on DioException (e) {
    print('Exception when calling ExamplePluginApi->apiPluginsExampleHelloGet: $e\n');
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

# **apiPluginsExampleInfoGet**
> apiPluginsExampleInfoGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getExamplePluginApi();

try {
    api.apiPluginsExampleInfoGet();
} catch on DioException (e) {
    print('Exception when calling ExamplePluginApi->apiPluginsExampleInfoGet: $e\n');
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

