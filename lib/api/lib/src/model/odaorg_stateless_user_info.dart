//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'odaorg_stateless_user_info.g.dart';

/// OdaorgStatelessUserInfo
///
/// Properties:
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [birthday] 
@BuiltValue()
abstract class OdaorgStatelessUserInfo implements Built<OdaorgStatelessUserInfo, OdaorgStatelessUserInfoBuilder> {
  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'birthday')
  String? get birthday;

  OdaorgStatelessUserInfo._();

  factory OdaorgStatelessUserInfo([void updates(OdaorgStatelessUserInfoBuilder b)]) = _$OdaorgStatelessUserInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OdaorgStatelessUserInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OdaorgStatelessUserInfo> get serializer => _$OdaorgStatelessUserInfoSerializer();
}

class _$OdaorgStatelessUserInfoSerializer implements PrimitiveSerializer<OdaorgStatelessUserInfo> {
  @override
  final Iterable<Type> types = const [OdaorgStatelessUserInfo, _$OdaorgStatelessUserInfo];

  @override
  final String wireName = r'OdaorgStatelessUserInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OdaorgStatelessUserInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'firstName';
    yield object.firstName == null ? null : serializers.serialize(
      object.firstName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'lastName';
    yield object.lastName == null ? null : serializers.serialize(
      object.lastName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
    yield r'birthday';
    yield object.birthday == null ? null : serializers.serialize(
      object.birthday,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OdaorgStatelessUserInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OdaorgStatelessUserInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'birthday':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.birthday = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OdaorgStatelessUserInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OdaorgStatelessUserInfoBuilder();
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

