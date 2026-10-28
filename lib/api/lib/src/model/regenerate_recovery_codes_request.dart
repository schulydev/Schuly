//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'regenerate_recovery_codes_request.g.dart';

/// RegenerateRecoveryCodesRequest
///
/// Properties:
/// * [proof] 
/// * [currentPassword] 
@BuiltValue()
abstract class RegenerateRecoveryCodesRequest implements Built<RegenerateRecoveryCodesRequest, RegenerateRecoveryCodesRequestBuilder> {
  @BuiltValueField(wireName: r'proof')
  String get proof;

  @BuiltValueField(wireName: r'currentPassword')
  String? get currentPassword;

  RegenerateRecoveryCodesRequest._();

  factory RegenerateRecoveryCodesRequest([void updates(RegenerateRecoveryCodesRequestBuilder b)]) = _$RegenerateRecoveryCodesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegenerateRecoveryCodesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegenerateRecoveryCodesRequest> get serializer => _$RegenerateRecoveryCodesRequestSerializer();
}

class _$RegenerateRecoveryCodesRequestSerializer implements PrimitiveSerializer<RegenerateRecoveryCodesRequest> {
  @override
  final Iterable<Type> types = const [RegenerateRecoveryCodesRequest, _$RegenerateRecoveryCodesRequest];

  @override
  final String wireName = r'RegenerateRecoveryCodesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegenerateRecoveryCodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'proof';
    yield serializers.serialize(
      object.proof,
      specifiedType: const FullType(String),
    );
    if (object.currentPassword != null) {
      yield r'currentPassword';
      yield serializers.serialize(
        object.currentPassword,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RegenerateRecoveryCodesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegenerateRecoveryCodesRequestBuilder result,
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
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegenerateRecoveryCodesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegenerateRecoveryCodesRequestBuilder();
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

