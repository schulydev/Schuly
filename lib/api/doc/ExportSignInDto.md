# schuly_api.model.ExportSignInDto

## Load the model package
```dart
import 'package:schuly_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**userName** | **String** |  | 
**email** | **String** |  | 
**emailConfirmedAt** | [**DateTime**](DateTime.md) |  | 
**lastSeenAt** | [**DateTime**](DateTime.md) |  | 
**twoFactorEnabled** | **bool** |  | 
**externalLogins** | [**BuiltList&lt;ExportExternalLoginDto&gt;**](ExportExternalLoginDto.md) |  | 
**passkeys** | [**BuiltList&lt;ExportPasskeyDto&gt;**](ExportPasskeyDto.md) |  | 
**sessions** | [**BuiltList&lt;ExportSessionDto&gt;**](ExportSessionDto.md) |  | 
**trustedDevices** | [**BuiltList&lt;ExportSessionDto&gt;**](ExportSessionDto.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


