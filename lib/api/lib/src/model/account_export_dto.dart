//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/application_user_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/student_document_dto.dart';
import 'package:schuly_api/src/model/agenda_entry_dto.dart';
import 'package:schuly_api/src/model/school_user_dto.dart';
import 'package:schuly_api/src/model/semester_report_dto.dart';
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

