//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_settings_dto.g.dart';

/// HelplySettingsDto
///
/// Properties:
/// * [permissions] 
/// * [workspace] 
/// * [workspaceAvailable] 
@BuiltValue()
abstract class HelplySettingsDto implements Built<HelplySettingsDto, HelplySettingsDtoBuilder> {
  @BuiltValueField(wireName: r'permissions')
  McpPermissionSet get permissions;

  @BuiltValueField(wireName: r'workspace')
  bool get workspace;

  @BuiltValueField(wireName: r'workspaceAvailable')
  bool get workspaceAvailable;

  HelplySettingsDto._();

  factory HelplySettingsDto([void updates(HelplySettingsDtoBuilder b)]) = _$HelplySettingsDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplySettingsDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplySettingsDto> get serializer => _$HelplySettingsDtoSerializer();
}

class _$HelplySettingsDtoSerializer implements PrimitiveSerializer<HelplySettingsDto> {
  @override
  final Iterable<Type> types = const [HelplySettingsDto, _$HelplySettingsDto];

  @override
  final String wireName = r'HelplySettingsDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplySettingsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(McpPermissionSet),
    );
    yield r'workspace';
    yield serializers.serialize(
      object.workspace,
      specifiedType: const FullType(bool),
    );
    yield r'workspaceAvailable';
    yield serializers.serialize(
      object.workspaceAvailable,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplySettingsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplySettingsDtoBuilder result,
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
        case r'workspace':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.workspace = valueDes;
          break;
        case r'workspaceAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.workspaceAvailable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplySettingsDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplySettingsDtoBuilder();
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

