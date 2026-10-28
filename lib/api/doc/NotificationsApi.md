# schuly_api.api.NotificationsApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiNotificationsDevicesPost**](NotificationsApi.md#apinotificationsdevicespost) | **POST** /api/notifications/devices | 
[**apiNotificationsDevicesTokenDelete**](NotificationsApi.md#apinotificationsdevicestokendelete) | **DELETE** /api/notifications/devices/{token} | 
[**apiNotificationsPreferencesGet**](NotificationsApi.md#apinotificationspreferencesget) | **GET** /api/notifications/preferences | 
[**apiNotificationsPreferencesPut**](NotificationsApi.md#apinotificationspreferencesput) | **PUT** /api/notifications/preferences | 
[**apiNotificationsTestPost**](NotificationsApi.md#apinotificationstestpost) | **POST** /api/notifications/test | 


# **apiNotificationsDevicesPost**
> apiNotificationsDevicesPost(registerDeviceTokenCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getNotificationsApi();
final RegisterDeviceTokenCommand registerDeviceTokenCommand = ; // RegisterDeviceTokenCommand | 

try {
    api.apiNotificationsDevicesPost(registerDeviceTokenCommand);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->apiNotificationsDevicesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerDeviceTokenCommand** | [**RegisterDeviceTokenCommand**](RegisterDeviceTokenCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiNotificationsDevicesTokenDelete**
> apiNotificationsDevicesTokenDelete(token)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getNotificationsApi();
final String token = token_example; // String | 

try {
    api.apiNotificationsDevicesTokenDelete(token);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->apiNotificationsDevicesTokenDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiNotificationsPreferencesGet**
> NotificationPreferencesDto apiNotificationsPreferencesGet()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getNotificationsApi();

try {
    final response = api.apiNotificationsPreferencesGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->apiNotificationsPreferencesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**NotificationPreferencesDto**](NotificationPreferencesDto.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiNotificationsPreferencesPut**
> apiNotificationsPreferencesPut(updateNotificationPreferencesCommand)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getNotificationsApi();
final UpdateNotificationPreferencesCommand updateNotificationPreferencesCommand = ; // UpdateNotificationPreferencesCommand | 

try {
    api.apiNotificationsPreferencesPut(updateNotificationPreferencesCommand);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->apiNotificationsPreferencesPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateNotificationPreferencesCommand** | [**UpdateNotificationPreferencesCommand**](UpdateNotificationPreferencesCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiNotificationsTestPost**
> PushResult apiNotificationsTestPost()



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getNotificationsApi();

try {
    final response = api.apiNotificationsTestPost();
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->apiNotificationsTestPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PushResult**](PushResult.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

