//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/export_helply_conversation_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_helply_dto.g.dart';

/// ExportHelplyDto
///
/// Properties:
/// * [permissions] 
/// * [workspaceEnabled] 
/// * [conversations] 
@BuiltValue()
abstract class ExportHelplyDto implements Built<ExportHelplyDto, ExportHelplyDtoBuilder> {
  @BuiltValueField(wireName: r'permissions')
  McpPermissionSet get permissions;

  @BuiltValueField(wireName: r'workspaceEnabled')
  bool get workspaceEnabled;

  @BuiltValueField(wireName: r'conversations')
  BuiltList<ExportHelplyConversationDto> get conversations;

  ExportHelplyDto._();

  factory ExportHelplyDto([void updates(ExportHelplyDtoBuilder b)]) = _$ExportHelplyDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportHelplyDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportHelplyDto> get serializer => _$ExportHelplyDtoSerializer();
}

class _$ExportHelplyDtoSerializer implements PrimitiveSerializer<ExportHelplyDto> {
  @override
  final Iterable<Type> types = const [ExportHelplyDto, _$ExportHelplyDto];

  @override
  final String wireName = r'ExportHelplyDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportHelplyDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(McpPermissionSet),
    );
    yield r'workspaceEnabled';
    yield serializers.serialize(
      object.workspaceEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'conversations';
    yield serializers.serialize(
      object.conversations,
      specifiedType: const FullType(BuiltList, [FullType(ExportHelplyConversationDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportHelplyDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportHelplyDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(McpPermissionSet),
          ) as McpPermissionSet;
          result.permissions.replace(valueDes);
          break;
        case r'workspaceEnabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.workspaceEnabled = valueDes;
          break;
        case r'conversations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportHelplyConversationDto)]),
          ) as BuiltList<ExportHelplyConversationDto>;
          result.conversations.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportHelplyDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportHelplyDtoBuilder();
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

