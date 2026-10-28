//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'disable_two_factor_request.g.dart';

/// DisableTwoFactorRequest
///
/// Properties:
/// * [proof] 
@BuiltValue()
abstract class DisableTwoFactorRequest implements Built<DisableTwoFactorRequest, DisableTwoFactorRequestBuilder> {
  @BuiltValueField(wireName: r'proof')
  String get proof;

  DisableTwoFactorRequest._();

  factory DisableTwoFactorRequest([void updates(DisableTwoFactorRequestBuilder b)]) = _$DisableTwoFactorRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DisableTwoFactorRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DisableTwoFactorRequest> get serializer => _$DisableTwoFactorRequestSerializer();
}

class _$DisableTwoFactorRequestSerializer implements PrimitiveSerializer<DisableTwoFactorRequest> {
  @override
  final Iterable<Type> types = const [DisableTwoFactorRequest, _$DisableTwoFactorRequest];

  @override
  final String wireName = r'DisableTwoFactorRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DisableTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'proof';
    yield serializers.serialize(
      object.proof,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DisableTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DisableTwoFactorRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'proof':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.proof = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DisableTwoFactorRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DisableTwoFactorRequestBuilder();
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

