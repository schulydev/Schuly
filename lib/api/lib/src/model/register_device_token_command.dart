//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_device_token_command.g.dart';

/// RegisterDeviceTokenCommand
///
/// Properties:
/// * [token] 
/// * [platform] 
/// * [locale] 
@BuiltValue()
abstract class RegisterDeviceTokenCommand implements Built<RegisterDeviceTokenCommand, RegisterDeviceTokenCommandBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'platform')
  String get platform;

  @BuiltValueField(wireName: r'locale')
  String get locale;

  RegisterDeviceTokenCommand._();

  factory RegisterDeviceTokenCommand([void updates(RegisterDeviceTokenCommandBuilder b)]) = _$RegisterDeviceTokenCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterDeviceTokenCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterDeviceTokenCommand> get serializer => _$RegisterDeviceTokenCommandSerializer();
}

class _$RegisterDeviceTokenCommandSerializer implements PrimitiveSerializer<RegisterDeviceTokenCommand> {
  @override
  final Iterable<Type> types = const [RegisterDeviceTokenCommand, _$RegisterDeviceTokenCommand];

  @override
  final String wireName = r'RegisterDeviceTokenCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterDeviceTokenCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'platform';
    yield serializers.serialize(
      object.platform,
      specifiedType: const FullType(String),
    );
    yield r'locale';
    yield serializers.serialize(
      object.locale,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterDeviceTokenCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterDeviceTokenCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'locale':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locale = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterDeviceTokenCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterDeviceTokenCommandBuilder();
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

