# schuly_api.api.HelplyApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiHelplyConversationsDelete**](HelplyApi.md#apihelplyconversationsdelete) | **DELETE** /api/helply/conversations | 
[**apiHelplyConversationsGet**](HelplyApi.md#apihelplyconversationsget) | **GET** /api/helply/conversations | 
[**apiHelplyConversationsIdApprovalsPost**](HelplyApi.md#apihelplyconversationsidapprovalspost) | **POST** /api/helply/conversations/{id}/approvals | 
[**apiHelplyConversationsIdAttachmentsAttachmentIdDelete**](HelplyApi.md#apihelplyconversationsidattachmentsattachmentiddelete) | **DELETE** /api/helply/conversations/{id}/attachments/{attachmentId} | 
[**apiHelplyConversationsIdAttachmentsAttachmentIdGet**](HelplyApi.md#apihelplyconversationsidattachmentsattachmentidget) | **GET** /api/helply/conversations/{id}/attachments/{attachmentId} | 
[**apiHelplyConversationsIdAttachmentsPost**](HelplyApi.md#apihelplyconversationsidattachmentspost) | **POST** /api/helply/conversations/{id}/attachments | 
[**apiHelplyConversationsIdDelete**](HelplyApi.md#apihelplyconversationsiddelete) | **DELETE** /api/helply/conversations/{id} | 
[**apiHelplyConversationsIdGet**](HelplyApi.md#apihelplyconversationsidget) | **GET** /api/helply/conversations/{id} | 
[**apiHelplyConversationsIdMessagesPost**](HelplyApi.md#apihelplyconversationsidmessagespost) | **POST** /api/helply/conversations/{id}/messages | 
[**apiHelplyConversationsIdPatch**](HelplyApi.md#apihelplyconversationsidpatch) | **PATCH** /api/helply/conversations/{id} | 
[**apiHelplyConversationsIdRetryPost**](HelplyApi.md#apihelplyconversationsidretrypost) | **POST** /api/helply/conversations/{id}/retry | 
[**apiHelplyConversationsPost**](HelplyApi.md#apihelplyconversationspost) | **POST** /api/helply/conversations | 
[**apiHelplySettingsGet**](HelplyApi.md#apihelplysettingsget) | **GET** /api/helply/settings | 
[**apiHelplySettingsPermissionsPut**](HelplyApi.md#apihelplysettingspermissionsput) | **PUT** /api/helply/settings/permissions | 
[**apiHelplySettingsWorkspacePut**](HelplyApi.md#apihelplysettingsworkspaceput) | **PUT** /api/helply/settings/workspace | 
[**apiHelplyStatusGet**](HelplyApi.md#apihelplystatusget) | **GET** /api/helply/status | 


# **apiHelplyConversationsDelete**
> apiHelplyConversationsDelete()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();

try {
    api.apiHelplyConversationsDelete();
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsDelete: $e\n');
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

# **apiHelplyConversationsGet**
> BuiltList<HelplyConversationSummaryDto> apiHelplyConversationsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();

try {
    final response = api.apiHelplyConversationsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;HelplyConversationSummaryDto&gt;**](HelplyConversationSummaryDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdApprovalsPost**
> apiHelplyConversationsIdApprovalsPost(id, answerHelplyApprovalsRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final AnswerHelplyApprovalsRequest answerHelplyApprovalsRequest = ; // AnswerHelplyApprovalsRequest | 

try {
    api.apiHelplyConversationsIdApprovalsPost(id, answerHelplyApprovalsRequest);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdApprovalsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **answerHelplyApprovalsRequest** | [**AnswerHelplyApprovalsRequest**](AnswerHelplyApprovalsRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdAttachmentsAttachmentIdDelete**
> apiHelplyConversationsIdAttachmentsAttachmentIdDelete(id, attachmentId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String attachmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiHelplyConversationsIdAttachmentsAttachmentIdDelete(id, attachmentId);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdAttachmentsAttachmentIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **attachmentId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdAttachmentsAttachmentIdGet**
> FileContentResult apiHelplyConversationsIdAttachmentsAttachmentIdGet(id, attachmentId)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final String attachmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiHelplyConversationsIdAttachmentsAttachmentIdGet(id, attachmentId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdAttachmentsAttachmentIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **attachmentId** | **String**|  | 

### Return type

[**FileContentResult**](FileContentResult.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdAttachmentsPost**
> HelplyAttachmentDto apiHelplyConversationsIdAttachmentsPost(id, file)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.apiHelplyConversationsIdAttachmentsPost(id, file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdAttachmentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**HelplyAttachmentDto**](HelplyAttachmentDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdDelete**
> apiHelplyConversationsIdDelete(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiHelplyConversationsIdDelete(id);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdDelete: $e\n');
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

# **apiHelplyConversationsIdGet**
> HelplyConversationDto apiHelplyConversationsIdGet(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiHelplyConversationsIdGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**HelplyConversationDto**](HelplyConversationDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdMessagesPost**
> apiHelplyConversationsIdMessagesPost(id, sendHelplyMessageRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final SendHelplyMessageRequest sendHelplyMessageRequest = ; // SendHelplyMessageRequest | 

try {
    api.apiHelplyConversationsIdMessagesPost(id, sendHelplyMessageRequest);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdMessagesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **sendHelplyMessageRequest** | [**SendHelplyMessageRequest**](SendHelplyMessageRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdPatch**
> HelplyConversationSummaryDto apiHelplyConversationsIdPatch(id, renameHelplyConversationRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final RenameHelplyConversationRequest renameHelplyConversationRequest = ; // RenameHelplyConversationRequest | 

try {
    final response = api.apiHelplyConversationsIdPatch(id, renameHelplyConversationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdPatch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **renameHelplyConversationRequest** | [**RenameHelplyConversationRequest**](RenameHelplyConversationRequest.md)|  | 

### Return type

[**HelplyConversationSummaryDto**](HelplyConversationSummaryDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsIdRetryPost**
> apiHelplyConversationsIdRetryPost(id)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiHelplyConversationsIdRetryPost(id);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsIdRetryPost: $e\n');
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
 - **Accept**: text/event-stream

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyConversationsPost**
> HelplyConversationSummaryDto apiHelplyConversationsPost(createHelplyConversationRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final CreateHelplyConversationRequest createHelplyConversationRequest = ; // CreateHelplyConversationRequest | 

try {
    final response = api.apiHelplyConversationsPost(createHelplyConversationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyConversationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createHelplyConversationRequest** | [**CreateHelplyConversationRequest**](CreateHelplyConversationRequest.md)|  | [optional] 

### Return type

[**HelplyConversationSummaryDto**](HelplyConversationSummaryDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplySettingsGet**
> HelplySettingsDto apiHelplySettingsGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();

try {
    final response = api.apiHelplySettingsGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplySettingsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HelplySettingsDto**](HelplySettingsDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplySettingsPermissionsPut**
> HelplySettingsDto apiHelplySettingsPermissionsPut(mcpPermissionSet)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final McpPermissionSet mcpPermissionSet = ; // McpPermissionSet | 

try {
    final response = api.apiHelplySettingsPermissionsPut(mcpPermissionSet);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplySettingsPermissionsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **mcpPermissionSet** | [**McpPermissionSet**](McpPermissionSet.md)|  | 

### Return type

[**HelplySettingsDto**](HelplySettingsDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplySettingsWorkspacePut**
> HelplySettingsDto apiHelplySettingsWorkspacePut(updateHelplyWorkspaceRequest)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();
final UpdateHelplyWorkspaceRequest updateHelplyWorkspaceRequest = ; // UpdateHelplyWorkspaceRequest | 

try {
    final response = api.apiHelplySettingsWorkspacePut(updateHelplyWorkspaceRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplySettingsWorkspacePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateHelplyWorkspaceRequest** | [**UpdateHelplyWorkspaceRequest**](UpdateHelplyWorkspaceRequest.md)|  | 

### Return type

[**HelplySettingsDto**](HelplySettingsDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiHelplyStatusGet**
> HelplyStatusDto apiHelplyStatusGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getHelplyApi();

try {
    final response = api.apiHelplyStatusGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelplyApi->apiHelplyStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**HelplyStatusDto**](HelplyStatusDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

