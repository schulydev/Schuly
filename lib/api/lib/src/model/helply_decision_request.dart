//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_decision_request.g.dart';

/// HelplyDecisionRequest
///
/// Properties:
/// * [approvalId] 
/// * [approved] 
@BuiltValue()
abstract class HelplyDecisionRequest implements Built<HelplyDecisionRequest, HelplyDecisionRequestBuilder> {
  @BuiltValueField(wireName: r'approvalId')
  String? get approvalId;

  @BuiltValueField(wireName: r'approved')
  bool get approved;

  HelplyDecisionRequest._();

  factory HelplyDecisionRequest([void updates(HelplyDecisionRequestBuilder b)]) = _$HelplyDecisionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyDecisionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyDecisionRequest> get serializer => _$HelplyDecisionRequestSerializer();
}

class _$HelplyDecisionRequestSerializer implements PrimitiveSerializer<HelplyDecisionRequest> {
  @override
  final Iterable<Type> types = const [HelplyDecisionRequest, _$HelplyDecisionRequest];

  @override
  final String wireName = r'HelplyDecisionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'approvalId';
    yield object.approvalId == null ? null : serializers.serialize(
      object.approvalId,
      specifiedType: const FullType.nullable(String),
    );
    yield r'approved';
    yield serializers.serialize(
      object.approved,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyDecisionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyDecisionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'approvalId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.approvalId = valueDes;
          break;
        case r'approved':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.approved = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyDecisionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyDecisionRequestBuilder();
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

