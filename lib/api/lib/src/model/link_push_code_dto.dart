//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_push_code_dto.g.dart';

/// LinkPushCodeDto
///
/// Properties:
/// * [number] 
/// * [expiresAt] 
/// * [pollIntervalSeconds] 
@BuiltValue()
abstract class LinkPushCodeDto implements Built<LinkPushCodeDto, LinkPushCodeDtoBuilder> {
  @BuiltValueField(wireName: r'number')
  String? get number;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'pollIntervalSeconds')
  int get pollIntervalSeconds;

  LinkPushCodeDto._();

  factory LinkPushCodeDto([void updates(LinkPushCodeDtoBuilder b)]) = _$LinkPushCodeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkPushCodeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkPushCodeDto> get serializer => _$LinkPushCodeDtoSerializer();
}

class _$LinkPushCodeDtoSerializer implements PrimitiveSerializer<LinkPushCodeDto> {
  @override
  final Iterable<Type> types = const [LinkPushCodeDto, _$LinkPushCodeDto];

  @override
  final String wireName = r'LinkPushCodeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkPushCodeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'number';
    yield object.number == null ? null : serializers.serialize(
      object.number,
      specifiedType: const FullType.nullable(String),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'pollIntervalSeconds';
    yield serializers.serialize(
      object.pollIntervalSeconds,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkPushCodeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkPushCodeDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.number = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'pollIntervalSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pollIntervalSeconds = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkPushCodeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkPushCodeDtoBuilder();
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

