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
  @override
  final String policyVersion;
  @override
  final String policyUrl;
  @override
  final bool swissSchoolConfirmationRequired;

  factory _$AppDto([void Function(AppDtoBuilder)? updates]) =>
      (AppDtoBuilder()..update(updates))._build();

  _$AppDto._({
    required this.version,
    required this.registrationEnabled,
    required this.policyVersion,
    required this.policyUrl,
    required this.swissSchoolConfirmationRequired,
  }) : super._();
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
        registrationEnabled == other.registrationEnabled &&
        policyVersion == other.policyVersion &&
        policyUrl == other.policyUrl &&
        swissSchoolConfirmationRequired ==
            other.swissSchoolConfirmationRequired;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, registrationEnabled.hashCode);
    _$hash = $jc(_$hash, policyVersion.hashCode);
    _$hash = $jc(_$hash, policyUrl.hashCode);
    _$hash = $jc(_$hash, swissSchoolConfirmationRequired.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AppDto')
          ..add('version', version)
          ..add('registrationEnabled', registrationEnabled)
          ..add('policyVersion', policyVersion)
          ..add('policyUrl', policyUrl)
          ..add(
            'swissSchoolConfirmationRequired',
            swissSchoolConfirmationRequired,
          ))
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

  String? _policyVersion;
  String? get policyVersion => _$this._policyVersion;
  set policyVersion(String? policyVersion) =>
      _$this._policyVersion = policyVersion;

  String? _policyUrl;
  String? get policyUrl => _$this._policyUrl;
  set policyUrl(String? policyUrl) => _$this._policyUrl = policyUrl;

  bool? _swissSchoolConfirmationRequired;
  bool? get swissSchoolConfirmationRequired =>
      _$this._swissSchoolConfirmationRequired;
  set swissSchoolConfirmationRequired(bool? swissSchoolConfirmationRequired) =>
      _$this._swissSchoolConfirmationRequired = swissSchoolConfirmationRequired;

  AppDtoBuilder() {
    AppDto._defaults(this);
  }

  AppDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _registrationEnabled = $v.registrationEnabled;
      _policyVersion = $v.policyVersion;
      _policyUrl = $v.policyUrl;
      _swissSchoolConfirmationRequired = $v.swissSchoolConfirmationRequired;
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
          policyVersion: BuiltValueNullFieldError.checkNotNull(
            policyVersion,
            r'AppDto',
            'policyVersion',
          ),
          policyUrl: BuiltValueNullFieldError.checkNotNull(
            policyUrl,
            r'AppDto',
            'policyUrl',
          ),
          swissSchoolConfirmationRequired:
              BuiltValueNullFieldError.checkNotNull(
                swissSchoolConfirmationRequired,
                r'AppDto',
                'swissSchoolConfirmationRequired',
              ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
