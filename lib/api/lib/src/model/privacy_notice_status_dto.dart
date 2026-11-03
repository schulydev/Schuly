//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'privacy_notice_status_dto.g.dart';

/// PrivacyNoticeStatusDto
///
/// Properties:
/// * [policyVersion] 
/// * [policyUrl] 
/// * [acceptanceRequired] 
/// * [swissSchoolConfirmationRequired] 
/// * [acceptedVersion] 
/// * [acceptedAt] 
/// * [swissSchoolConfirmedAt] 
@BuiltValue()
abstract class PrivacyNoticeStatusDto implements Built<PrivacyNoticeStatusDto, PrivacyNoticeStatusDtoBuilder> {
  @BuiltValueField(wireName: r'policyVersion')
  String get policyVersion;

  @BuiltValueField(wireName: r'policyUrl')
  String get policyUrl;

  @BuiltValueField(wireName: r'acceptanceRequired')
  bool get acceptanceRequired;

  @BuiltValueField(wireName: r'swissSchoolConfirmationRequired')
  bool get swissSchoolConfirmationRequired;

  @BuiltValueField(wireName: r'acceptedVersion')
  String? get acceptedVersion;

  @BuiltValueField(wireName: r'acceptedAt')
  DateTime? get acceptedAt;

  @BuiltValueField(wireName: r'swissSchoolConfirmedAt')
  DateTime? get swissSchoolConfirmedAt;

  PrivacyNoticeStatusDto._();

  factory PrivacyNoticeStatusDto([void updates(PrivacyNoticeStatusDtoBuilder b)]) = _$PrivacyNoticeStatusDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrivacyNoticeStatusDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrivacyNoticeStatusDto> get serializer => _$PrivacyNoticeStatusDtoSerializer();
}

class _$PrivacyNoticeStatusDtoSerializer implements PrimitiveSerializer<PrivacyNoticeStatusDto> {
  @override
  final Iterable<Type> types = const [PrivacyNoticeStatusDto, _$PrivacyNoticeStatusDto];

  @override
  final String wireName = r'PrivacyNoticeStatusDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrivacyNoticeStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'policyVersion';
    yield serializers.serialize(
      object.policyVersion,
      specifiedType: const FullType(String),
    );
    yield r'policyUrl';
    yield serializers.serialize(
      object.policyUrl,
      specifiedType: const FullType(String),
    );
    yield r'acceptanceRequired';
    yield serializers.serialize(
      object.acceptanceRequired,
      specifiedType: const FullType(bool),
    );
    yield r'swissSchoolConfirmationRequired';
    yield serializers.serialize(
      object.swissSchoolConfirmationRequired,
      specifiedType: const FullType(bool),
    );
    yield r'acceptedVersion';
    yield object.acceptedVersion == null ? null : serializers.serialize(
      object.acceptedVersion,
      specifiedType: const FullType.nullable(String),
    );
    yield r'acceptedAt';
    yield object.acceptedAt == null ? null : serializers.serialize(
      object.acceptedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'swissSchoolConfirmedAt';
    yield object.swissSchoolConfirmedAt == null ? null : serializers.serialize(
      object.swissSchoolConfirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrivacyNoticeStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PrivacyNoticeStatusDtoBuilder result,
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
        case r'policyUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.policyUrl = valueDes;
          break;
        case r'acceptanceRequired':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.acceptanceRequired = valueDes;
          break;
        case r'swissSchoolConfirmationRequired':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.swissSchoolConfirmationRequired = valueDes;
          break;
        case r'acceptedVersion':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.acceptedVersion = valueDes;
          break;
        case r'acceptedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.acceptedAt = valueDes;
          break;
        case r'swissSchoolConfirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.swissSchoolConfirmedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrivacyNoticeStatusDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrivacyNoticeStatusDtoBuilder();
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

