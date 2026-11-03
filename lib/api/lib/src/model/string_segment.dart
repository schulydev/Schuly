//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'string_segment.g.dart';

/// StringSegment
///
/// Properties:
/// * [buffer] 
/// * [offset] 
/// * [length] 
/// * [value] 
/// * [hasValue] 
@BuiltValue()
abstract class StringSegment implements Built<StringSegment, StringSegmentBuilder> {
  @BuiltValueField(wireName: r'buffer')
  String? get buffer;

  @BuiltValueField(wireName: r'offset')
  int? get offset;

  @BuiltValueField(wireName: r'length')
  int? get length;

  @BuiltValueField(wireName: r'value')
  String? get value;

  @BuiltValueField(wireName: r'hasValue')
  bool? get hasValue;

  StringSegment._();

  factory StringSegment([void updates(StringSegmentBuilder b)]) = _$StringSegment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StringSegmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StringSegment> get serializer => _$StringSegmentSerializer();
}

class _$StringSegmentSerializer implements PrimitiveSerializer<StringSegment> {
  @override
  final Iterable<Type> types = const [StringSegment, _$StringSegment];

  @override
  final String wireName = r'StringSegment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StringSegment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.buffer != null) {
      yield r'buffer';
      yield serializers.serialize(
        object.buffer,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.offset != null) {
      yield r'offset';
      yield serializers.serialize(
        object.offset,
        specifiedType: const FullType(int),
      );
    }
    if (object.length != null) {
      yield r'length';
      yield serializers.serialize(
        object.length,
        specifiedType: const FullType(int),
      );
    }
    if (object.value != null) {
      yield r'value';
      yield serializers.serialize(
        object.value,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.hasValue != null) {
      yield r'hasValue';
      yield serializers.serialize(
        object.hasValue,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StringSegment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StringSegmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'buffer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.buffer = valueDes;
          break;
        case r'offset':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.offset = valueDes;
          break;
        case r'length':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.length = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.value = valueDes;
          break;
        case r'hasValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasValue = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StringSegment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StringSegmentBuilder();
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

