// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_device_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportDeviceDto extends ExportDeviceDto {
  @override
  final String token;
  @override
  final String platform;
  @override
  final String locale;
  @override
  final DateTime lastSeenAt;

  factory _$ExportDeviceDto([void Function(ExportDeviceDtoBuilder)? updates]) =>
      (ExportDeviceDtoBuilder()..update(updates))._build();

  _$ExportDeviceDto._({
    required this.token,
    required this.platform,
    required this.locale,
    required this.lastSeenAt,
  }) : super._();
  @override
  ExportDeviceDto rebuild(void Function(ExportDeviceDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportDeviceDtoBuilder toBuilder() => ExportDeviceDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportDeviceDto &&
        token == other.token &&
        platform == other.platform &&
        locale == other.locale &&
        lastSeenAt == other.lastSeenAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportDeviceDto')
          ..add('token', token)
          ..add('platform', platform)
          ..add('locale', locale)
          ..add('lastSeenAt', lastSeenAt))
        .toString();
  }
}

class ExportDeviceDtoBuilder
    implements Builder<ExportDeviceDto, ExportDeviceDtoBuilder> {
  _$ExportDeviceDto? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  ExportDeviceDtoBuilder() {
    ExportDeviceDto._defaults(this);
  }

  ExportDeviceDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _platform = $v.platform;
      _locale = $v.locale;
      _lastSeenAt = $v.lastSeenAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportDeviceDto other) {
    _$v = other as _$ExportDeviceDto;
  }

  @override
  void update(void Function(ExportDeviceDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportDeviceDto build() => _build();

  _$ExportDeviceDto _build() {
    final _$result =
        _$v ??
        _$ExportDeviceDto._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'ExportDeviceDto',
            'token',
          ),
          platform: BuiltValueNullFieldError.checkNotNull(
            platform,
            r'ExportDeviceDto',
            'platform',
          ),
          locale: BuiltValueNullFieldError.checkNotNull(
            locale,
            r'ExportDeviceDto',
            'locale',
          ),
          lastSeenAt: BuiltValueNullFieldError.checkNotNull(
            lastSeenAt,
            r'ExportDeviceDto',
            'lastSeenAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
