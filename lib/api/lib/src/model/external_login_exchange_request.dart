//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'external_login_exchange_request.g.dart';

/// ExternalLoginExchangeRequest
///
/// Properties:
/// * [code] 
/// * [codeVerifier] 
@BuiltValue()
abstract class ExternalLoginExchangeRequest implements Built<ExternalLoginExchangeRequest, ExternalLoginExchangeRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'codeVerifier')
  String get codeVerifier;

  ExternalLoginExchangeRequest._();

  factory ExternalLoginExchangeRequest([void updates(ExternalLoginExchangeRequestBuilder b)]) = _$ExternalLoginExchangeRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExternalLoginExchangeRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExternalLoginExchangeRequest> get serializer => _$ExternalLoginExchangeRequestSerializer();
}

class _$ExternalLoginExchangeRequestSerializer implements PrimitiveSerializer<ExternalLoginExchangeRequest> {
  @override
  final Iterable<Type> types = const [ExternalLoginExchangeRequest, _$ExternalLoginExchangeRequest];

  @override
  final String wireName = r'ExternalLoginExchangeRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExternalLoginExchangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'codeVerifier';
    yield serializers.serialize(
      object.codeVerifier,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExternalLoginExchangeRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExternalLoginExchangeRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'codeVerifier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.codeVerifier = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExternalLoginExchangeRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExternalLoginExchangeRequestBuilder();
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

