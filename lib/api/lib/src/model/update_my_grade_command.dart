//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_my_grade_command.g.dart';

/// UpdateMyGradeCommand
///
/// Properties:
/// * [gradeId] 
/// * [score] 
/// * [weight] 
@BuiltValue()
abstract class UpdateMyGradeCommand implements Built<UpdateMyGradeCommand, UpdateMyGradeCommandBuilder> {
  @BuiltValueField(wireName: r'gradeId')
  String get gradeId;

  @BuiltValueField(wireName: r'score')
  double get score;

  @BuiltValueField(wireName: r'weight')
  double get weight;

  UpdateMyGradeCommand._();

  factory UpdateMyGradeCommand([void updates(UpdateMyGradeCommandBuilder b)]) = _$UpdateMyGradeCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateMyGradeCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateMyGradeCommand> get serializer => _$UpdateMyGradeCommandSerializer();
}

class _$UpdateMyGradeCommandSerializer implements PrimitiveSerializer<UpdateMyGradeCommand> {
  @override
  final Iterable<Type> types = const [UpdateMyGradeCommand, _$UpdateMyGradeCommand];

  @override
  final String wireName = r'UpdateMyGradeCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateMyGradeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'gradeId';
    yield serializers.serialize(
      object.gradeId,
      specifiedType: const FullType(String),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(double),
    );
    yield r'weight';
    yield serializers.serialize(
      object.weight,
      specifiedType: const FullType(double),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateMyGradeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateMyGradeCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'gradeId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gradeId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.score = valueDes;
          break;
        case r'weight':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.weight = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateMyGradeCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateMyGradeCommandBuilder();
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

