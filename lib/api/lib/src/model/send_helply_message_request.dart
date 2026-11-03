//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'send_helply_message_request.g.dart';

/// SendHelplyMessageRequest
///
/// Properties:
/// * [text] 
/// * [attachmentIds] 
@BuiltValue()
abstract class SendHelplyMessageRequest implements Built<SendHelplyMessageRequest, SendHelplyMessageRequestBuilder> {
  @BuiltValueField(wireName: r'text')
  String? get text;

  @BuiltValueField(wireName: r'attachmentIds')
  BuiltList<String>? get attachmentIds;

  SendHelplyMessageRequest._();

  factory SendHelplyMessageRequest([void updates(SendHelplyMessageRequestBuilder b)]) = _$SendHelplyMessageRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SendHelplyMessageRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SendHelplyMessageRequest> get serializer => _$SendHelplyMessageRequestSerializer();
}

class _$SendHelplyMessageRequestSerializer implements PrimitiveSerializer<SendHelplyMessageRequest> {
  @override
  final Iterable<Type> types = const [SendHelplyMessageRequest, _$SendHelplyMessageRequest];

  @override
  final String wireName = r'SendHelplyMessageRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SendHelplyMessageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'text';
    yield object.text == null ? null : serializers.serialize(
      object.text,
      specifiedType: const FullType.nullable(String),
    );
    yield r'attachmentIds';
    yield object.attachmentIds == null ? null : serializers.serialize(
      object.attachmentIds,
      specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SendHelplyMessageRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SendHelplyMessageRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'text':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.text = valueDes;
          break;
        case r'attachmentIds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.attachmentIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SendHelplyMessageRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SendHelplyMessageRequestBuilder();
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

