//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_otp_dto.g.dart';

/// LinkOtpDto
///
/// Properties:
/// * [length] 
/// * [label] 
/// * [numericOnly] 
@BuiltValue()
abstract class LinkOtpDto implements Built<LinkOtpDto, LinkOtpDtoBuilder> {
  @BuiltValueField(wireName: r'length')
  int get length;

  @BuiltValueField(wireName: r'label')
  String? get label;

  @BuiltValueField(wireName: r'numericOnly')
  bool get numericOnly;

  LinkOtpDto._();

  factory LinkOtpDto([void updates(LinkOtpDtoBuilder b)]) = _$LinkOtpDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkOtpDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkOtpDto> get serializer => _$LinkOtpDtoSerializer();
}

class _$LinkOtpDtoSerializer implements PrimitiveSerializer<LinkOtpDto> {
  @override
  final Iterable<Type> types = const [LinkOtpDto, _$LinkOtpDto];

  @override
  final String wireName = r'LinkOtpDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'length';
    yield serializers.serialize(
      object.length,
      specifiedType: const FullType(int),
    );
    yield r'label';
    yield object.label == null ? null : serializers.serialize(
      object.label,
      specifiedType: const FullType.nullable(String),
    );
    yield r'numericOnly';
    yield serializers.serialize(
      object.numericOnly,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkOtpDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkOtpDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'length':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.length = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.label = valueDes;
          break;
        case r'numericOnly':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.numericOnly = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkOtpDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkOtpDtoBuilder();
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

