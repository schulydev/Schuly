# schuly_api.api.McpApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiMcpAuthorizationDecisionPost**](McpApi.md#apimcpauthorizationdecisionpost) | **POST** /api/mcp/authorization-decision | 
[**apiMcpAuthorizationRequestPost**](McpApi.md#apimcpauthorizationrequestpost) | **POST** /api/mcp/authorization-request | 
[**apiMcpConnectionsGet**](McpApi.md#apimcpconnectionsget) | **GET** /api/mcp/connections | 
[**apiMcpConnectionsIdActivityGet**](McpApi.md#apimcpconnectionsidactivityget) | **GET** /api/mcp/connections/{id}/activity | 
[**apiMcpConnectionsIdDelete**](McpApi.md#apimcpconnectionsiddelete) | **DELETE** /api/mcp/connections/{id} | 
[**apiMcpConnectionsIdPermissionsPut**](McpApi.md#apimcpconnectionsidpermissionsput) | **PUT** /api/mcp/connections/{id}/permissions | 
[**apiMcpKeysGet**](McpApi.md#apimcpkeysget) | **GET** /api/mcp/keys | 
[**apiMcpKeysIdActivityGet**](McpApi.md#apimcpkeysidactivityget) | **GET** /api/mcp/keys/{id}/activity | 
[**apiMcpKeysIdDelete**](McpApi.md#apimcpkeysiddelete) | **DELETE** /api/mcp/keys/{id} | 
[**apiMcpKeysIdPermissionsPut**](McpApi.md#apimcpkeysidpermissionsput) | **PUT** /api/mcp/keys/{id}/permissions | 
[**apiMcpKeysPost**](McpApi.md#apimcpkeyspost) | **POST** /api/mcp/keys | 


# **apiMcpAuthorizationDecisionPost**
> McpAuthorizationDecisionDto apiMcpAuthorizationDecisionPost(decideMcpAuthorizationCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final DecideMcpAuthorizationCommand decideMcpAuthorizationCommand = ; // DecideMcpAuthorizationCommand | 

try {
    final response = api.apiMcpAuthorizationDecisionPost(decideMcpAuthorizationCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpAuthorizationDecisionPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **decideMcpAuthorizationCommand** | [**DecideMcpAuthorizationCommand**](DecideMcpAuthorizationCommand.md)|  | 

### Return type

[**McpAuthorizationDecisionDto**](McpAuthorizationDecisionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpAuthorizationRequestPost**
> McpAuthorizationRequestDto apiMcpAuthorizationRequestPost(mcpAuthorizationParameters)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final McpAuthorizationParameters mcpAuthorizationParameters = ; // McpAuthorizationParameters | 

try {
    final response = api.apiMcpAuthorizationRequestPost(mcpAuthorizationParameters);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpAuthorizationRequestPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mcpAuthorizationParameters** | [**McpAuthorizationParameters**](McpAuthorizationParameters.md)|  | 

### Return type

[**McpAuthorizationRequestDto**](McpAuthorizationRequestDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpConnectionsGet**
> BuiltList<McpConnectionDto> apiMcpConnectionsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();

try {
    final response = api.apiMcpConnectionsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpConnectionsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;McpConnectionDto&gt;**](McpConnectionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpConnectionsIdActivityGet**
> BuiltList<McpActivityDto> apiMcpConnectionsIdActivityGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiMcpConnectionsIdActivityGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpConnectionsIdActivityGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;McpActivityDto&gt;**](McpActivityDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpConnectionsIdDelete**
> apiMcpConnectionsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiMcpConnectionsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpConnectionsIdDelete: $e\n');
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

# **apiMcpConnectionsIdPermissionsPut**
> McpConnectionDto apiMcpConnectionsIdPermissionsPut(id, mcpPermissionSet)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final McpPermissionSet mcpPermissionSet = ; // McpPermissionSet | 

try {
    final response = api.apiMcpConnectionsIdPermissionsPut(id, mcpPermissionSet);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpConnectionsIdPermissionsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **mcpPermissionSet** | [**McpPermissionSet**](McpPermissionSet.md)|  | 

### Return type

[**McpConnectionDto**](McpConnectionDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpKeysGet**
> BuiltList<McpApiKeyDto> apiMcpKeysGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();

try {
    final response = api.apiMcpKeysGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpKeysGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;McpApiKeyDto&gt;**](McpApiKeyDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpKeysIdActivityGet**
> BuiltList<McpActivityDto> apiMcpKeysIdActivityGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiMcpKeysIdActivityGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpKeysIdActivityGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BuiltList&lt;McpActivityDto&gt;**](McpActivityDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpKeysIdDelete**
> apiMcpKeysIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiMcpKeysIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpKeysIdDelete: $e\n');
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

# **apiMcpKeysIdPermissionsPut**
> McpApiKeyDto apiMcpKeysIdPermissionsPut(id, mcpPermissionSet)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final McpPermissionSet mcpPermissionSet = ; // McpPermissionSet | 

try {
    final response = api.apiMcpKeysIdPermissionsPut(id, mcpPermissionSet);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpKeysIdPermissionsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **mcpPermissionSet** | [**McpPermissionSet**](McpPermissionSet.md)|  | 

### Return type

[**McpApiKeyDto**](McpApiKeyDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiMcpKeysPost**
> CreatedMcpApiKeyDto apiMcpKeysPost(createMcpApiKeyCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getMcpApi();
final CreateMcpApiKeyCommand createMcpApiKeyCommand = ; // CreateMcpApiKeyCommand | 

try {
    final response = api.apiMcpKeysPost(createMcpApiKeyCommand);
    print(response);
} catch on DioException (e) {
    print('Exception when calling McpApi->apiMcpKeysPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createMcpApiKeyCommand** | [**CreateMcpApiKeyCommand**](CreateMcpApiKeyCommand.md)|  | 

### Return type

[**CreatedMcpApiKeyDto**](CreatedMcpApiKeyDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

