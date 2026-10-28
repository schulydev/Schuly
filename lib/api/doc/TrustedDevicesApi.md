# schuly_api.api.TrustedDevicesApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**toamaisutaaRevokeAllTrustedDevices**](TrustedDevicesApi.md#toamaisutaarevokealltrusteddevices) | **DELETE** /auth/devices | Revokes every device this user has trusted.
[**toamaisutaaRevokeTrustedDevice**](TrustedDevicesApi.md#toamaisutaarevoketrusteddevice) | **DELETE** /auth/devices/{id} | Revokes one device by its id.
[**toamaisutaaTrustedDevices**](TrustedDevicesApi.md#toamaisutaatrusteddevices) | **GET** /auth/devices | Lists the devices this user has trusted.


# **toamaisutaaRevokeAllTrustedDevices**
> toamaisutaaRevokeAllTrustedDevices()

Revokes every device this user has trusted.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTrustedDevicesApi();

try {
    api.toamaisutaaRevokeAllTrustedDevices();
} catch on DioException (e) {
    print('Exception when calling TrustedDevicesApi->toamaisutaaRevokeAllTrustedDevices: $e\n');
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
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaRevokeTrustedDevice**
> toamaisutaaRevokeTrustedDevice(id)

Revokes one device by its id.

404 covers both a device that does not exist and one belonging to someone else, so this cannot be used to discover another account's device ids.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTrustedDevicesApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.toamaisutaaRevokeTrustedDevice(id);
} catch on DioException (e) {
    print('Exception when calling TrustedDevicesApi->toamaisutaaRevokeTrustedDevice: $e\n');
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
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **toamaisutaaTrustedDevices**
> BuiltList<TrustedDeviceSummary> toamaisutaaTrustedDevices()

Lists the devices this user has trusted.

Send the device token you are holding in an `X-Toamaisutaa-Device` header and the matching row comes back with `isCurrent` true, so a list can say \"this device\" rather than inviting somebody to revoke the one they are sitting at.

### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getTrustedDevicesApi();

try {
    final response = api.toamaisutaaTrustedDevices();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TrustedDevicesApi->toamaisutaaTrustedDevices: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TrustedDeviceSummary&gt;**](TrustedDeviceSummary.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

