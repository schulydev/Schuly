//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/helply_attachment_dto.dart';
import 'package:schuly_api/src/model/helply_tool_activity_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_message_dto.g.dart';

/// HelplyMessageDto
///
/// Properties:
/// * [id] 
/// * [role] 
/// * [text] 
/// * [createdAt] 
/// * [tools] 
/// * [failed] 
/// * [attachments] 
@BuiltValue()
abstract class HelplyMessageDto implements Built<HelplyMessageDto, HelplyMessageDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'text')
  String get text;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'tools')
  BuiltList<HelplyToolActivityDto> get tools;

  @BuiltValueField(wireName: r'failed')
  bool get failed;

  @BuiltValueField(wireName: r'attachments')
  BuiltList<HelplyAttachmentDto> get attachments;

  HelplyMessageDto._();

  factory HelplyMessageDto([void updates(HelplyMessageDtoBuilder b)]) = _$HelplyMessageDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyMessageDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyMessageDto> get serializer => _$HelplyMessageDtoSerializer();
}

class _$HelplyMessageDtoSerializer implements PrimitiveSerializer<HelplyMessageDto> {
  @override
  final Iterable<Type> types = const [HelplyMessageDto, _$HelplyMessageDto];

  @override
  final String wireName = r'HelplyMessageDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyMessageDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'text';
    yield serializers.serialize(
      object.text,
      specifiedType: const FullType(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'tools';
    yield serializers.serialize(
      object.tools,
      specifiedType: const FullType(BuiltList, [FullType(HelplyToolActivityDto)]),
    );
    yield r'failed';
    yield serializers.serialize(
      object.failed,
      specifiedType: const FullType(bool),
    );
    yield r'attachments';
    yield serializers.serialize(
      object.attachments,
      specifiedType: const FullType(BuiltList, [FullType(HelplyAttachmentDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyMessageDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyMessageDtoBuilder result,
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
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.text = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'tools':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyToolActivityDto)]),
          ) as BuiltList<HelplyToolActivityDto>;
          result.tools.replace(valueDes);
          break;
        case r'failed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.failed = valueDes;
          break;
        case r'attachments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyAttachmentDto)]),
          ) as BuiltList<HelplyAttachmentDto>;
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
  HelplyMessageDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyMessageDtoBuilder();
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

