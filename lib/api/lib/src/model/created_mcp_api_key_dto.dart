//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_api_key_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'created_mcp_api_key_dto.g.dart';

/// CreatedMcpApiKeyDto
///
/// Properties:
/// * [key] 
/// * [secret] 
@BuiltValue()
abstract class CreatedMcpApiKeyDto implements Built<CreatedMcpApiKeyDto, CreatedMcpApiKeyDtoBuilder> {
  @BuiltValueField(wireName: r'key')
  McpApiKeyDto get key;

  @BuiltValueField(wireName: r'secret')
  String get secret;

  CreatedMcpApiKeyDto._();

  factory CreatedMcpApiKeyDto([void updates(CreatedMcpApiKeyDtoBuilder b)]) = _$CreatedMcpApiKeyDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreatedMcpApiKeyDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreatedMcpApiKeyDto> get serializer => _$CreatedMcpApiKeyDtoSerializer();
}

class _$CreatedMcpApiKeyDtoSerializer implements PrimitiveSerializer<CreatedMcpApiKeyDto> {
  @override
  final Iterable<Type> types = const [CreatedMcpApiKeyDto, _$CreatedMcpApiKeyDto];

  @override
  final String wireName = r'CreatedMcpApiKeyDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreatedMcpApiKeyDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(McpApiKeyDto),
    );
    yield r'secret';
    yield serializers.serialize(
      object.secret,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreatedMcpApiKeyDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreatedMcpApiKeyDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(McpApiKeyDto),
          ) as McpApiKeyDto;
          result.key.replace(valueDes);
          break;
        case r'secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.secret = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreatedMcpApiKeyDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreatedMcpApiKeyDtoBuilder();
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

