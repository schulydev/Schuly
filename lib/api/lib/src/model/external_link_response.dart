//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'external_link_response.g.dart';

/// ExternalLinkResponse
///
/// Properties:
/// * [authorizationUrl] 
@BuiltValue()
abstract class ExternalLinkResponse implements Built<ExternalLinkResponse, ExternalLinkResponseBuilder> {
  @BuiltValueField(wireName: r'authorization_url')
  String get authorizationUrl;

  ExternalLinkResponse._();

  factory ExternalLinkResponse([void updates(ExternalLinkResponseBuilder b)]) = _$ExternalLinkResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExternalLinkResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExternalLinkResponse> get serializer => _$ExternalLinkResponseSerializer();
}

class _$ExternalLinkResponseSerializer implements PrimitiveSerializer<ExternalLinkResponse> {
  @override
  final Iterable<Type> types = const [ExternalLinkResponse, _$ExternalLinkResponse];

  @override
  final String wireName = r'ExternalLinkResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExternalLinkResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'authorization_url';
    yield serializers.serialize(
      object.authorizationUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExternalLinkResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExternalLinkResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'authorization_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExternalLinkResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExternalLinkResponseBuilder();
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

