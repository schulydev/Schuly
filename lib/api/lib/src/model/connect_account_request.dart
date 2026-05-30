//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'connect_account_request.g.dart';

/// ConnectAccountRequest
///
/// Properties:
/// * [schulnetzBaseUrl] 
/// * [schulwareApiBaseUrl] 
/// * [displayName] 
/// * [schoolUserId] 
@BuiltValue()
abstract class ConnectAccountRequest implements Built<ConnectAccountRequest, ConnectAccountRequestBuilder> {
  @BuiltValueField(wireName: r'schulnetzBaseUrl')
  String get schulnetzBaseUrl;

  @BuiltValueField(wireName: r'schulwareApiBaseUrl')
  String? get schulwareApiBaseUrl;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'schoolUserId')
  String? get schoolUserId;

  ConnectAccountRequest._();

  factory ConnectAccountRequest([void updates(ConnectAccountRequestBuilder b)]) = _$ConnectAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConnectAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConnectAccountRequest> get serializer => _$ConnectAccountRequestSerializer();
}

class _$ConnectAccountRequestSerializer implements PrimitiveSerializer<ConnectAccountRequest> {
  @override
  final Iterable<Type> types = const [ConnectAccountRequest, _$ConnectAccountRequest];

  @override
  final String wireName = r'ConnectAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConnectAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'schulnetzBaseUrl';
    yield serializers.serialize(
      object.schulnetzBaseUrl,
      specifiedType: const FullType(String),
    );
    yield r'schulwareApiBaseUrl';
    yield object.schulwareApiBaseUrl == null ? null : serializers.serialize(
      object.schulwareApiBaseUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'displayName';
    yield object.displayName == null ? null : serializers.serialize(
      object.displayName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'schoolUserId';
    yield object.schoolUserId == null ? null : serializers.serialize(
      object.schoolUserId,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConnectAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConnectAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'schulnetzBaseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schulnetzBaseUrl = valueDes;
          break;
        case r'schulwareApiBaseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schulwareApiBaseUrl = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schoolUserId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConnectAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConnectAccountRequestBuilder();
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

