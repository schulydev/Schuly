# schuly_api.api.CalendarApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiPluginsMicrosoftCalendarGet**](CalendarApi.md#apipluginsmicrosoftcalendarget) | **GET** /api/plugins/microsoft/calendar | 


# **apiPluginsMicrosoftCalendarGet**
> MicrosoftCalendarFeed apiPluginsMicrosoftCalendarGet(start, end)



### Example
```dart
import 'package:schuly_api/api.dart';

final api = SchulyApi().getCalendarApi();
final DateTime start = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime end = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.apiPluginsMicrosoftCalendarGet(start, end);
    print(response);
} catch on DioException (e) {
    print('Exception when calling CalendarApi->apiPluginsMicrosoftCalendarGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **start** | **DateTime**|  | [optional] 
 **end** | **DateTime**|  | [optional] 

### Return type

[**MicrosoftCalendarFeed**](MicrosoftCalendarFeed.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

