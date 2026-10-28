//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'confirm_two_factor_request.g.dart';

/// ConfirmTwoFactorRequest
///
/// Properties:
/// * [code] 
@BuiltValue()
abstract class ConfirmTwoFactorRequest implements Built<ConfirmTwoFactorRequest, ConfirmTwoFactorRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  ConfirmTwoFactorRequest._();

  factory ConfirmTwoFactorRequest([void updates(ConfirmTwoFactorRequestBuilder b)]) = _$ConfirmTwoFactorRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConfirmTwoFactorRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConfirmTwoFactorRequest> get serializer => _$ConfirmTwoFactorRequestSerializer();
}

class _$ConfirmTwoFactorRequestSerializer implements PrimitiveSerializer<ConfirmTwoFactorRequest> {
  @override
  final Iterable<Type> types = const [ConfirmTwoFactorRequest, _$ConfirmTwoFactorRequest];

  @override
  final String wireName = r'ConfirmTwoFactorRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConfirmTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConfirmTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ConfirmTwoFactorRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConfirmTwoFactorRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConfirmTwoFactorRequestBuilder();
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

