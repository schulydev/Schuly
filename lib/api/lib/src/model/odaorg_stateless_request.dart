//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'odaorg_stateless_request.g.dart';

/// OdaorgStatelessRequest
///
/// Properties:
/// * [baseUrl] 
/// * [username] 
/// * [password] 
@BuiltValue()
abstract class OdaorgStatelessRequest implements Built<OdaorgStatelessRequest, OdaorgStatelessRequestBuilder> {
  @BuiltValueField(wireName: r'baseUrl')
  String get baseUrl;

  @BuiltValueField(wireName: r'username')
  String get username;

  @BuiltValueField(wireName: r'password')
  String get password;

  OdaorgStatelessRequest._();

  factory OdaorgStatelessRequest([void updates(OdaorgStatelessRequestBuilder b)]) = _$OdaorgStatelessRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OdaorgStatelessRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OdaorgStatelessRequest> get serializer => _$OdaorgStatelessRequestSerializer();
}

class _$OdaorgStatelessRequestSerializer implements PrimitiveSerializer<OdaorgStatelessRequest> {
  @override
  final Iterable<Type> types = const [OdaorgStatelessRequest, _$OdaorgStatelessRequest];

  @override
  final String wireName = r'OdaorgStatelessRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OdaorgStatelessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'baseUrl';
    yield serializers.serialize(
      object.baseUrl,
      specifiedType: const FullType(String),
    );
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OdaorgStatelessRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OdaorgStatelessRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'baseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseUrl = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OdaorgStatelessRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OdaorgStatelessRequestBuilder();
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

