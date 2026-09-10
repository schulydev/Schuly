// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_token_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterDeviceTokenCommand extends RegisterDeviceTokenCommand {
  @override
  final String token;
  @override
  final String platform;
  @override
  final String locale;

  factory _$RegisterDeviceTokenCommand([
    void Function(RegisterDeviceTokenCommandBuilder)? updates,
  ]) => (RegisterDeviceTokenCommandBuilder()..update(updates))._build();

  _$RegisterDeviceTokenCommand._({
    required this.token,
    required this.platform,
    required this.locale,
  }) : super._();
  @override
  RegisterDeviceTokenCommand rebuild(
    void Function(RegisterDeviceTokenCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RegisterDeviceTokenCommandBuilder toBuilder() =>
      RegisterDeviceTokenCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterDeviceTokenCommand &&
        token == other.token &&
        platform == other.platform &&
        locale == other.locale;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, locale.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterDeviceTokenCommand')
          ..add('token', token)
          ..add('platform', platform)
          ..add('locale', locale))
        .toString();
  }
}

class RegisterDeviceTokenCommandBuilder
    implements
        Builder<RegisterDeviceTokenCommand, RegisterDeviceTokenCommandBuilder> {
  _$RegisterDeviceTokenCommand? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _locale;
  String? get locale => _$this._locale;
  set locale(String? locale) => _$this._locale = locale;

  RegisterDeviceTokenCommandBuilder() {
    RegisterDeviceTokenCommand._defaults(this);
  }

  RegisterDeviceTokenCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _platform = $v.platform;
      _locale = $v.locale;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterDeviceTokenCommand other) {
    _$v = other as _$RegisterDeviceTokenCommand;
  }

  @override
  void update(void Function(RegisterDeviceTokenCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterDeviceTokenCommand build() => _build();

  _$RegisterDeviceTokenCommand _build() {
    final _$result =
        _$v ??
        _$RegisterDeviceTokenCommand._(
          token: BuiltValueNullFieldError.checkNotNull(
            token,
            r'RegisterDeviceTokenCommand',
            'token',
          ),
          platform: BuiltValueNullFieldError.checkNotNull(
            platform,
            r'RegisterDeviceTokenCommand',
            'platform',
          ),
          locale: BuiltValueNullFieldError.checkNotNull(
            locale,
            r'RegisterDeviceTokenCommand',
            'locale',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
