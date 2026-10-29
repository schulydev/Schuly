//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_authorization_decision_dto.g.dart';

/// McpAuthorizationDecisionDto
///
/// Properties:
/// * [redirectUrl] 
@BuiltValue()
abstract class McpAuthorizationDecisionDto implements Built<McpAuthorizationDecisionDto, McpAuthorizationDecisionDtoBuilder> {
  @BuiltValueField(wireName: r'redirectUrl')
  String get redirectUrl;

  McpAuthorizationDecisionDto._();

  factory McpAuthorizationDecisionDto([void updates(McpAuthorizationDecisionDtoBuilder b)]) = _$McpAuthorizationDecisionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(McpAuthorizationDecisionDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<McpAuthorizationDecisionDto> get serializer => _$McpAuthorizationDecisionDtoSerializer();
}

class _$McpAuthorizationDecisionDtoSerializer implements PrimitiveSerializer<McpAuthorizationDecisionDto> {
  @override
  final Iterable<Type> types = const [McpAuthorizationDecisionDto, _$McpAuthorizationDecisionDto];

  @override
  final String wireName = r'McpAuthorizationDecisionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    McpAuthorizationDecisionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'redirectUrl';
    yield serializers.serialize(
      object.redirectUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    McpAuthorizationDecisionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required McpAuthorizationDecisionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'redirectUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.redirectUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  McpAuthorizationDecisionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = McpAuthorizationDecisionDtoBuilder();
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

