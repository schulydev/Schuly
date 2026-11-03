//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_ai_app_connection_dto.g.dart';

/// ExportAiAppConnectionDto
///
/// Properties:
/// * [clientName] 
/// * [clientUri] 
/// * [permissions] 
/// * [createdAt] 
/// * [lastUsedAt] 
@BuiltValue()
abstract class ExportAiAppConnectionDto implements Built<ExportAiAppConnectionDto, ExportAiAppConnectionDtoBuilder> {
  @BuiltValueField(wireName: r'clientName')
  String get clientName;

  @BuiltValueField(wireName: r'clientUri')
  String? get clientUri;

  @BuiltValueField(wireName: r'permissions')
  McpPermissionSet get permissions;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'lastUsedAt')
  DateTime? get lastUsedAt;

  ExportAiAppConnectionDto._();

  factory ExportAiAppConnectionDto([void updates(ExportAiAppConnectionDtoBuilder b)]) = _$ExportAiAppConnectionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportAiAppConnectionDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportAiAppConnectionDto> get serializer => _$ExportAiAppConnectionDtoSerializer();
}

class _$ExportAiAppConnectionDtoSerializer implements PrimitiveSerializer<ExportAiAppConnectionDto> {
  @override
  final Iterable<Type> types = const [ExportAiAppConnectionDto, _$ExportAiAppConnectionDto];

  @override
  final String wireName = r'ExportAiAppConnectionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportAiAppConnectionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'clientName';
    yield serializers.serialize(
      object.clientName,
      specifiedType: const FullType(String),
    );
    yield r'clientUri';
    yield object.clientUri == null ? null : serializers.serialize(
      object.clientUri,
      specifiedType: const FullType.nullable(String),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(McpPermissionSet),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'lastUsedAt';
    yield object.lastUsedAt == null ? null : serializers.serialize(
      object.lastUsedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportAiAppConnectionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportAiAppConnectionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'clientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.clientName = valueDes;
          break;
        case r'clientUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientUri = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(McpPermissionSet),
          ) as McpPermissionSet;
          result.permissions.replace(valueDes);
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'lastUsedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastUsedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportAiAppConnectionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportAiAppConnectionDtoBuilder();
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

