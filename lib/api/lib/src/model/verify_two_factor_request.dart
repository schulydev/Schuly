//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_two_factor_request.g.dart';

/// VerifyTwoFactorRequest
///
/// Properties:
/// * [challenge] 
/// * [code] 
/// * [rememberDevice] 
/// * [deviceLabel] 
@BuiltValue()
abstract class VerifyTwoFactorRequest implements Built<VerifyTwoFactorRequest, VerifyTwoFactorRequestBuilder> {
  @BuiltValueField(wireName: r'challenge')
  String get challenge;

  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'rememberDevice')
  bool? get rememberDevice;

  @BuiltValueField(wireName: r'deviceLabel')
  String? get deviceLabel;

  VerifyTwoFactorRequest._();

  factory VerifyTwoFactorRequest([void updates(VerifyTwoFactorRequestBuilder b)]) = _$VerifyTwoFactorRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyTwoFactorRequestBuilder b) => b
      ..rememberDevice = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyTwoFactorRequest> get serializer => _$VerifyTwoFactorRequestSerializer();
}

class _$VerifyTwoFactorRequestSerializer implements PrimitiveSerializer<VerifyTwoFactorRequest> {
  @override
  final Iterable<Type> types = const [VerifyTwoFactorRequest, _$VerifyTwoFactorRequest];

  @override
  final String wireName = r'VerifyTwoFactorRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyTwoFactorRequest object, {
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
    if (object.rememberDevice != null) {
      yield r'rememberDevice';
      yield serializers.serialize(
        object.rememberDevice,
        specifiedType: const FullType(bool),
      );
    }
    if (object.deviceLabel != null) {
      yield r'deviceLabel';
      yield serializers.serialize(
        object.deviceLabel,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyTwoFactorRequestBuilder result,
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
        case r'rememberDevice':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.rememberDevice = valueDes;
          break;
        case r'deviceLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.deviceLabel = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  VerifyTwoFactorRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyTwoFactorRequestBuilder();
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

