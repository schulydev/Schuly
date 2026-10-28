//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'odaorg_stateless_grade.g.dart';

/// OdaorgStatelessGrade
///
/// Properties:
/// * [id] 
/// * [examId] 
/// * [subject] 
/// * [score] 
@BuiltValue()
abstract class OdaorgStatelessGrade implements Built<OdaorgStatelessGrade, OdaorgStatelessGradeBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'examId')
  String? get examId;

  @BuiltValueField(wireName: r'subject')
  String? get subject;

  @BuiltValueField(wireName: r'score')
  double? get score;

  OdaorgStatelessGrade._();

  factory OdaorgStatelessGrade([void updates(OdaorgStatelessGradeBuilder b)]) = _$OdaorgStatelessGrade;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OdaorgStatelessGradeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OdaorgStatelessGrade> get serializer => _$OdaorgStatelessGradeSerializer();
}

class _$OdaorgStatelessGradeSerializer implements PrimitiveSerializer<OdaorgStatelessGrade> {
  @override
  final Iterable<Type> types = const [OdaorgStatelessGrade, _$OdaorgStatelessGrade];

  @override
  final String wireName = r'OdaorgStatelessGrade';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OdaorgStatelessGrade object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield object.id == null ? null : serializers.serialize(
      object.id,
      specifiedType: const FullType.nullable(String),
    );
    yield r'examId';
    yield object.examId == null ? null : serializers.serialize(
      object.examId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'subject';
    yield object.subject == null ? null : serializers.serialize(
      object.subject,
      specifiedType: const FullType.nullable(String),
    );
    yield r'score';
    yield object.score == null ? null : serializers.serialize(
      object.score,
      specifiedType: const FullType.nullable(double),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OdaorgStatelessGrade object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OdaorgStatelessGradeBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'examId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.examId = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subject = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.score = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OdaorgStatelessGrade deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OdaorgStatelessGradeBuilder();
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

