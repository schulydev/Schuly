//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/export_helply_attachment_dto.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_helply_conversation_dto.g.dart';

/// ExportHelplyConversationDto
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [messages] 
/// * [modelHistory] 
/// * [lastActivityAt] 
/// * [expiresAt] 
/// * [attachments] 
@BuiltValue()
abstract class ExportHelplyConversationDto implements Built<ExportHelplyConversationDto, ExportHelplyConversationDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'messages')
  JsonObject? get messages;

  @BuiltValueField(wireName: r'modelHistory')
  String? get modelHistory;

  @BuiltValueField(wireName: r'lastActivityAt')
  DateTime get lastActivityAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<ExportHelplyAttachmentDto> get attachments;

  ExportHelplyConversationDto._();

  factory ExportHelplyConversationDto([void updates(ExportHelplyConversationDtoBuilder b)]) = _$ExportHelplyConversationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportHelplyConversationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportHelplyConversationDto> get serializer => _$ExportHelplyConversationDtoSerializer();
}

class _$ExportHelplyConversationDtoSerializer implements PrimitiveSerializer<ExportHelplyConversationDto> {
  @override
  final Iterable<Type> types = const [ExportHelplyConversationDto, _$ExportHelplyConversationDto];

  @override
  final String wireName = r'ExportHelplyConversationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportHelplyConversationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'messages';
    yield object.messages == null ? null : serializers.serialize(
      object.messages,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'modelHistory';
    yield object.modelHistory == null ? null : serializers.serialize(
      object.modelHistory,
      specifiedType: const FullType.nullable(String),
    );
    yield r'lastActivityAt';
    yield serializers.serialize(
      object.lastActivityAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'attachments';
    yield serializers.serialize(
      object.attachments,
      specifiedType: const FullType(BuiltList, [FullType(ExportHelplyAttachmentDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportHelplyConversationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportHelplyConversationDtoBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.messages = valueDes;
          break;
        case r'modelHistory':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.modelHistory = valueDes;
          break;
        case r'lastActivityAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastActivityAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportHelplyAttachmentDto)]),
          ) as BuiltList<ExportHelplyAttachmentDto>;
          result.attachments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportHelplyConversationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportHelplyConversationDtoBuilder();
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

