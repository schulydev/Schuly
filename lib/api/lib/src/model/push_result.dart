//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'push_result.g.dart';

/// PushResult
///
/// Properties:
/// * [successCount] 
/// * [failureCount] 
/// * [unregisteredTokens] 
@BuiltValue()
abstract class PushResult implements Built<PushResult, PushResultBuilder> {
  @BuiltValueField(wireName: r'successCount')
  int get successCount;

  @BuiltValueField(wireName: r'failureCount')
  int get failureCount;

  @BuiltValueField(wireName: r'unregisteredTokens')
  BuiltList<String> get unregisteredTokens;

  PushResult._();

  factory PushResult([void updates(PushResultBuilder b)]) = _$PushResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PushResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PushResult> get serializer => _$PushResultSerializer();
}

class _$PushResultSerializer implements PrimitiveSerializer<PushResult> {
  @override
  final Iterable<Type> types = const [PushResult, _$PushResult];

  @override
  final String wireName = r'PushResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PushResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'successCount';
    yield serializers.serialize(
      object.successCount,
      specifiedType: const FullType(int),
    );
    yield r'failureCount';
    yield serializers.serialize(
      object.failureCount,
      specifiedType: const FullType(int),
    );
    yield r'unregisteredTokens';
    yield serializers.serialize(
      object.unregisteredTokens,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PushResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PushResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'successCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.successCount = valueDes;
          break;
        case r'failureCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failureCount = valueDes;
          break;
        case r'unregisteredTokens':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.unregisteredTokens.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PushResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PushResultBuilder();
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

