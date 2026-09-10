//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_preferences_dto.g.dart';

/// NotificationPreferencesDto
///
/// Properties:
/// * [grades] 
/// * [absences] 
/// * [agenda] 
/// * [includeGradeValue] 
@BuiltValue()
abstract class NotificationPreferencesDto implements Built<NotificationPreferencesDto, NotificationPreferencesDtoBuilder> {
  @BuiltValueField(wireName: r'grades')
  bool get grades;

  @BuiltValueField(wireName: r'absences')
  bool get absences;

  @BuiltValueField(wireName: r'agenda')
  bool get agenda;

  @BuiltValueField(wireName: r'includeGradeValue')
  bool get includeGradeValue;

  NotificationPreferencesDto._();

  factory NotificationPreferencesDto([void updates(NotificationPreferencesDtoBuilder b)]) = _$NotificationPreferencesDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationPreferencesDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationPreferencesDto> get serializer => _$NotificationPreferencesDtoSerializer();
}

class _$NotificationPreferencesDtoSerializer implements PrimitiveSerializer<NotificationPreferencesDto> {
  @override
  final Iterable<Type> types = const [NotificationPreferencesDto, _$NotificationPreferencesDto];

  @override
  final String wireName = r'NotificationPreferencesDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationPreferencesDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'grades';
    yield serializers.serialize(
      object.grades,
      specifiedType: const FullType(bool),
    );
    yield r'absences';
    yield serializers.serialize(
      object.absences,
      specifiedType: const FullType(bool),
    );
    yield r'agenda';
    yield serializers.serialize(
      object.agenda,
      specifiedType: const FullType(bool),
    );
    yield r'includeGradeValue';
    yield serializers.serialize(
      object.includeGradeValue,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationPreferencesDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationPreferencesDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.grades = valueDes;
          break;
        case r'absences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.absences = valueDes;
          break;
        case r'agenda':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.agenda = valueDes;
          break;
        case r'includeGradeValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.includeGradeValue = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationPreferencesDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationPreferencesDtoBuilder();
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

