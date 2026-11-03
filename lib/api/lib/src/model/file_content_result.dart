//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/entity_tag_header_value.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_content_result.g.dart';

/// FileContentResult
///
/// Properties:
/// * [fileContents] 
/// * [contentType] 
/// * [fileDownloadName] 
/// * [lastModified] 
/// * [entityTag] 
/// * [enableRangeProcessing] 
@BuiltValue()
abstract class FileContentResult implements Built<FileContentResult, FileContentResultBuilder> {
  @BuiltValueField(wireName: r'fileContents')
  String? get fileContents;

  @BuiltValueField(wireName: r'contentType')
  String? get contentType;

  @BuiltValueField(wireName: r'fileDownloadName')
  String? get fileDownloadName;

  @BuiltValueField(wireName: r'lastModified')
  DateTime? get lastModified;

  @BuiltValueField(wireName: r'entityTag')
  EntityTagHeaderValue? get entityTag;

  @BuiltValueField(wireName: r'enableRangeProcessing')
  bool? get enableRangeProcessing;

  FileContentResult._();

  factory FileContentResult([void updates(FileContentResultBuilder b)]) = _$FileContentResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileContentResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileContentResult> get serializer => _$FileContentResultSerializer();
}

class _$FileContentResultSerializer implements PrimitiveSerializer<FileContentResult> {
  @override
  final Iterable<Type> types = const [FileContentResult, _$FileContentResult];

  @override
  final String wireName = r'FileContentResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileContentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.fileContents != null) {
      yield r'fileContents';
      yield serializers.serialize(
        object.fileContents,
        specifiedType: const FullType(String),
      );
    }
    if (object.contentType != null) {
      yield r'contentType';
      yield serializers.serialize(
        object.contentType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.fileDownloadName != null) {
      yield r'fileDownloadName';
      yield serializers.serialize(
        object.fileDownloadName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.lastModified != null) {
      yield r'lastModified';
      yield serializers.serialize(
        object.lastModified,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.entityTag != null) {
      yield r'entityTag';
      yield serializers.serialize(
        object.entityTag,
        specifiedType: const FullType.nullable(EntityTagHeaderValue),
      );
    }
    if (object.enableRangeProcessing != null) {
      yield r'enableRangeProcessing';
      yield serializers.serialize(
        object.enableRangeProcessing,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FileContentResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileContentResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'fileContents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fileContents = valueDes;
          break;
        case r'contentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.contentType = valueDes;
          break;
        case r'fileDownloadName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fileDownloadName = valueDes;
          break;
        case r'lastModified':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastModified = valueDes;
          break;
        case r'entityTag':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(EntityTagHeaderValue),
          ) as EntityTagHeaderValue?;
          if (valueDes == null) continue;
          result.entityTag.replace(valueDes);
          break;
        case r'enableRangeProcessing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enableRangeProcessing = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileContentResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileContentResultBuilder();
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

