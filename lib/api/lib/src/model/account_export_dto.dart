//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/application_user_dto.dart';
import 'package:schuly_api/src/model/export_privacy_notice_dto.dart';
import 'package:schuly_api/src/model/export_sign_in_dto.dart';
import 'package:schuly_api/src/model/export_helply_dto.dart';
import 'package:schuly_api/src/model/export_ai_apps_dto.dart';
import 'package:schuly_api/src/model/export_connected_account_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/export_notifications_dto.dart';
import 'package:schuly_api/src/model/student_document_dto.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:schuly_api/src/model/semester_report_dto.dart';
import 'package:schuly_api/src/model/linked_account_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_export_dto.g.dart';

/// AccountExportDto
///
/// Properties:
/// * [exportedAt] 
/// * [profile] 
/// * [schoolUsers] 
/// * [agendaEntries] 
/// * [semesterReports] 
/// * [documents] 
/// * [linkedAccounts] 
/// * [privacyNotice] 
/// * [signIn] 
/// * [connectedAccounts] 
/// * [helply] 
/// * [aiApps] 
/// * [notifications] 
/// * [notIncluded] 
@BuiltValue()
abstract class AccountExportDto implements Built<AccountExportDto, AccountExportDtoBuilder> {
  @BuiltValueField(wireName: r'exportedAt')
  DateTime? get exportedAt;

  @BuiltValueField(wireName: r'profile')
  ApplicationUserDto get profile;

  @BuiltValueField(wireName: r'schoolUsers')
  BuiltList<SchoolUserDto>? get schoolUsers;

  @BuiltValueField(wireName: r'agendaEntries')
  BuiltList<AgendaEntryDto>? get agendaEntries;

  @BuiltValueField(wireName: r'semesterReports')
  BuiltList<SemesterReportDto>? get semesterReports;

  @BuiltValueField(wireName: r'documents')
  BuiltList<StudentDocumentDto>? get documents;

  @BuiltValueField(wireName: r'linkedAccounts')
  BuiltList<LinkedAccountDto>? get linkedAccounts;

  @BuiltValueField(wireName: r'privacyNotice')
  ExportPrivacyNoticeDto? get privacyNotice;

  @BuiltValueField(wireName: r'signIn')
  ExportSignInDto? get signIn;

  @BuiltValueField(wireName: r'connectedAccounts')
  BuiltList<ExportConnectedAccountDto>? get connectedAccounts;

  @BuiltValueField(wireName: r'helply')
  ExportHelplyDto? get helply;

  @BuiltValueField(wireName: r'aiApps')
  ExportAiAppsDto? get aiApps;

  @BuiltValueField(wireName: r'notifications')
  ExportNotificationsDto? get notifications;

  @BuiltValueField(wireName: r'notIncluded')
  BuiltList<String>? get notIncluded;

  AccountExportDto._();

  factory AccountExportDto([void updates(AccountExportDtoBuilder b)]) = _$AccountExportDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountExportDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountExportDto> get serializer => _$AccountExportDtoSerializer();
}

class _$AccountExportDtoSerializer implements PrimitiveSerializer<AccountExportDto> {
  @override
  final Iterable<Type> types = const [AccountExportDto, _$AccountExportDto];

