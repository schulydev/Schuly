//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'two_factor_enrolment_started.g.dart';

/// TwoFactorEnrolmentStarted
///
/// Properties:
/// * [secret] 
/// * [uri] 
@BuiltValue()
abstract class TwoFactorEnrolmentStarted implements Built<TwoFactorEnrolmentStarted, TwoFactorEnrolmentStartedBuilder> {
  @BuiltValueField(wireName: r'secret')
  String get secret;

  @BuiltValueField(wireName: r'uri')
  String get uri;

  TwoFactorEnrolmentStarted._();

  factory TwoFactorEnrolmentStarted([void updates(TwoFactorEnrolmentStartedBuilder b)]) = _$TwoFactorEnrolmentStarted;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TwoFactorEnrolmentStartedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TwoFactorEnrolmentStarted> get serializer => _$TwoFactorEnrolmentStartedSerializer();
}

class _$TwoFactorEnrolmentStartedSerializer implements PrimitiveSerializer<TwoFactorEnrolmentStarted> {
  @override
  final Iterable<Type> types = const [TwoFactorEnrolmentStarted, _$TwoFactorEnrolmentStarted];

  @override
  final String wireName = r'TwoFactorEnrolmentStarted';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TwoFactorEnrolmentStarted object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'secret';
    yield serializers.serialize(
      object.secret,
      specifiedType: const FullType(String),
    );
    yield r'uri';
    yield serializers.serialize(
      object.uri,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TwoFactorEnrolmentStarted object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TwoFactorEnrolmentStartedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.secret = valueDes;
          break;
        case r'uri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.uri = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TwoFactorEnrolmentStarted deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TwoFactorEnrolmentStartedBuilder();
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

