//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'add_my_grade_command.g.dart';

/// AddMyGradeCommand
///
/// Properties:
/// * [schoolUserId] 
/// * [subject] 
/// * [examName] 
/// * [score] 
/// * [weight] 
/// * [examDate] 
@BuiltValue()
abstract class AddMyGradeCommand implements Built<AddMyGradeCommand, AddMyGradeCommandBuilder> {
  @BuiltValueField(wireName: r'schoolUserId')
  String get schoolUserId;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'examName')
  String get examName;

  @BuiltValueField(wireName: r'score')
  double get score;

  @BuiltValueField(wireName: r'weight')
  double get weight;

  @BuiltValueField(wireName: r'examDate')
  Date? get examDate;

  AddMyGradeCommand._();

  factory AddMyGradeCommand([void updates(AddMyGradeCommandBuilder b)]) = _$AddMyGradeCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AddMyGradeCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AddMyGradeCommand> get serializer => _$AddMyGradeCommandSerializer();
}

class _$AddMyGradeCommandSerializer implements PrimitiveSerializer<AddMyGradeCommand> {
  @override
  final Iterable<Type> types = const [AddMyGradeCommand, _$AddMyGradeCommand];

  @override
  final String wireName = r'AddMyGradeCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AddMyGradeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'schoolUserId';
    yield serializers.serialize(
      object.schoolUserId,
      specifiedType: const FullType(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'examName';
    yield serializers.serialize(
      object.examName,
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
    yield r'examDate';
    yield object.examDate == null ? null : serializers.serialize(
      object.examDate,
      specifiedType: const FullType.nullable(Date),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AddMyGradeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AddMyGradeCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'examName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.examName = valueDes;
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
        case r'examDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.examDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AddMyGradeCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AddMyGradeCommandBuilder();
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

