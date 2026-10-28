//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'step_up_verify_request.g.dart';

/// StepUpVerifyRequest
///
/// Properties:
/// * [challenge] 
/// * [code] 
@BuiltValue()
abstract class StepUpVerifyRequest implements Built<StepUpVerifyRequest, StepUpVerifyRequestBuilder> {
  @BuiltValueField(wireName: r'challenge')
  String get challenge;

  @BuiltValueField(wireName: r'code')
  String get code;

  StepUpVerifyRequest._();

  factory StepUpVerifyRequest([void updates(StepUpVerifyRequestBuilder b)]) = _$StepUpVerifyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StepUpVerifyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StepUpVerifyRequest> get serializer => _$StepUpVerifyRequestSerializer();
}

class _$StepUpVerifyRequestSerializer implements PrimitiveSerializer<StepUpVerifyRequest> {
  @override
  final Iterable<Type> types = const [StepUpVerifyRequest, _$StepUpVerifyRequest];

  @override
  final String wireName = r'StepUpVerifyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StepUpVerifyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'challenge';
    yield serializers.serialize(
      object.challenge,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StepUpVerifyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StepUpVerifyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'challenge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challenge = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StepUpVerifyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StepUpVerifyRequestBuilder();
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

