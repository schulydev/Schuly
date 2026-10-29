//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_done_dto.g.dart';

/// LinkDoneDto
///
/// Properties:
/// * [accountId] 
/// * [title] 
@BuiltValue()
abstract class LinkDoneDto implements Built<LinkDoneDto, LinkDoneDtoBuilder> {
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  @BuiltValueField(wireName: r'title')
  String? get title;

  LinkDoneDto._();

  factory LinkDoneDto([void updates(LinkDoneDtoBuilder b)]) = _$LinkDoneDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkDoneDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkDoneDto> get serializer => _$LinkDoneDtoSerializer();
}

class _$LinkDoneDtoSerializer implements PrimitiveSerializer<LinkDoneDto> {
  @override
  final Iterable<Type> types = const [LinkDoneDto, _$LinkDoneDto];

  @override
  final String wireName = r'LinkDoneDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkDoneDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkDoneDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkDoneDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkDoneDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkDoneDtoBuilder();
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

