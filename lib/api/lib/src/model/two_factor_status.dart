//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'two_factor_status.g.dart';

/// TwoFactorStatus
///
/// Properties:
/// * [enabled] 
/// * [enrolmentPending] 
/// * [recoveryCodesRemaining] 
@BuiltValue()
abstract class TwoFactorStatus implements Built<TwoFactorStatus, TwoFactorStatusBuilder> {
  @BuiltValueField(wireName: r'enabled')
  bool get enabled;

  @BuiltValueField(wireName: r'enrolmentPending')
  bool get enrolmentPending;

  @BuiltValueField(wireName: r'recoveryCodesRemaining')
  int get recoveryCodesRemaining;

  TwoFactorStatus._();

  factory TwoFactorStatus([void updates(TwoFactorStatusBuilder b)]) = _$TwoFactorStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TwoFactorStatusBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TwoFactorStatus> get serializer => _$TwoFactorStatusSerializer();
}

class _$TwoFactorStatusSerializer implements PrimitiveSerializer<TwoFactorStatus> {
  @override
  final Iterable<Type> types = const [TwoFactorStatus, _$TwoFactorStatus];

  @override
  final String wireName = r'TwoFactorStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TwoFactorStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'enabled';
    yield serializers.serialize(
      object.enabled,
      specifiedType: const FullType(bool),
    );
    yield r'enrolmentPending';
    yield serializers.serialize(
      object.enrolmentPending,
      specifiedType: const FullType(bool),
    );
    yield r'recoveryCodesRemaining';
    yield serializers.serialize(
      object.recoveryCodesRemaining,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TwoFactorStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TwoFactorStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'enrolmentPending':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enrolmentPending = valueDes;
          break;
        case r'recoveryCodesRemaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recoveryCodesRemaining = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TwoFactorStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TwoFactorStatusBuilder();
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

