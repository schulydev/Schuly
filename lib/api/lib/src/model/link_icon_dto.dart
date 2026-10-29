//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_icon_dto.g.dart';

/// LinkIconDto
///
/// Properties:
/// * [lucide] 
/// * [svgUrl] 
@BuiltValue()
abstract class LinkIconDto implements Built<LinkIconDto, LinkIconDtoBuilder> {
  @BuiltValueField(wireName: r'lucide')
  String? get lucide;

  @BuiltValueField(wireName: r'svgUrl')
  String? get svgUrl;

  LinkIconDto._();

  factory LinkIconDto([void updates(LinkIconDtoBuilder b)]) = _$LinkIconDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkIconDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkIconDto> get serializer => _$LinkIconDtoSerializer();
}

class _$LinkIconDtoSerializer implements PrimitiveSerializer<LinkIconDto> {
  @override
  final Iterable<Type> types = const [LinkIconDto, _$LinkIconDto];

  @override
  final String wireName = r'LinkIconDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkIconDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'lucide';
    yield object.lucide == null ? null : serializers.serialize(
      object.lucide,
      specifiedType: const FullType.nullable(String),
    );
    yield r'svgUrl';
    yield object.svgUrl == null ? null : serializers.serialize(
      object.svgUrl,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkIconDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkIconDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'lucide':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lucide = valueDes;
          break;
        case r'svgUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.svgUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkIconDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkIconDtoBuilder();
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

