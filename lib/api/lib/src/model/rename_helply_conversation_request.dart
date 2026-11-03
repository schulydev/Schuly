//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rename_helply_conversation_request.g.dart';

/// RenameHelplyConversationRequest
///
/// Properties:
/// * [title] 
@BuiltValue()
abstract class RenameHelplyConversationRequest implements Built<RenameHelplyConversationRequest, RenameHelplyConversationRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  RenameHelplyConversationRequest._();

  factory RenameHelplyConversationRequest([void updates(RenameHelplyConversationRequestBuilder b)]) = _$RenameHelplyConversationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RenameHelplyConversationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RenameHelplyConversationRequest> get serializer => _$RenameHelplyConversationRequestSerializer();
}

class _$RenameHelplyConversationRequestSerializer implements PrimitiveSerializer<RenameHelplyConversationRequest> {
  @override
  final Iterable<Type> types = const [RenameHelplyConversationRequest, _$RenameHelplyConversationRequest];

  @override
  final String wireName = r'RenameHelplyConversationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RenameHelplyConversationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RenameHelplyConversationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RenameHelplyConversationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  RenameHelplyConversationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RenameHelplyConversationRequestBuilder();
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

