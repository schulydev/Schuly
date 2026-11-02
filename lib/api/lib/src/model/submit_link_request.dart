//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submit_link_request.g.dart';

/// SubmitLinkRequest
///
/// Properties:
/// * [stepId] 
/// * [values] 
/// * [action] 
@BuiltValue()
abstract class SubmitLinkRequest implements Built<SubmitLinkRequest, SubmitLinkRequestBuilder> {
  @BuiltValueField(wireName: r'stepId')
  String get stepId;

  @BuiltValueField(wireName: r'values')
  BuiltMap<String, String>? get values;

  @BuiltValueField(wireName: r'action')
  String? get action;

  SubmitLinkRequest._();

  factory SubmitLinkRequest([void updates(SubmitLinkRequestBuilder b)]) = _$SubmitLinkRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmitLinkRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmitLinkRequest> get serializer => _$SubmitLinkRequestSerializer();
}

class _$SubmitLinkRequestSerializer implements PrimitiveSerializer<SubmitLinkRequest> {
  @override
  final Iterable<Type> types = const [SubmitLinkRequest, _$SubmitLinkRequest];

  @override
  final String wireName = r'SubmitLinkRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmitLinkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'stepId';
    yield serializers.serialize(
      object.stepId,
      specifiedType: const FullType(String),
    );
    if (object.values != null) {
      yield r'values';
      yield serializers.serialize(
        object.values,
        specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
      );
    }
    if (object.action != null) {
      yield r'action';
      yield serializers.serialize(
        object.action,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmitLinkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmitLinkRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'stepId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stepId = valueDes;
          break;
        case r'values':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltMap, [FullType(String), FullType(String)]),
          ) as BuiltMap<String, String>?;
          if (valueDes == null) continue;
          result.values.replace(valueDes);
          break;
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.action = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmitLinkRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmitLinkRequestBuilder();
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

