//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_external_login_request.g.dart';

/// LinkExternalLoginRequest
///
/// Properties:
/// * [returnUrl] 
/// * [state] 
/// * [currentPassword] 
/// * [code] 
@BuiltValue()
abstract class LinkExternalLoginRequest implements Built<LinkExternalLoginRequest, LinkExternalLoginRequestBuilder> {
  @BuiltValueField(wireName: r'returnUrl')
  String get returnUrl;

  @BuiltValueField(wireName: r'state')
  String? get state;

  @BuiltValueField(wireName: r'currentPassword')
  String? get currentPassword;

  @BuiltValueField(wireName: r'code')
  String? get code;

  LinkExternalLoginRequest._();

  factory LinkExternalLoginRequest([void updates(LinkExternalLoginRequestBuilder b)]) = _$LinkExternalLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkExternalLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkExternalLoginRequest> get serializer => _$LinkExternalLoginRequestSerializer();
}

class _$LinkExternalLoginRequestSerializer implements PrimitiveSerializer<LinkExternalLoginRequest> {
  @override
  final Iterable<Type> types = const [LinkExternalLoginRequest, _$LinkExternalLoginRequest];

  @override
  final String wireName = r'LinkExternalLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkExternalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'returnUrl';
    yield serializers.serialize(
      object.returnUrl,
      specifiedType: const FullType(String),
    );
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.currentPassword != null) {
      yield r'currentPassword';
      yield serializers.serialize(
        object.currentPassword,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkExternalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkExternalLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'returnUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.returnUrl = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentPassword = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  LinkExternalLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkExternalLoginRequestBuilder();
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

