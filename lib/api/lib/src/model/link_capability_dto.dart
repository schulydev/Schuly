//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_capability_dto.g.dart';

/// LinkCapabilityDto
///
/// Properties:
/// * [kind] 
/// * [label] 
/// * [icon] 
/// * [basePath] 
@BuiltValue()
abstract class LinkCapabilityDto implements Built<LinkCapabilityDto, LinkCapabilityDtoBuilder> {
  @BuiltValueField(wireName: r'kind')
  String get kind;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'icon')
  String? get icon;

  @BuiltValueField(wireName: r'basePath')
  String? get basePath;

  LinkCapabilityDto._();

  factory LinkCapabilityDto([void updates(LinkCapabilityDtoBuilder b)]) = _$LinkCapabilityDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkCapabilityDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkCapabilityDto> get serializer => _$LinkCapabilityDtoSerializer();
}

class _$LinkCapabilityDtoSerializer implements PrimitiveSerializer<LinkCapabilityDto> {
  @override
  final Iterable<Type> types = const [LinkCapabilityDto, _$LinkCapabilityDto];

  @override
  final String wireName = r'LinkCapabilityDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkCapabilityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(String),
    );
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'icon';
    yield object.icon == null ? null : serializers.serialize(
      object.icon,
      specifiedType: const FullType.nullable(String),
    );
    yield r'basePath';
    yield object.basePath == null ? null : serializers.serialize(
      object.basePath,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkCapabilityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkCapabilityDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.kind = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.icon = valueDes;
          break;
        case r'basePath':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.basePath = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkCapabilityDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkCapabilityDtoBuilder();
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

