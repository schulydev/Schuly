//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/string_segment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'entity_tag_header_value.g.dart';

/// EntityTagHeaderValue
///
/// Properties:
/// * [tag] 
/// * [isWeak] 
@BuiltValue()
abstract class EntityTagHeaderValue implements Built<EntityTagHeaderValue, EntityTagHeaderValueBuilder> {
  @BuiltValueField(wireName: r'tag')
  StringSegment? get tag;

  @BuiltValueField(wireName: r'isWeak')
  bool? get isWeak;

  EntityTagHeaderValue._();

  factory EntityTagHeaderValue([void updates(EntityTagHeaderValueBuilder b)]) = _$EntityTagHeaderValue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EntityTagHeaderValueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EntityTagHeaderValue> get serializer => _$EntityTagHeaderValueSerializer();
}

class _$EntityTagHeaderValueSerializer implements PrimitiveSerializer<EntityTagHeaderValue> {
  @override
  final Iterable<Type> types = const [EntityTagHeaderValue, _$EntityTagHeaderValue];

  @override
  final String wireName = r'EntityTagHeaderValue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EntityTagHeaderValue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.tag != null) {
      yield r'tag';
      yield serializers.serialize(
        object.tag,
        specifiedType: const FullType(StringSegment),
      );
    }
    if (object.isWeak != null) {
      yield r'isWeak';
      yield serializers.serialize(
        object.isWeak,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EntityTagHeaderValue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EntityTagHeaderValueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tag':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StringSegment),
          ) as StringSegment;
          result.tag.replace(valueDes);
          break;
        case r'isWeak':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isWeak = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EntityTagHeaderValue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EntityTagHeaderValueBuilder();
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

