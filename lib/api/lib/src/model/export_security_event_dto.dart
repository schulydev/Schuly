//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_security_event_dto.g.dart';

/// ExportSecurityEventDto
///
/// Properties:
/// * [kind] 
/// * [detail] 
/// * [occurredAt] 
@BuiltValue()
abstract class ExportSecurityEventDto implements Built<ExportSecurityEventDto, ExportSecurityEventDtoBuilder> {
  @BuiltValueField(wireName: r'kind')
  String get kind;

  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'occurredAt')
  DateTime get occurredAt;

  ExportSecurityEventDto._();

  factory ExportSecurityEventDto([void updates(ExportSecurityEventDtoBuilder b)]) = _$ExportSecurityEventDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportSecurityEventDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportSecurityEventDto> get serializer => _$ExportSecurityEventDtoSerializer();
}

class _$ExportSecurityEventDtoSerializer implements PrimitiveSerializer<ExportSecurityEventDto> {
  @override
  final Iterable<Type> types = const [ExportSecurityEventDto, _$ExportSecurityEventDto];

  @override
  final String wireName = r'ExportSecurityEventDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportSecurityEventDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(String),
    );
    yield r'detail';
    yield object.detail == null ? null : serializers.serialize(
      object.detail,
      specifiedType: const FullType.nullable(String),
    );
    yield r'occurredAt';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportSecurityEventDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportSecurityEventDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.kind = valueDes;
          break;
        case r'detail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.detail = valueDes;
          break;
        case r'occurredAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportSecurityEventDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportSecurityEventDtoBuilder();
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

