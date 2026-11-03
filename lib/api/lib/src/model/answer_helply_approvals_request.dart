//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/helply_decision_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'answer_helply_approvals_request.g.dart';

/// AnswerHelplyApprovalsRequest
///
/// Properties:
/// * [decisions] 
@BuiltValue()
abstract class AnswerHelplyApprovalsRequest implements Built<AnswerHelplyApprovalsRequest, AnswerHelplyApprovalsRequestBuilder> {
  @BuiltValueField(wireName: r'decisions')
  BuiltList<HelplyDecisionRequest>? get decisions;

  AnswerHelplyApprovalsRequest._();

  factory AnswerHelplyApprovalsRequest([void updates(AnswerHelplyApprovalsRequestBuilder b)]) = _$AnswerHelplyApprovalsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AnswerHelplyApprovalsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AnswerHelplyApprovalsRequest> get serializer => _$AnswerHelplyApprovalsRequestSerializer();
}

class _$AnswerHelplyApprovalsRequestSerializer implements PrimitiveSerializer<AnswerHelplyApprovalsRequest> {
  @override
  final Iterable<Type> types = const [AnswerHelplyApprovalsRequest, _$AnswerHelplyApprovalsRequest];

  @override
  final String wireName = r'AnswerHelplyApprovalsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AnswerHelplyApprovalsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'decisions';
    yield object.decisions == null ? null : serializers.serialize(
      object.decisions,
      specifiedType: const FullType.nullable(BuiltList, [FullType(HelplyDecisionRequest)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AnswerHelplyApprovalsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AnswerHelplyApprovalsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'decisions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(HelplyDecisionRequest)]),
          ) as BuiltList<HelplyDecisionRequest>?;
          if (valueDes == null) continue;
          result.decisions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AnswerHelplyApprovalsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AnswerHelplyApprovalsRequestBuilder();
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

