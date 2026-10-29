//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_error_dto.g.dart';

/// LinkErrorDto
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class LinkErrorDto implements Built<LinkErrorDto, LinkErrorDtoBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'errors')
  BuiltList<String>? get errors;

  LinkErrorDto._();

  factory LinkErrorDto([void updates(LinkErrorDtoBuilder b)]) = _$LinkErrorDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkErrorDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkErrorDto> get serializer => _$LinkErrorDtoSerializer();
}

class _$LinkErrorDtoSerializer implements PrimitiveSerializer<LinkErrorDto> {
  @override
  final Iterable<Type> types = const [LinkErrorDto, _$LinkErrorDto];

  @override
  final String wireName = r'LinkErrorDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkErrorDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    yield r'errors';
    yield object.errors == null ? null : serializers.serialize(
      object.errors,
      specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkErrorDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkErrorDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkErrorDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkErrorDtoBuilder();
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

