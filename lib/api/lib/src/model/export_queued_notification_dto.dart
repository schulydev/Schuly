//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_queued_notification_dto.g.dart';

/// ExportQueuedNotificationDto
///
/// Properties:
/// * [type] 
/// * [subjectName] 
/// * [summary] 
/// * [createdAt] 
@BuiltValue()
abstract class ExportQueuedNotificationDto implements Built<ExportQueuedNotificationDto, ExportQueuedNotificationDtoBuilder> {
  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'subjectName')
  String? get subjectName;

  @BuiltValueField(wireName: r'summary')
  String? get summary;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  ExportQueuedNotificationDto._();

  factory ExportQueuedNotificationDto([void updates(ExportQueuedNotificationDtoBuilder b)]) = _$ExportQueuedNotificationDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportQueuedNotificationDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportQueuedNotificationDto> get serializer => _$ExportQueuedNotificationDtoSerializer();
}

class _$ExportQueuedNotificationDtoSerializer implements PrimitiveSerializer<ExportQueuedNotificationDto> {
  @override
  final Iterable<Type> types = const [ExportQueuedNotificationDto, _$ExportQueuedNotificationDto];

  @override
  final String wireName = r'ExportQueuedNotificationDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportQueuedNotificationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'subjectName';
    yield object.subjectName == null ? null : serializers.serialize(
      object.subjectName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'summary';
    yield object.summary == null ? null : serializers.serialize(
      object.summary,
      specifiedType: const FullType.nullable(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportQueuedNotificationDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportQueuedNotificationDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'subjectName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.subjectName = valueDes;
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.summary = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportQueuedNotificationDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportQueuedNotificationDtoBuilder();
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

