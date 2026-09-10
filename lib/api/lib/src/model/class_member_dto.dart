//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/absence_dto.dart';
import 'package:schuly_api/src/model/roles.dart';
import 'package:schuly_api/src/model/grade_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_member_dto.g.dart';

/// ClassMemberDto
///
/// Properties:
/// * [id] 
/// * [schoolId] 
/// * [firstName] 
/// * [lastName] 
/// * [profilePictureUrl] 
/// * [role] 
/// * [absences] 
/// * [grades] 
@BuiltValue()
abstract class ClassMemberDto implements Built<ClassMemberDto, ClassMemberDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  @BuiltValueField(wireName: r'profilePictureUrl')
  String? get profilePictureUrl;

  @BuiltValueField(wireName: r'role')
  Roles get role;
  // enum roleEnum {  Student,  Teacher,  Administrator,  };

  @BuiltValueField(wireName: r'absences')
  BuiltList<AbsenceDto>? get absences;

  @BuiltValueField(wireName: r'grades')
  BuiltList<GradeDto>? get grades;

  ClassMemberDto._();

  factory ClassMemberDto([void updates(ClassMemberDtoBuilder b)]) = _$ClassMemberDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassMemberDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassMemberDto> get serializer => _$ClassMemberDtoSerializer();
}

class _$ClassMemberDtoSerializer implements PrimitiveSerializer<ClassMemberDto> {
  @override
  final Iterable<Type> types = const [ClassMemberDto, _$ClassMemberDto];

  @override
  final String wireName = r'ClassMemberDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassMemberDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType(String),
      );
    }
    yield r'firstName';
    yield serializers.serialize(
      object.firstName,
      specifiedType: const FullType(String),
    );
    yield r'lastName';
    yield serializers.serialize(
      object.lastName,
      specifiedType: const FullType(String),
    );
    if (object.profilePictureUrl != null) {
      yield r'profilePictureUrl';
      yield serializers.serialize(
        object.profilePictureUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Roles),
    );
    if (object.absences != null) {
      yield r'absences';
      yield serializers.serialize(
        object.absences,
        specifiedType: const FullType(BuiltList, [FullType(AbsenceDto)]),
      );
    }
    if (object.grades != null) {
      yield r'grades';
      yield serializers.serialize(
        object.grades,
        specifiedType: const FullType(BuiltList, [FullType(GradeDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassMemberDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClassMemberDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'schoolId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolId = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        case r'profilePictureUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.profilePictureUrl = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Roles),
          ) as Roles;
          result.role = valueDes;
          break;
        case r'absences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AbsenceDto)]),
          ) as BuiltList<AbsenceDto>;
          result.absences.replace(valueDes);
          break;
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(GradeDto)]),
          ) as BuiltList<GradeDto>;
          result.grades.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassMemberDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassMemberDtoBuilder();
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

