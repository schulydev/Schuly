//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/absence_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'absence_dto.g.dart';

/// AbsenceDto
///
/// Properties:
/// * [id] 
/// * [reason] 
/// * [type] 
/// * [from] 
/// * [until] 
/// * [isExcused] 
/// * [startTime] 
/// * [endTime] 
/// * [parentStatus] 
/// * [parentStatusDate] 
/// * [trainerStatus] 
/// * [trainerStatusDate] 
/// * [trainerComment] 
/// * [comment] 
/// * [excuseDeadline] 
/// * [lessons] 
/// * [schoolUserId] 
/// * [schoolId] 
@BuiltValue()
abstract class AbsenceDto implements Built<AbsenceDto, AbsenceDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'type')
  AbsenceType get type;
  // enum typeEnum {  Absence,  Delay,  };

  @BuiltValueField(wireName: r'from')
  DateTime get from;

  @BuiltValueField(wireName: r'until')
  DateTime get until;

  @BuiltValueField(wireName: r'isExcused')
  bool? get isExcused;

  @BuiltValueField(wireName: r'startTime')
  String? get startTime;

  @BuiltValueField(wireName: r'endTime')
  String? get endTime;

  @BuiltValueField(wireName: r'parentStatus')
  String? get parentStatus;

  @BuiltValueField(wireName: r'parentStatusDate')
  String? get parentStatusDate;

  @BuiltValueField(wireName: r'trainerStatus')
  String? get trainerStatus;

  @BuiltValueField(wireName: r'trainerStatusDate')
  String? get trainerStatusDate;

  @BuiltValueField(wireName: r'trainerComment')
  String? get trainerComment;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  @BuiltValueField(wireName: r'excuseDeadline')
  String? get excuseDeadline;

  @BuiltValueField(wireName: r'lessons')
  int? get lessons;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  @BuiltValueField(wireName: r'schoolId')
  String? get schoolId;

  AbsenceDto._();

  factory AbsenceDto([void updates(AbsenceDtoBuilder b)]) = _$AbsenceDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AbsenceDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AbsenceDto> get serializer => _$AbsenceDtoSerializer();
}

class _$AbsenceDtoSerializer implements PrimitiveSerializer<AbsenceDto> {
  @override
  final Iterable<Type> types = const [AbsenceDto, _$AbsenceDto];

  @override
  final String wireName = r'AbsenceDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AbsenceDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(AbsenceType),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(DateTime),
    );
    yield r'until';
    yield serializers.serialize(
      object.until,
      specifiedType: const FullType(DateTime),
    );
    if (object.isExcused != null) {
      yield r'isExcused';
      yield serializers.serialize(
        object.isExcused,
        specifiedType: const FullType.nullable(bool),
      );
    }
    if (object.startTime != null) {
      yield r'startTime';
      yield serializers.serialize(
        object.startTime,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.endTime != null) {
      yield r'endTime';
      yield serializers.serialize(
        object.endTime,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.parentStatus != null) {
      yield r'parentStatus';
      yield serializers.serialize(
        object.parentStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.parentStatusDate != null) {
      yield r'parentStatusDate';
      yield serializers.serialize(
        object.parentStatusDate,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.trainerStatus != null) {
      yield r'trainerStatus';
      yield serializers.serialize(
        object.trainerStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.trainerStatusDate != null) {
      yield r'trainerStatusDate';
      yield serializers.serialize(
        object.trainerStatusDate,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.trainerComment != null) {
      yield r'trainerComment';
      yield serializers.serialize(
        object.trainerComment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.comment != null) {
      yield r'comment';
      yield serializers.serialize(
        object.comment,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.excuseDeadline != null) {
      yield r'excuseDeadline';
      yield serializers.serialize(
        object.excuseDeadline,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lessons != null) {
      yield r'lessons';
      yield serializers.serialize(
        object.lessons,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.schoolUserId != null) {
      yield r'schoolUserId';
      yield serializers.serialize(
        object.schoolUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.schoolId != null) {
      yield r'schoolId';
      yield serializers.serialize(
        object.schoolId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AbsenceDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AbsenceDtoBuilder result,
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
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AbsenceType),
          ) as AbsenceType;
          result.type = valueDes;
          break;
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.from = valueDes;
          break;
        case r'until':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.until = valueDes;
          break;
        case r'isExcused':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.isExcused = valueDes;
          break;
        case r'startTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.startTime = valueDes;
          break;
        case r'endTime':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.endTime = valueDes;
          break;
        case r'parentStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.parentStatus = valueDes;
          break;
        case r'parentStatusDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.parentStatusDate = valueDes;
          break;
        case r'trainerStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.trainerStatus = valueDes;
          break;
        case r'trainerStatusDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.trainerStatusDate = valueDes;
          break;
        case r'trainerComment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.trainerComment = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        case r'excuseDeadline':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.excuseDeadline = valueDes;
          break;
        case r'lessons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.lessons = valueDes;
          break;
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        case r'schoolId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AbsenceDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AbsenceDtoBuilder();
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

