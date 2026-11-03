//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/helply_message_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/helply_approval_request_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_conversation_dto.g.dart';

/// HelplyConversationDto
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [expiresAt] 
/// * [messages] 
/// * [pendingApprovals] 
@BuiltValue()
abstract class HelplyConversationDto implements Built<HelplyConversationDto, HelplyConversationDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime get updatedAt;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'messages')
  BuiltList<HelplyMessageDto> get messages;

  @BuiltValueField(wireName: r'pendingApprovals')
  BuiltList<HelplyApprovalRequestDto> get pendingApprovals;

  HelplyConversationDto._();

  factory HelplyConversationDto([void updates(HelplyConversationDtoBuilder b)]) = _$HelplyConversationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyConversationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyConversationDto> get serializer => _$HelplyConversationDtoSerializer();
}

class _$HelplyConversationDtoSerializer implements PrimitiveSerializer<HelplyConversationDto> {
  @override
  final Iterable<Type> types = const [HelplyConversationDto, _$HelplyConversationDto];

  @override
  final String wireName = r'HelplyConversationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyConversationDto object, {
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
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'updatedAt';
    yield serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'messages';
    yield serializers.serialize(
      object.messages,
      specifiedType: const FullType(BuiltList, [FullType(HelplyMessageDto)]),
    );
    yield r'pendingApprovals';
    yield serializers.serialize(
      object.pendingApprovals,
      specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalRequestDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyConversationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyConversationDtoBuilder result,
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
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'messages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyMessageDto)]),
          ) as BuiltList<HelplyMessageDto>;
          result.messages.replace(valueDes);
          break;
        case r'pendingApprovals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalRequestDto)]),
          ) as BuiltList<HelplyApprovalRequestDto>;
          result.pendingApprovals.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyConversationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyConversationDtoBuilder();
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

