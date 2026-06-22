//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unified_login_request.g.dart';

/// UnifiedLoginRequest
///
/// Properties:
/// * [systemKey] 
/// * [fields] 
/// * [displayName] 
@BuiltValue()
abstract class UnifiedLoginRequest implements Built<UnifiedLoginRequest, UnifiedLoginRequestBuilder> {
  @BuiltValueField(wireName: r'systemKey')
  String get systemKey;

  @BuiltValueField(wireName: r'fields')
  BuiltMap<String, String>? get fields;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  UnifiedLoginRequest._();

  factory UnifiedLoginRequest([void updates(UnifiedLoginRequestBuilder b)]) = _$UnifiedLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnifiedLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnifiedLoginRequest> get serializer => _$UnifiedLoginRequestSerializer();
}

class _$UnifiedLoginRequestSerializer implements PrimitiveSerializer<UnifiedLoginRequest> {
  @override
  final Iterable<Type> types = const [UnifiedLoginRequest, _$UnifiedLoginRequest];

  @override
  final String wireName = r'UnifiedLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnifiedLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'systemKey';
    yield serializers.serialize(
      object.systemKey,
      specifiedType: const FullType(String),
    );
    yield r'fields';
    yield object.fields == null ? null : serializers.serialize(
      object.fields,
      specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
    );
    yield r'displayName';
    yield object.displayName == null ? null : serializers.serialize(
      object.displayName,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnifiedLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnifiedLoginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'systemKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.systemKey = valueDes;
          break;
        case r'fields':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>?;
          if (valueDes == null) continue;
          result.fields.replace(valueDes);
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnifiedLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnifiedLoginRequestBuilder();
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

