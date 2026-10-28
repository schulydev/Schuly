//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'step_up_challenge_response.g.dart';

/// StepUpChallengeResponse
///
/// Properties:
/// * [challenge] 
/// * [expiresIn] 
@BuiltValue()
abstract class StepUpChallengeResponse implements Built<StepUpChallengeResponse, StepUpChallengeResponseBuilder> {
  @BuiltValueField(wireName: r'challenge')
  String get challenge;

  @BuiltValueField(wireName: r'expires_in')
  int get expiresIn;

  StepUpChallengeResponse._();

  factory StepUpChallengeResponse([void updates(StepUpChallengeResponseBuilder b)]) = _$StepUpChallengeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StepUpChallengeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StepUpChallengeResponse> get serializer => _$StepUpChallengeResponseSerializer();
}

class _$StepUpChallengeResponseSerializer implements PrimitiveSerializer<StepUpChallengeResponse> {
  @override
  final Iterable<Type> types = const [StepUpChallengeResponse, _$StepUpChallengeResponse];

  @override
  final String wireName = r'StepUpChallengeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StepUpChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'challenge';
    yield serializers.serialize(
      object.challenge,
      specifiedType: const FullType(String),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StepUpChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StepUpChallengeResponseBuilder result,
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
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.expiresIn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StepUpChallengeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StepUpChallengeResponseBuilder();
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

