//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/mcp_permission_set.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_authorization_request_dto.g.dart';

/// McpAuthorizationRequestDto
///
/// Properties:
/// * [valid] 
/// * [error] 
/// * [errorDescription] 
/// * [clientName] 
/// * [clientUri] 
/// * [redirectHost] 
/// * [requested] 
/// * [redirectUrl] 
@BuiltValue()
abstract class McpAuthorizationRequestDto implements Built<McpAuthorizationRequestDto, McpAuthorizationRequestDtoBuilder> {
  @BuiltValueField(wireName: r'valid')
  bool get valid;

  @BuiltValueField(wireName: r'error')
  String? get error;

  @BuiltValueField(wireName: r'errorDescription')
  String? get errorDescription;

  @BuiltValueField(wireName: r'clientName')
  String? get clientName;

  @BuiltValueField(wireName: r'clientUri')
  String? get clientUri;

  @BuiltValueField(wireName: r'redirectHost')
  String? get redirectHost;

  @BuiltValueField(wireName: r'requested')
  McpPermissionSet get requested;

  @BuiltValueField(wireName: r'redirectUrl')
  String? get redirectUrl;

  McpAuthorizationRequestDto._();

  factory McpAuthorizationRequestDto([void updates(McpAuthorizationRequestDtoBuilder b)]) = _$McpAuthorizationRequestDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(McpAuthorizationRequestDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<McpAuthorizationRequestDto> get serializer => _$McpAuthorizationRequestDtoSerializer();
}

class _$McpAuthorizationRequestDtoSerializer implements PrimitiveSerializer<McpAuthorizationRequestDto> {
  @override
  final Iterable<Type> types = const [McpAuthorizationRequestDto, _$McpAuthorizationRequestDto];

  @override
  final String wireName = r'McpAuthorizationRequestDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    McpAuthorizationRequestDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'valid';
    yield serializers.serialize(
      object.valid,
      specifiedType: const FullType(bool),
    );
    yield r'error';
    yield object.error == null ? null : serializers.serialize(
      object.error,
      specifiedType: const FullType.nullable(String),
    );
    yield r'errorDescription';
    yield object.errorDescription == null ? null : serializers.serialize(
      object.errorDescription,
      specifiedType: const FullType.nullable(String),
    );
    yield r'clientName';
    yield object.clientName == null ? null : serializers.serialize(
      object.clientName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'clientUri';
    yield object.clientUri == null ? null : serializers.serialize(
      object.clientUri,
      specifiedType: const FullType.nullable(String),
    );
    yield r'redirectHost';
    yield object.redirectHost == null ? null : serializers.serialize(
      object.redirectHost,
      specifiedType: const FullType.nullable(String),
    );
    yield r'requested';
    yield serializers.serialize(
      object.requested,
      specifiedType: const FullType(McpPermissionSet),
    );
    yield r'redirectUrl';
    yield object.redirectUrl == null ? null : serializers.serialize(
      object.redirectUrl,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    McpAuthorizationRequestDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required McpAuthorizationRequestDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'valid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.valid = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.error = valueDes;
          break;
        case r'errorDescription':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.errorDescription = valueDes;
          break;
        case r'clientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
        case r'redirectHost':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.redirectHost = valueDes;
          break;
        case r'requested':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(McpPermissionSet),
          ) as McpPermissionSet;
          result.requested.replace(valueDes);
          break;
        case r'redirectUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
  McpAuthorizationRequestDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = McpAuthorizationRequestDtoBuilder();
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

