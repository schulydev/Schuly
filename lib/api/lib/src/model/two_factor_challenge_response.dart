//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'two_factor_challenge_response.g.dart';

/// TwoFactorChallengeResponse
///
/// Properties:
/// * [twoFactorRequired] 
/// * [challenge] 
/// * [expiresIn] 
/// * [secondFactors] 
@BuiltValue()
abstract class TwoFactorChallengeResponse implements Built<TwoFactorChallengeResponse, TwoFactorChallengeResponseBuilder> {
  @BuiltValueField(wireName: r'two_factor_required')
  bool? get twoFactorRequired;

  @BuiltValueField(wireName: r'challenge')
  String get challenge;

  @BuiltValueField(wireName: r'expires_in')
  int get expiresIn;

  @BuiltValueField(wireName: r'second_factors')
  BuiltList<String>? get secondFactors;

  TwoFactorChallengeResponse._();

  factory TwoFactorChallengeResponse([void updates(TwoFactorChallengeResponseBuilder b)]) = _$TwoFactorChallengeResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TwoFactorChallengeResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TwoFactorChallengeResponse> get serializer => _$TwoFactorChallengeResponseSerializer();
}

class _$TwoFactorChallengeResponseSerializer implements PrimitiveSerializer<TwoFactorChallengeResponse> {
  @override
  final Iterable<Type> types = const [TwoFactorChallengeResponse, _$TwoFactorChallengeResponse];

  @override
  final String wireName = r'TwoFactorChallengeResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TwoFactorChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.twoFactorRequired != null) {
      yield r'two_factor_required';
      yield serializers.serialize(
        object.twoFactorRequired,
        specifiedType: const FullType(bool),
      );
    }
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
    if (object.secondFactors != null) {
      yield r'second_factors';
      yield serializers.serialize(
        object.secondFactors,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TwoFactorChallengeResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TwoFactorChallengeResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'two_factor_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.twoFactorRequired = valueDes;
          break;
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
        case r'second_factors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.secondFactors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TwoFactorChallengeResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TwoFactorChallengeResponseBuilder();
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

