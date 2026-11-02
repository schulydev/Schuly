//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_authorization_parameters.g.dart';

/// McpAuthorizationParameters
///
/// Properties:
/// * [responseType] 
/// * [clientId] 
/// * [redirectUri] 
/// * [scope] 
/// * [state] 
/// * [codeChallenge] 
/// * [codeChallengeMethod] 
/// * [resource] 
@BuiltValue()
abstract class McpAuthorizationParameters implements Built<McpAuthorizationParameters, McpAuthorizationParametersBuilder> {
  @BuiltValueField(wireName: r'responseType')
  String? get responseType;

  @BuiltValueField(wireName: r'clientId')
  String? get clientId;

  @BuiltValueField(wireName: r'redirectUri')
  String? get redirectUri;

  @BuiltValueField(wireName: r'scope')
  String? get scope;

  @BuiltValueField(wireName: r'state')
  String? get state;

  @BuiltValueField(wireName: r'codeChallenge')
  String? get codeChallenge;

  @BuiltValueField(wireName: r'codeChallengeMethod')
  String? get codeChallengeMethod;

  @BuiltValueField(wireName: r'resource')
  String? get resource;

  McpAuthorizationParameters._();

  factory McpAuthorizationParameters([void updates(McpAuthorizationParametersBuilder b)]) = _$McpAuthorizationParameters;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(McpAuthorizationParametersBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<McpAuthorizationParameters> get serializer => _$McpAuthorizationParametersSerializer();
}

class _$McpAuthorizationParametersSerializer implements PrimitiveSerializer<McpAuthorizationParameters> {
  @override
  final Iterable<Type> types = const [McpAuthorizationParameters, _$McpAuthorizationParameters];

  @override
  final String wireName = r'McpAuthorizationParameters';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    McpAuthorizationParameters object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'responseType';
    yield object.responseType == null ? null : serializers.serialize(
      object.responseType,
      specifiedType: const FullType.nullable(String),
    );
    yield r'clientId';
    yield object.clientId == null ? null : serializers.serialize(
      object.clientId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'redirectUri';
    yield object.redirectUri == null ? null : serializers.serialize(
      object.redirectUri,
      specifiedType: const FullType.nullable(String),
    );
    yield r'scope';
    yield object.scope == null ? null : serializers.serialize(
      object.scope,
      specifiedType: const FullType.nullable(String),
    );
    yield r'state';
    yield object.state == null ? null : serializers.serialize(
      object.state,
      specifiedType: const FullType.nullable(String),
    );
    yield r'codeChallenge';
    yield object.codeChallenge == null ? null : serializers.serialize(
      object.codeChallenge,
      specifiedType: const FullType.nullable(String),
    );
    yield r'codeChallengeMethod';
    yield object.codeChallengeMethod == null ? null : serializers.serialize(
      object.codeChallengeMethod,
      specifiedType: const FullType.nullable(String),
    );
    yield r'resource';
    yield object.resource == null ? null : serializers.serialize(
      object.resource,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    McpAuthorizationParameters object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required McpAuthorizationParametersBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'responseType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.responseType = valueDes;
          break;
        case r'clientId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.clientId = valueDes;
          break;
        case r'redirectUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.redirectUri = valueDes;
          break;
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'codeChallenge':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.codeChallenge = valueDes;
          break;
        case r'codeChallengeMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.codeChallengeMethod = valueDes;
          break;
        case r'resource':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.resource = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  McpAuthorizationParameters deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = McpAuthorizationParametersBuilder();
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

