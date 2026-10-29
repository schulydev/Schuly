//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_authorization_parameters.dart';
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'decide_mcp_authorization_command.g.dart';

/// DecideMcpAuthorizationCommand
///
/// Properties:
/// * [parameters] 
/// * [approve] 
/// * [permissions] 
@BuiltValue()
abstract class DecideMcpAuthorizationCommand implements Built<DecideMcpAuthorizationCommand, DecideMcpAuthorizationCommandBuilder> {
  @BuiltValueField(wireName: r'parameters')
  McpAuthorizationParameters get parameters;

  @BuiltValueField(wireName: r'approve')
  bool get approve;

  @BuiltValueField(wireName: r'permissions')
  McpPermissionSet? get permissions;

  DecideMcpAuthorizationCommand._();

  factory DecideMcpAuthorizationCommand([void updates(DecideMcpAuthorizationCommandBuilder b)]) = _$DecideMcpAuthorizationCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DecideMcpAuthorizationCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DecideMcpAuthorizationCommand> get serializer => _$DecideMcpAuthorizationCommandSerializer();
}

class _$DecideMcpAuthorizationCommandSerializer implements PrimitiveSerializer<DecideMcpAuthorizationCommand> {
  @override
  final Iterable<Type> types = const [DecideMcpAuthorizationCommand, _$DecideMcpAuthorizationCommand];

  @override
  final String wireName = r'DecideMcpAuthorizationCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DecideMcpAuthorizationCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'parameters';
    yield serializers.serialize(
      object.parameters,
      specifiedType: const FullType(McpAuthorizationParameters),
    );
    yield r'approve';
    yield serializers.serialize(
      object.approve,
      specifiedType: const FullType(bool),
    );
    yield r'permissions';
    yield object.permissions == null ? null : serializers.serialize(
      object.permissions,
      specifiedType: const FullType.nullable(McpPermissionSet),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DecideMcpAuthorizationCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DecideMcpAuthorizationCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'parameters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(McpAuthorizationParameters),
          ) as McpAuthorizationParameters;
          result.parameters.replace(valueDes);
          break;
        case r'approve':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.approve = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(McpPermissionSet),
          ) as McpPermissionSet?;
          if (valueDes == null) continue;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DecideMcpAuthorizationCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DecideMcpAuthorizationCommandBuilder();
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

