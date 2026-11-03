//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_helply_attachment_dto.g.dart';

/// ExportHelplyAttachmentDto
///
/// Properties:
/// * [fileName] 
/// * [sizeBytes] 
/// * [createdAt] 
@BuiltValue()
abstract class ExportHelplyAttachmentDto implements Built<ExportHelplyAttachmentDto, ExportHelplyAttachmentDtoBuilder> {
  @BuiltValueField(wireName: r'fileName')
  String get fileName;

  @BuiltValueField(wireName: r'sizeBytes')
  int get sizeBytes;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  ExportHelplyAttachmentDto._();

  factory ExportHelplyAttachmentDto([void updates(ExportHelplyAttachmentDtoBuilder b)]) = _$ExportHelplyAttachmentDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportHelplyAttachmentDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportHelplyAttachmentDto> get serializer => _$ExportHelplyAttachmentDtoSerializer();
}

class _$ExportHelplyAttachmentDtoSerializer implements PrimitiveSerializer<ExportHelplyAttachmentDto> {
  @override
  final Iterable<Type> types = const [ExportHelplyAttachmentDto, _$ExportHelplyAttachmentDto];

  @override
  final String wireName = r'ExportHelplyAttachmentDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportHelplyAttachmentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'fileName';
    yield serializers.serialize(
      object.fileName,
      specifiedType: const FullType(String),
    );
    yield r'sizeBytes';
    yield serializers.serialize(
      object.sizeBytes,
      specifiedType: const FullType(int),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportHelplyAttachmentDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportHelplyAttachmentDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fileName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileName = valueDes;
          break;
        case r'sizeBytes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sizeBytes = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportHelplyAttachmentDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportHelplyAttachmentDtoBuilder();
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

