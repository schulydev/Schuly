//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_activity_dto.g.dart';

/// McpActivityDto
///
/// Properties:
/// * [toolName] 
/// * [allowed] 
/// * [at] 
@BuiltValue()
abstract class McpActivityDto implements Built<McpActivityDto, McpActivityDtoBuilder> {
  @BuiltValueField(wireName: r'toolName')
  String get toolName;

  @BuiltValueField(wireName: r'allowed')
  bool get allowed;

  @BuiltValueField(wireName: r'at')
  DateTime get at;

  McpActivityDto._();

  factory McpActivityDto([void updates(McpActivityDtoBuilder b)]) = _$McpActivityDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(McpActivityDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<McpActivityDto> get serializer => _$McpActivityDtoSerializer();
}

class _$McpActivityDtoSerializer implements PrimitiveSerializer<McpActivityDto> {
  @override
  final Iterable<Type> types = const [McpActivityDto, _$McpActivityDto];

  @override
  final String wireName = r'McpActivityDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    McpActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'toolName';
    yield serializers.serialize(
      object.toolName,
      specifiedType: const FullType(String),
    );
    yield r'allowed';
    yield serializers.serialize(
      object.allowed,
      specifiedType: const FullType(bool),
    );
    yield r'at';
    yield serializers.serialize(
      object.at,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    McpActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required McpActivityDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'toolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toolName = valueDes;
          break;
        case r'allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allowed = valueDes;
          break;
        case r'at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.at = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  McpActivityDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = McpActivityDtoBuilder();
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

