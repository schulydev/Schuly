// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_sign_in_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportSignInDto extends ExportSignInDto {
  @override
  final String? userName;
  @override
  final String? email;
  @override
  final DateTime? emailConfirmedAt;
  @override
  final DateTime? lastSeenAt;
  @override
  final bool twoFactorEnabled;
  @override
  final BuiltList<ExportExternalLoginDto> externalLogins;
  @override
  final BuiltList<ExportPasskeyDto> passkeys;
  @override
  final BuiltList<ExportSessionDto> sessions;
  @override
  final BuiltList<ExportSessionDto> trustedDevices;

  factory _$ExportSignInDto([void Function(ExportSignInDtoBuilder)? updates]) =>
      (ExportSignInDtoBuilder()..update(updates))._build();

  _$ExportSignInDto._({
    this.userName,
    this.email,
    this.emailConfirmedAt,
    this.lastSeenAt,
    required this.twoFactorEnabled,
    required this.externalLogins,
    required this.passkeys,
    required this.sessions,
    required this.trustedDevices,
  }) : super._();
  @override
  ExportSignInDto rebuild(void Function(ExportSignInDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportSignInDtoBuilder toBuilder() => ExportSignInDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportSignInDto &&
        userName == other.userName &&
        email == other.email &&
        emailConfirmedAt == other.emailConfirmedAt &&
        lastSeenAt == other.lastSeenAt &&
        twoFactorEnabled == other.twoFactorEnabled &&
        externalLogins == other.externalLogins &&
        passkeys == other.passkeys &&
        sessions == other.sessions &&
        trustedDevices == other.trustedDevices;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, emailConfirmedAt.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, twoFactorEnabled.hashCode);
    _$hash = $jc(_$hash, externalLogins.hashCode);
    _$hash = $jc(_$hash, passkeys.hashCode);
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jc(_$hash, trustedDevices.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportSignInDto')
          ..add('userName', userName)
          ..add('email', email)
          ..add('emailConfirmedAt', emailConfirmedAt)
          ..add('lastSeenAt', lastSeenAt)
          ..add('twoFactorEnabled', twoFactorEnabled)
          ..add('externalLogins', externalLogins)
          ..add('passkeys', passkeys)
          ..add('sessions', sessions)
          ..add('trustedDevices', trustedDevices))
        .toString();
  }
}

class ExportSignInDtoBuilder
    implements Builder<ExportSignInDto, ExportSignInDtoBuilder> {
  _$ExportSignInDto? _$v;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DateTime? _emailConfirmedAt;
  DateTime? get emailConfirmedAt => _$this._emailConfirmedAt;
  set emailConfirmedAt(DateTime? emailConfirmedAt) =>
      _$this._emailConfirmedAt = emailConfirmedAt;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  bool? _twoFactorEnabled;
  bool? get twoFactorEnabled => _$this._twoFactorEnabled;
  set twoFactorEnabled(bool? twoFactorEnabled) =>
      _$this._twoFactorEnabled = twoFactorEnabled;

  ListBuilder<ExportExternalLoginDto>? _externalLogins;
  ListBuilder<ExportExternalLoginDto> get externalLogins =>
      _$this._externalLogins ??= ListBuilder<ExportExternalLoginDto>();
  set externalLogins(ListBuilder<ExportExternalLoginDto>? externalLogins) =>
      _$this._externalLogins = externalLogins;

  ListBuilder<ExportPasskeyDto>? _passkeys;
  ListBuilder<ExportPasskeyDto> get passkeys =>
      _$this._passkeys ??= ListBuilder<ExportPasskeyDto>();
  set passkeys(ListBuilder<ExportPasskeyDto>? passkeys) =>
      _$this._passkeys = passkeys;

  ListBuilder<ExportSessionDto>? _sessions;
  ListBuilder<ExportSessionDto> get sessions =>
      _$this._sessions ??= ListBuilder<ExportSessionDto>();
  set sessions(ListBuilder<ExportSessionDto>? sessions) =>
      _$this._sessions = sessions;

  ListBuilder<ExportSessionDto>? _trustedDevices;
  ListBuilder<ExportSessionDto> get trustedDevices =>
      _$this._trustedDevices ??= ListBuilder<ExportSessionDto>();
  set trustedDevices(ListBuilder<ExportSessionDto>? trustedDevices) =>
      _$this._trustedDevices = trustedDevices;

  ExportSignInDtoBuilder() {
    ExportSignInDto._defaults(this);
  }

  ExportSignInDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userName = $v.userName;
      _email = $v.email;
      _emailConfirmedAt = $v.emailConfirmedAt;
      _lastSeenAt = $v.lastSeenAt;
      _twoFactorEnabled = $v.twoFactorEnabled;
      _externalLogins = $v.externalLogins.toBuilder();
      _passkeys = $v.passkeys.toBuilder();
      _sessions = $v.sessions.toBuilder();
      _trustedDevices = $v.trustedDevices.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportSignInDto other) {
    _$v = other as _$ExportSignInDto;
  }

  @override
  void update(void Function(ExportSignInDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportSignInDto build() => _build();

  _$ExportSignInDto _build() {
    _$ExportSignInDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportSignInDto._(
            userName: userName,
            email: email,
            emailConfirmedAt: emailConfirmedAt,
            lastSeenAt: lastSeenAt,
            twoFactorEnabled: BuiltValueNullFieldError.checkNotNull(
              twoFactorEnabled,
              r'ExportSignInDto',
              'twoFactorEnabled',
            ),
            externalLogins: externalLogins.build(),
            passkeys: passkeys.build(),
            sessions: sessions.build(),
            trustedDevices: trustedDevices.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'externalLogins';
        externalLogins.build();
        _$failedField = 'passkeys';
        passkeys.build();
        _$failedField = 'sessions';
        sessions.build();
        _$failedField = 'trustedDevices';
        trustedDevices.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportSignInDto',
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
