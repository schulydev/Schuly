//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_privacy_notice_dto.g.dart';

/// ExportPrivacyNoticeDto
///
/// Properties:
/// * [acceptedVersion] 
/// * [acceptedAt] 
/// * [swissSchoolConfirmedAt] 
@BuiltValue()
abstract class ExportPrivacyNoticeDto implements Built<ExportPrivacyNoticeDto, ExportPrivacyNoticeDtoBuilder> {
  @BuiltValueField(wireName: r'acceptedVersion')
  String? get acceptedVersion;

  @BuiltValueField(wireName: r'acceptedAt')
  DateTime? get acceptedAt;

  @BuiltValueField(wireName: r'swissSchoolConfirmedAt')
  DateTime? get swissSchoolConfirmedAt;

  ExportPrivacyNoticeDto._();

  factory ExportPrivacyNoticeDto([void updates(ExportPrivacyNoticeDtoBuilder b)]) = _$ExportPrivacyNoticeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportPrivacyNoticeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportPrivacyNoticeDto> get serializer => _$ExportPrivacyNoticeDtoSerializer();
}

class _$ExportPrivacyNoticeDtoSerializer implements PrimitiveSerializer<ExportPrivacyNoticeDto> {
  @override
  final Iterable<Type> types = const [ExportPrivacyNoticeDto, _$ExportPrivacyNoticeDto];

  @override
  final String wireName = r'ExportPrivacyNoticeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportPrivacyNoticeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    ExportPrivacyNoticeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportPrivacyNoticeDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ExportPrivacyNoticeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportPrivacyNoticeDtoBuilder();
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

