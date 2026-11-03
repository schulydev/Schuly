// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_notifications_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportNotificationsDto extends ExportNotificationsDto {
  @override
  final NotificationPreferencesDto? preferences;
  @override
  final BuiltList<ExportDeviceDto> devices;
  @override
  final BuiltList<ExportQueuedNotificationDto> queued;

  factory _$ExportNotificationsDto([
    void Function(ExportNotificationsDtoBuilder)? updates,
  ]) => (ExportNotificationsDtoBuilder()..update(updates))._build();

  _$ExportNotificationsDto._({
    this.preferences,
    required this.devices,
    required this.queued,
  }) : super._();
  @override
  ExportNotificationsDto rebuild(
    void Function(ExportNotificationsDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportNotificationsDtoBuilder toBuilder() =>
      ExportNotificationsDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportNotificationsDto &&
        preferences == other.preferences &&
        devices == other.devices &&
        queued == other.queued;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, preferences.hashCode);
    _$hash = $jc(_$hash, devices.hashCode);
    _$hash = $jc(_$hash, queued.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportNotificationsDto')
          ..add('preferences', preferences)
          ..add('devices', devices)
          ..add('queued', queued))
        .toString();
  }
}

class ExportNotificationsDtoBuilder
    implements Builder<ExportNotificationsDto, ExportNotificationsDtoBuilder> {
  _$ExportNotificationsDto? _$v;

  NotificationPreferencesDtoBuilder? _preferences;
  NotificationPreferencesDtoBuilder get preferences =>
      _$this._preferences ??= NotificationPreferencesDtoBuilder();
  set preferences(NotificationPreferencesDtoBuilder? preferences) =>
      _$this._preferences = preferences;

  ListBuilder<ExportDeviceDto>? _devices;
  ListBuilder<ExportDeviceDto> get devices =>
      _$this._devices ??= ListBuilder<ExportDeviceDto>();
  set devices(ListBuilder<ExportDeviceDto>? devices) =>
      _$this._devices = devices;

  ListBuilder<ExportQueuedNotificationDto>? _queued;
  ListBuilder<ExportQueuedNotificationDto> get queued =>
      _$this._queued ??= ListBuilder<ExportQueuedNotificationDto>();
  set queued(ListBuilder<ExportQueuedNotificationDto>? queued) =>
      _$this._queued = queued;

  ExportNotificationsDtoBuilder() {
    ExportNotificationsDto._defaults(this);
  }

  ExportNotificationsDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _preferences = $v.preferences?.toBuilder();
      _devices = $v.devices.toBuilder();
      _queued = $v.queued.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportNotificationsDto other) {
    _$v = other as _$ExportNotificationsDto;
  }

  @override
  void update(void Function(ExportNotificationsDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportNotificationsDto build() => _build();

  _$ExportNotificationsDto _build() {
    _$ExportNotificationsDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportNotificationsDto._(
            preferences: _preferences?.build(),
            devices: devices.build(),
            queued: queued.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'preferences';
        _preferences?.build();
        _$failedField = 'devices';
        devices.build();
        _$failedField = 'queued';
        queued.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportNotificationsDto',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
