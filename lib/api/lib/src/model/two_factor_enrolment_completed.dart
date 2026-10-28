//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'two_factor_enrolment_completed.g.dart';

/// TwoFactorEnrolmentCompleted
///
/// Properties:
/// * [recoveryCodes] 
@BuiltValue()
abstract class TwoFactorEnrolmentCompleted implements Built<TwoFactorEnrolmentCompleted, TwoFactorEnrolmentCompletedBuilder> {
  @BuiltValueField(wireName: r'recoveryCodes')
  BuiltList<String> get recoveryCodes;

  TwoFactorEnrolmentCompleted._();

  factory TwoFactorEnrolmentCompleted([void updates(TwoFactorEnrolmentCompletedBuilder b)]) = _$TwoFactorEnrolmentCompleted;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TwoFactorEnrolmentCompletedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TwoFactorEnrolmentCompleted> get serializer => _$TwoFactorEnrolmentCompletedSerializer();
}

class _$TwoFactorEnrolmentCompletedSerializer implements PrimitiveSerializer<TwoFactorEnrolmentCompleted> {
  @override
  final Iterable<Type> types = const [TwoFactorEnrolmentCompleted, _$TwoFactorEnrolmentCompleted];

  @override
  final String wireName = r'TwoFactorEnrolmentCompleted';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TwoFactorEnrolmentCompleted object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'recoveryCodes';
    yield serializers.serialize(
      object.recoveryCodes,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TwoFactorEnrolmentCompleted object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TwoFactorEnrolmentCompletedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'recoveryCodes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.recoveryCodes.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TwoFactorEnrolmentCompleted deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TwoFactorEnrolmentCompletedBuilder();
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

