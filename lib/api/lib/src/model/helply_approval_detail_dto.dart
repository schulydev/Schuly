//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_approval_detail_dto.g.dart';

/// HelplyApprovalDetailDto
///
/// Properties:
/// * [label] 
/// * [value] 
@BuiltValue()
abstract class HelplyApprovalDetailDto implements Built<HelplyApprovalDetailDto, HelplyApprovalDetailDtoBuilder> {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'value')
  String get value;

  HelplyApprovalDetailDto._();

  factory HelplyApprovalDetailDto([void updates(HelplyApprovalDetailDtoBuilder b)]) = _$HelplyApprovalDetailDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyApprovalDetailDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyApprovalDetailDto> get serializer => _$HelplyApprovalDetailDtoSerializer();
}

class _$HelplyApprovalDetailDtoSerializer implements PrimitiveSerializer<HelplyApprovalDetailDto> {
  @override
  final Iterable<Type> types = const [HelplyApprovalDetailDto, _$HelplyApprovalDetailDto];

  @override
  final String wireName = r'HelplyApprovalDetailDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyApprovalDetailDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyApprovalDetailDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyApprovalDetailDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyApprovalDetailDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyApprovalDetailDtoBuilder();
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

