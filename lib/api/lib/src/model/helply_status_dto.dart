//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_status_dto.g.dart';

/// HelplyStatusDto
///
/// Properties:
/// * [enabled] 
@BuiltValue()
abstract class HelplyStatusDto implements Built<HelplyStatusDto, HelplyStatusDtoBuilder> {
  @BuiltValueField(wireName: r'enabled')
  bool get enabled;

  HelplyStatusDto._();

  factory HelplyStatusDto([void updates(HelplyStatusDtoBuilder b)]) = _$HelplyStatusDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyStatusDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyStatusDto> get serializer => _$HelplyStatusDtoSerializer();
}

class _$HelplyStatusDtoSerializer implements PrimitiveSerializer<HelplyStatusDto> {
  @override
  final Iterable<Type> types = const [HelplyStatusDto, _$HelplyStatusDto];

  @override
  final String wireName = r'HelplyStatusDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'enabled';
    yield serializers.serialize(
      object.enabled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyStatusDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyStatusDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyStatusDtoBuilder();
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

