//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/helply_approval_detail_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_approval_request_dto.g.dart';

/// HelplyApprovalRequestDto
///
/// Properties:
/// * [approvalId] 
/// * [toolLabel] 
/// * [summary] 
/// * [details] 
/// * [destructive] 
/// * [arguments] 
/// * [risk] 
/// * [riskReasons] 
@BuiltValue()
abstract class HelplyApprovalRequestDto implements Built<HelplyApprovalRequestDto, HelplyApprovalRequestDtoBuilder> {
  @BuiltValueField(wireName: r'approvalId')
  String get approvalId;

  @BuiltValueField(wireName: r'toolLabel')
  String get toolLabel;

  @BuiltValueField(wireName: r'summary')
  String get summary;

  @BuiltValueField(wireName: r'details')
  BuiltList<HelplyApprovalDetailDto> get details;

  @BuiltValueField(wireName: r'destructive')
  bool get destructive;

  @BuiltValueField(wireName: r'arguments')
  BuiltList<HelplyApprovalDetailDto> get arguments;

  @BuiltValueField(wireName: r'risk')
  String get risk;

  @BuiltValueField(wireName: r'riskReasons')
  BuiltList<String> get riskReasons;

  HelplyApprovalRequestDto._();

  factory HelplyApprovalRequestDto([void updates(HelplyApprovalRequestDtoBuilder b)]) = _$HelplyApprovalRequestDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyApprovalRequestDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyApprovalRequestDto> get serializer => _$HelplyApprovalRequestDtoSerializer();
}

class _$HelplyApprovalRequestDtoSerializer implements PrimitiveSerializer<HelplyApprovalRequestDto> {
  @override
  final Iterable<Type> types = const [HelplyApprovalRequestDto, _$HelplyApprovalRequestDto];

  @override
  final String wireName = r'HelplyApprovalRequestDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyApprovalRequestDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'approvalId';
    yield serializers.serialize(
      object.approvalId,
      specifiedType: const FullType(String),
    );
    yield r'toolLabel';
    yield serializers.serialize(
      object.toolLabel,
      specifiedType: const FullType(String),
    );
    yield r'summary';
    yield serializers.serialize(
      object.summary,
      specifiedType: const FullType(String),
    );
    yield r'details';
    yield serializers.serialize(
      object.details,
      specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalDetailDto)]),
    );
    yield r'destructive';
    yield serializers.serialize(
      object.destructive,
      specifiedType: const FullType(bool),
    );
    yield r'arguments';
    yield serializers.serialize(
      object.arguments,
      specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalDetailDto)]),
    );
    yield r'risk';
    yield serializers.serialize(
      object.risk,
      specifiedType: const FullType(String),
    );
    yield r'riskReasons';
    yield serializers.serialize(
      object.riskReasons,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyApprovalRequestDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyApprovalRequestDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'approvalId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.approvalId = valueDes;
          break;
        case r'toolLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toolLabel = valueDes;
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.summary = valueDes;
          break;
        case r'details':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalDetailDto)]),
          ) as BuiltList<HelplyApprovalDetailDto>;
          result.details.replace(valueDes);
          break;
        case r'destructive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.destructive = valueDes;
          break;
        case r'arguments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HelplyApprovalDetailDto)]),
          ) as BuiltList<HelplyApprovalDetailDto>;
          result.arguments.replace(valueDes);
          break;
        case r'risk':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.risk = valueDes;
          break;
        case r'riskReasons':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.riskReasons.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyApprovalRequestDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyApprovalRequestDtoBuilder();
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

