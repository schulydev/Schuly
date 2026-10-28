//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'stateless_refresh_request.g.dart';

/// StatelessRefreshRequest
///
/// Properties:
/// * [baseUrl] 
/// * [userAgent] 
/// * [contextState] 
@BuiltValue()
abstract class StatelessRefreshRequest implements Built<StatelessRefreshRequest, StatelessRefreshRequestBuilder> {
  @BuiltValueField(wireName: r'baseUrl')
  String get baseUrl;

  @BuiltValueField(wireName: r'userAgent')
  String get userAgent;

  @BuiltValueField(wireName: r'contextState')
  JsonObject? get contextState;

  StatelessRefreshRequest._();

  factory StatelessRefreshRequest([void updates(StatelessRefreshRequestBuilder b)]) = _$StatelessRefreshRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatelessRefreshRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatelessRefreshRequest> get serializer => _$StatelessRefreshRequestSerializer();
}

class _$StatelessRefreshRequestSerializer implements PrimitiveSerializer<StatelessRefreshRequest> {
  @override
  final Iterable<Type> types = const [StatelessRefreshRequest, _$StatelessRefreshRequest];

  @override
  final String wireName = r'StatelessRefreshRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatelessRefreshRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'baseUrl';
    yield serializers.serialize(
      object.baseUrl,
      specifiedType: const FullType(String),
    );
    yield r'userAgent';
    yield serializers.serialize(
      object.userAgent,
      specifiedType: const FullType(String),
    );
    yield r'contextState';
    yield object.contextState == null ? null : serializers.serialize(
      object.contextState,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StatelessRefreshRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StatelessRefreshRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'baseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.baseUrl = valueDes;
          break;
        case r'userAgent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userAgent = valueDes;
          break;
        case r'contextState':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.contextState = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatelessRefreshRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatelessRefreshRequestBuilder();
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

