//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dev_token_request.g.dart';

/// DevTokenRequest
///
/// Properties:
/// * [role] 
/// * [sub] 
/// * [name] 
/// * [email] 
@BuiltValue()
abstract class DevTokenRequest implements Built<DevTokenRequest, DevTokenRequestBuilder> {
  @BuiltValueField(wireName: r'role')
  String? get role;

  @BuiltValueField(wireName: r'sub')
  String? get sub;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'email')
  String? get email;

  DevTokenRequest._();

  factory DevTokenRequest([void updates(DevTokenRequestBuilder b)]) = _$DevTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DevTokenRequestBuilder b) => b
      ..role = 'Administrator'
      ..sub = 'dev-admin'
      ..name = 'Dev Admin';

  @BuiltValueSerializer(custom: true)
  static Serializer<DevTokenRequest> get serializer => _$DevTokenRequestSerializer();
}

class _$DevTokenRequestSerializer implements PrimitiveSerializer<DevTokenRequest> {
  @override
  final Iterable<Type> types = const [DevTokenRequest, _$DevTokenRequest];

  @override
  final String wireName = r'DevTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DevTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.sub != null) {
      yield r'sub';
      yield serializers.serialize(
        object.sub,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DevTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DevTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'sub':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sub = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DevTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DevTokenRequestBuilder();
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

