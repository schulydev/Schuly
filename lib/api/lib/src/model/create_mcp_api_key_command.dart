//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_mcp_api_key_command.g.dart';

/// CreateMcpApiKeyCommand
///
/// Properties:
/// * [name] 
/// * [permissions] 
/// * [expiresAt] 
@BuiltValue()
abstract class CreateMcpApiKeyCommand implements Built<CreateMcpApiKeyCommand, CreateMcpApiKeyCommandBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'permissions')
  McpPermissionSet? get permissions;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  CreateMcpApiKeyCommand._();

  factory CreateMcpApiKeyCommand([void updates(CreateMcpApiKeyCommandBuilder b)]) = _$CreateMcpApiKeyCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMcpApiKeyCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMcpApiKeyCommand> get serializer => _$CreateMcpApiKeyCommandSerializer();
}

class _$CreateMcpApiKeyCommandSerializer implements PrimitiveSerializer<CreateMcpApiKeyCommand> {
  @override
  final Iterable<Type> types = const [CreateMcpApiKeyCommand, _$CreateMcpApiKeyCommand];

  @override
  final String wireName = r'CreateMcpApiKeyCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMcpApiKeyCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'permissions';
    yield object.permissions == null ? null : serializers.serialize(
      object.permissions,
      specifiedType: const FullType.nullable(McpPermissionSet),
    );
    yield r'expiresAt';
    yield object.expiresAt == null ? null : serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateMcpApiKeyCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateMcpApiKeyCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(McpPermissionSet),
          ) as McpPermissionSet?;
          if (valueDes == null) continue;
          result.permissions.replace(valueDes);
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateMcpApiKeyCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMcpApiKeyCommandBuilder();
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

