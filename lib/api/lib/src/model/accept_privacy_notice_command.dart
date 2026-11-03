//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'accept_privacy_notice_command.g.dart';

/// AcceptPrivacyNoticeCommand
///
/// Properties:
/// * [policyVersion] 
/// * [swissSchoolConfirmed] 
@BuiltValue()
abstract class AcceptPrivacyNoticeCommand implements Built<AcceptPrivacyNoticeCommand, AcceptPrivacyNoticeCommandBuilder> {
  @BuiltValueField(wireName: r'policyVersion')
  String get policyVersion;

  @BuiltValueField(wireName: r'swissSchoolConfirmed')
  bool get swissSchoolConfirmed;

  AcceptPrivacyNoticeCommand._();

  factory AcceptPrivacyNoticeCommand([void updates(AcceptPrivacyNoticeCommandBuilder b)]) = _$AcceptPrivacyNoticeCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AcceptPrivacyNoticeCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AcceptPrivacyNoticeCommand> get serializer => _$AcceptPrivacyNoticeCommandSerializer();
}

class _$AcceptPrivacyNoticeCommandSerializer implements PrimitiveSerializer<AcceptPrivacyNoticeCommand> {
  @override
  final Iterable<Type> types = const [AcceptPrivacyNoticeCommand, _$AcceptPrivacyNoticeCommand];

  @override
  final String wireName = r'AcceptPrivacyNoticeCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AcceptPrivacyNoticeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'policyVersion';
    yield serializers.serialize(
      object.policyVersion,
      specifiedType: const FullType(String),
    );
    yield r'swissSchoolConfirmed';
    yield serializers.serialize(
      object.swissSchoolConfirmed,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AcceptPrivacyNoticeCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AcceptPrivacyNoticeCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'policyVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.policyVersion = valueDes;
          break;
        case r'swissSchoolConfirmed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.swissSchoolConfirmed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AcceptPrivacyNoticeCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AcceptPrivacyNoticeCommandBuilder();
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

