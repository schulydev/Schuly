//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_attachment_dto.g.dart';

/// HelplyAttachmentDto
///
/// Properties:
/// * [id] 
/// * [fileName] 
/// * [mediaType] 
/// * [sizeBytes] 
@BuiltValue()
abstract class HelplyAttachmentDto implements Built<HelplyAttachmentDto, HelplyAttachmentDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'fileName')
  String get fileName;

  @BuiltValueField(wireName: r'mediaType')
  String get mediaType;

  @BuiltValueField(wireName: r'sizeBytes')
  int get sizeBytes;

  HelplyAttachmentDto._();

  factory HelplyAttachmentDto([void updates(HelplyAttachmentDtoBuilder b)]) = _$HelplyAttachmentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyAttachmentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyAttachmentDto> get serializer => _$HelplyAttachmentDtoSerializer();
}

class _$HelplyAttachmentDtoSerializer implements PrimitiveSerializer<HelplyAttachmentDto> {
  @override
  final Iterable<Type> types = const [HelplyAttachmentDto, _$HelplyAttachmentDto];

  @override
  final String wireName = r'HelplyAttachmentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyAttachmentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'fileName';
    yield serializers.serialize(
      object.fileName,
      specifiedType: const FullType(String),
    );
    yield r'mediaType';
    yield serializers.serialize(
      object.mediaType,
      specifiedType: const FullType(String),
    );
    yield r'sizeBytes';
    yield serializers.serialize(
      object.sizeBytes,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyAttachmentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyAttachmentDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'fileName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileName = valueDes;
          break;
        case r'mediaType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mediaType = valueDes;
          break;
        case r'sizeBytes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sizeBytes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyAttachmentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyAttachmentDtoBuilder();
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

