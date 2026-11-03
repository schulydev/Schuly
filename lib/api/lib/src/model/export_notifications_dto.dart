//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/export_device_dto.dart';
import 'package:schuly_api/src/model/notification_preferences_dto.dart';
import 'package:schuly_api/src/model/export_queued_notification_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_notifications_dto.g.dart';

/// ExportNotificationsDto
///
/// Properties:
/// * [preferences] 
/// * [devices] 
/// * [queued] 
@BuiltValue()
abstract class ExportNotificationsDto implements Built<ExportNotificationsDto, ExportNotificationsDtoBuilder> {
  @BuiltValueField(wireName: r'preferences')
  NotificationPreferencesDto? get preferences;

  @BuiltValueField(wireName: r'devices')
  BuiltList<ExportDeviceDto> get devices;

  @BuiltValueField(wireName: r'queued')
  BuiltList<ExportQueuedNotificationDto> get queued;

  ExportNotificationsDto._();

  factory ExportNotificationsDto([void updates(ExportNotificationsDtoBuilder b)]) = _$ExportNotificationsDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportNotificationsDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportNotificationsDto> get serializer => _$ExportNotificationsDtoSerializer();
}

class _$ExportNotificationsDtoSerializer implements PrimitiveSerializer<ExportNotificationsDto> {
  @override
  final Iterable<Type> types = const [ExportNotificationsDto, _$ExportNotificationsDto];

  @override
  final String wireName = r'ExportNotificationsDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportNotificationsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preferences';
    yield object.preferences == null ? null : serializers.serialize(
      object.preferences,
      specifiedType: const FullType.nullable(NotificationPreferencesDto),
    );
    yield r'devices';
    yield serializers.serialize(
      object.devices,
      specifiedType: const FullType(BuiltList, [FullType(ExportDeviceDto)]),
    );
    yield r'queued';
    yield serializers.serialize(
      object.queued,
      specifiedType: const FullType(BuiltList, [FullType(ExportQueuedNotificationDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportNotificationsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportNotificationsDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preferences':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(NotificationPreferencesDto),
          ) as NotificationPreferencesDto?;
          if (valueDes == null) continue;
          result.preferences.replace(valueDes);
          break;
        case r'devices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportDeviceDto)]),
          ) as BuiltList<ExportDeviceDto>;
          result.devices.replace(valueDes);
          break;
        case r'queued':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportQueuedNotificationDto)]),
          ) as BuiltList<ExportQueuedNotificationDto>;
          result.queued.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportNotificationsDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportNotificationsDtoBuilder();
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

