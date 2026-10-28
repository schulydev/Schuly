// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppDto extends AppDto {
  @override
  final String version;
  @override
  final bool registrationEnabled;

  factory _$AppDto([void Function(AppDtoBuilder)? updates]) =>
      (AppDtoBuilder()..update(updates))._build();

  _$AppDto._({required this.version, required this.registrationEnabled})
    : super._();
  @override
  AppDto rebuild(void Function(AppDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppDtoBuilder toBuilder() => AppDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppDto &&
        version == other.version &&
        registrationEnabled == other.registrationEnabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, registrationEnabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppDto')
          ..add('version', version)
          ..add('registrationEnabled', registrationEnabled))
        .toString();
  }
}

class AppDtoBuilder implements Builder<AppDto, AppDtoBuilder> {
  _$AppDto? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  bool? _registrationEnabled;
  bool? get registrationEnabled => _$this._registrationEnabled;
  set registrationEnabled(bool? registrationEnabled) =>
      _$this._registrationEnabled = registrationEnabled;

  AppDtoBuilder() {
    AppDto._defaults(this);
  }

  AppDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _registrationEnabled = $v.registrationEnabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppDto other) {
    _$v = other as _$AppDto;
  }

  @override
  void update(void Function(AppDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AppDto build() => _build();

  _$AppDto _build() {
    final _$result =
        _$v ??
        _$AppDto._(
          version: BuiltValueNullFieldError.checkNotNull(
            version,
            r'AppDto',
            'version',
          ),
          registrationEnabled: BuiltValueNullFieldError.checkNotNull(
            registrationEnabled,
            r'AppDto',
            'registrationEnabled',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
