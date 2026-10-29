//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_access_level.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_permission_set.g.dart';

/// McpPermissionSet
///
/// Properties:
/// * [areas] 
/// * [allowDestructive] 
/// * [microsoftAccountIds] 
@BuiltValue()
abstract class McpPermissionSet implements Built<McpPermissionSet, McpPermissionSetBuilder> {
  @BuiltValueField(wireName: r'areas')
  BuiltMap<String, McpAccessLevel>? get areas;

  @BuiltValueField(wireName: r'allowDestructive')
  bool? get allowDestructive;

  @BuiltValueField(wireName: r'microsoftAccountIds')
  BuiltList<String>? get microsoftAccountIds;

  McpPermissionSet._();

  factory McpPermissionSet([void updates(McpPermissionSetBuilder b)]) = _$McpPermissionSet;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(McpPermissionSetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<McpPermissionSet> get serializer => _$McpPermissionSetSerializer();
}

class _$McpPermissionSetSerializer implements PrimitiveSerializer<McpPermissionSet> {
  @override
  final Iterable<Type> types = const [McpPermissionSet, _$McpPermissionSet];

  @override
  final String wireName = r'McpPermissionSet';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    McpPermissionSet object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.areas != null) {
      yield r'areas';
      yield serializers.serialize(
        object.areas,
        specifiedType: const FullType(BuiltMap, [FullType(String), FullType(McpAccessLevel)]),
      );
    }
    if (object.allowDestructive != null) {
      yield r'allowDestructive';
      yield serializers.serialize(
        object.allowDestructive,
        specifiedType: const FullType(bool),
      );
    }
    if (object.microsoftAccountIds != null) {
      yield r'microsoftAccountIds';
      yield serializers.serialize(
        object.microsoftAccountIds,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    McpPermissionSet object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required McpPermissionSetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'areas':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType(McpAccessLevel)]),
          ) as BuiltMap<String, McpAccessLevel>;
          result.areas.replace(valueDes);
          break;
        case r'allowDestructive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allowDestructive = valueDes;
          break;
        case r'microsoftAccountIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.microsoftAccountIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  McpPermissionSet deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = McpPermissionSetBuilder();
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

