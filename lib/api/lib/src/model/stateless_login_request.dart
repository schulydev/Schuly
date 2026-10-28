//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stateless_login_request.g.dart';

/// StatelessLoginRequest
///
/// Properties:
/// * [baseUrl] 
/// * [email] 
/// * [password] 
/// * [totpSecret] 
@BuiltValue()
abstract class StatelessLoginRequest implements Built<StatelessLoginRequest, StatelessLoginRequestBuilder> {
  @BuiltValueField(wireName: r'baseUrl')
  String get baseUrl;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'totpSecret')
  String? get totpSecret;

  StatelessLoginRequest._();

  factory StatelessLoginRequest([void updates(StatelessLoginRequestBuilder b)]) = _$StatelessLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatelessLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatelessLoginRequest> get serializer => _$StatelessLoginRequestSerializer();
}

class _$StatelessLoginRequestSerializer implements PrimitiveSerializer<StatelessLoginRequest> {
  @override
  final Iterable<Type> types = const [StatelessLoginRequest, _$StatelessLoginRequest];

  @override
  final String wireName = r'StatelessLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatelessLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'baseUrl';
    yield serializers.serialize(
      object.baseUrl,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'totpSecret';
    yield object.totpSecret == null ? null : serializers.serialize(
      object.totpSecret,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StatelessLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatelessLoginRequestBuilder result,
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'totpSecret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totpSecret = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatelessLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatelessLoginRequestBuilder();
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

