//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_notification_preferences_command.g.dart';

/// UpdateNotificationPreferencesCommand
///
/// Properties:
/// * [grades] 
/// * [absences] 
/// * [agenda] 
/// * [includeGradeValue] 
@BuiltValue()
abstract class UpdateNotificationPreferencesCommand implements Built<UpdateNotificationPreferencesCommand, UpdateNotificationPreferencesCommandBuilder> {
  @BuiltValueField(wireName: r'grades')
  bool get grades;

  @BuiltValueField(wireName: r'absences')
  bool get absences;

  @BuiltValueField(wireName: r'agenda')
  bool get agenda;

  @BuiltValueField(wireName: r'includeGradeValue')
  bool get includeGradeValue;

  UpdateNotificationPreferencesCommand._();

  factory UpdateNotificationPreferencesCommand([void updates(UpdateNotificationPreferencesCommandBuilder b)]) = _$UpdateNotificationPreferencesCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateNotificationPreferencesCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateNotificationPreferencesCommand> get serializer => _$UpdateNotificationPreferencesCommandSerializer();
}

class _$UpdateNotificationPreferencesCommandSerializer implements PrimitiveSerializer<UpdateNotificationPreferencesCommand> {
  @override
  final Iterable<Type> types = const [UpdateNotificationPreferencesCommand, _$UpdateNotificationPreferencesCommand];

  @override
  final String wireName = r'UpdateNotificationPreferencesCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateNotificationPreferencesCommand object, {
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
    UpdateNotificationPreferencesCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateNotificationPreferencesCommandBuilder result,
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
  UpdateNotificationPreferencesCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateNotificationPreferencesCommandBuilder();
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

