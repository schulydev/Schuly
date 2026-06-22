# schuly_api.api.DevAuthApi

## Load the API package
```dart
import 'package:schuly_api/api.dart';
```

All URIs are relative to *http://localhost:5033*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiDevTokenPost**](DevAuthApi.md#apidevtokenpost) | **POST** /api/dev/token | 


# **apiDevTokenPost**
> DevTokenResponse apiDevTokenPost(devTokenRequest)



### Example
```dart
import 'package:schuly_api/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2
//defaultApiClient.getAuthentication<OAuth>('OAuth2').accessToken = 'YOUR_ACCESS_TOKEN';

final api = SchulyApi().getDevAuthApi();
final DevTokenRequest devTokenRequest = ; // DevTokenRequest | 

try {
    final response = api.apiDevTokenPost(devTokenRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DevAuthApi->apiDevTokenPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **devTokenRequest** | [**DevTokenRequest**](DevTokenRequest.md)|  | [optional] 

### Return type

[**DevTokenResponse**](DevTokenResponse.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

