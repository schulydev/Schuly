# schuly_api.model.AccountExportDto

## Load the model package
```dart
import 'package:schuly_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**exportedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**profile** | [**ApplicationUserDto**](ApplicationUserDto.md) |  | 
**schoolUsers** | [**BuiltList&lt;SchoolUserDto&gt;**](SchoolUserDto.md) |  | [optional] 
**agendaEntries** | [**BuiltList&lt;AgendaEntryDto&gt;**](AgendaEntryDto.md) |  | [optional] 
**semesterReports** | [**BuiltList&lt;SemesterReportDto&gt;**](SemesterReportDto.md) |  | [optional] 
**documents** | [**BuiltList&lt;StudentDocumentDto&gt;**](StudentDocumentDto.md) |  | [optional] 
**linkedAccounts** | [**BuiltList&lt;LinkedAccountDto&gt;**](LinkedAccountDto.md) |  | [optional] 
**privacyNotice** | [**ExportPrivacyNoticeDto**](ExportPrivacyNoticeDto.md) |  | [optional] 
**signIn** | [**ExportSignInDto**](ExportSignInDto.md) |  | [optional] 
**connectedAccounts** | [**BuiltList&lt;ExportConnectedAccountDto&gt;**](ExportConnectedAccountDto.md) |  | [optional] 
**helply** | [**ExportHelplyDto**](ExportHelplyDto.md) |  | [optional] 
**aiApps** | [**ExportAiAppsDto**](ExportAiAppsDto.md) |  | [optional] 
**notifications** | [**ExportNotificationsDto**](ExportNotificationsDto.md) |  | [optional] 
**notIncluded** | **BuiltList&lt;String&gt;** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


