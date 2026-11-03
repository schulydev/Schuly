//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_helply_conversation_request.g.dart';

/// CreateHelplyConversationRequest
///
/// Properties:
/// * [title] 
@BuiltValue()
abstract class CreateHelplyConversationRequest implements Built<CreateHelplyConversationRequest, CreateHelplyConversationRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  CreateHelplyConversationRequest._();

  factory CreateHelplyConversationRequest([void updates(CreateHelplyConversationRequestBuilder b)]) = _$CreateHelplyConversationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateHelplyConversationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateHelplyConversationRequest> get serializer => _$CreateHelplyConversationRequestSerializer();
}

class _$CreateHelplyConversationRequestSerializer implements PrimitiveSerializer<CreateHelplyConversationRequest> {
  @override
  final Iterable<Type> types = const [CreateHelplyConversationRequest, _$CreateHelplyConversationRequest];

  @override
  final String wireName = r'CreateHelplyConversationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateHelplyConversationRequest object, {
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
    CreateHelplyConversationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateHelplyConversationRequestBuilder result,
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
  CreateHelplyConversationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateHelplyConversationRequestBuilder();
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