  @override
  final String wireName = r'AccountExportDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountExportDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.exportedAt != null) {
      yield r'exportedAt';
      yield serializers.serialize(
        object.exportedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'profile';
    yield serializers.serialize(
      object.profile,
      specifiedType: const FullType(ApplicationUserDto),
    );
    if (object.schoolUsers != null) {
      yield r'schoolUsers';
      yield serializers.serialize(
        object.schoolUsers,
        specifiedType: const FullType(BuiltList, [FullType(SchoolUserDto)]),
      );
    }
    if (object.agendaEntries != null) {
      yield r'agendaEntries';
      yield serializers.serialize(
        object.agendaEntries,
        specifiedType: const FullType(BuiltList, [FullType(AgendaEntryDto)]),
      );
    }
    if (object.semesterReports != null) {
      yield r'semesterReports';
      yield serializers.serialize(
        object.semesterReports,
        specifiedType: const FullType(BuiltList, [FullType(SemesterReportDto)]),
      );
    }
    if (object.documents != null) {
      yield r'documents';
      yield serializers.serialize(
        object.documents,
        specifiedType: const FullType(BuiltList, [FullType(StudentDocumentDto)]),
      );
    }
    if (object.linkedAccounts != null) {
      yield r'linkedAccounts';
      yield serializers.serialize(
        object.linkedAccounts,
        specifiedType: const FullType(BuiltList, [FullType(LinkedAccountDto)]),
      );
    }
    if (object.privacyNotice != null) {
      yield r'privacyNotice';
      yield serializers.serialize(
        object.privacyNotice,
        specifiedType: const FullType.nullable(ExportPrivacyNoticeDto),
      );
    }
    if (object.signIn != null) {
      yield r'signIn';
      yield serializers.serialize(
        object.signIn,
        specifiedType: const FullType.nullable(ExportSignInDto),
      );
    }
    if (object.connectedAccounts != null) {
      yield r'connectedAccounts';
      yield serializers.serialize(
        object.connectedAccounts,
        specifiedType: const FullType(BuiltList, [FullType(ExportConnectedAccountDto)]),
      );
    }
    if (object.helply != null) {
      yield r'helply';
      yield serializers.serialize(
        object.helply,
        specifiedType: const FullType.nullable(ExportHelplyDto),
      );
    }
    if (object.aiApps != null) {
      yield r'aiApps';
      yield serializers.serialize(
        object.aiApps,
        specifiedType: const FullType.nullable(ExportAiAppsDto),
      );
    }
    if (object.notifications != null) {
      yield r'notifications';
      yield serializers.serialize(
        object.notifications,
        specifiedType: const FullType.nullable(ExportNotificationsDto),
      );
    }
    if (object.notIncluded != null) {
      yield r'notIncluded';
      yield serializers.serialize(
        object.notIncluded,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountExportDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountExportDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'exportedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.exportedAt = valueDes;
          break;
        case r'profile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ApplicationUserDto),
          ) as ApplicationUserDto;
          result.profile.replace(valueDes);
          break;
        case r'schoolUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SchoolUserDto)]),
          ) as BuiltList<SchoolUserDto>;
          result.schoolUsers.replace(valueDes);
          break;
        case r'agendaEntries':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AgendaEntryDto)]),
          ) as BuiltList<AgendaEntryDto>;
          result.agendaEntries.replace(valueDes);
          break;
        case r'semesterReports':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(SemesterReportDto)]),
          ) as BuiltList<SemesterReportDto>;
          result.semesterReports.replace(valueDes);
          break;
        case r'documents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StudentDocumentDto)]),
          ) as BuiltList<StudentDocumentDto>;
          result.documents.replace(valueDes);
          break;
        case r'linkedAccounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkedAccountDto)]),
          ) as BuiltList<LinkedAccountDto>;
          result.linkedAccounts.replace(valueDes);
          break;
        case r'privacyNotice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExportPrivacyNoticeDto),
          ) as ExportPrivacyNoticeDto?;
          if (valueDes == null) continue;
          result.privacyNotice.replace(valueDes);
          break;
        case r'signIn':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExportSignInDto),
          ) as ExportSignInDto?;
          if (valueDes == null) continue;
          result.signIn.replace(valueDes);
          break;
        case r'connectedAccounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportConnectedAccountDto)]),
          ) as BuiltList<ExportConnectedAccountDto>;
          result.connectedAccounts.replace(valueDes);
          break;
        case r'helply':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExportHelplyDto),
          ) as ExportHelplyDto?;
          if (valueDes == null) continue;
          result.helply.replace(valueDes);
          break;
        case r'aiApps':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExportAiAppsDto),
          ) as ExportAiAppsDto?;
          if (valueDes == null) continue;
          result.aiApps.replace(valueDes);
          break;
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ExportNotificationsDto),
          ) as ExportNotificationsDto?;
          if (valueDes == null) continue;
          result.notifications.replace(valueDes);
          break;
        case r'notIncluded':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.notIncluded.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountExportDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountExportDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

