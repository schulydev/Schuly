// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TokenResponse extends TokenResponse {
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int expiresIn;
  @override
  final String? tokenType;
  @override
  final bool? recoveryCodesRunningLow;
  @override
  final String? deviceToken;
  @override
  final int? deviceExpiresIn;

  factory _$TokenResponse([void Function(TokenResponseBuilder)? updates]) =>
      (TokenResponseBuilder()..update(updates))._build();

  _$TokenResponse._({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    this.tokenType,
    this.recoveryCodesRunningLow,
    this.deviceToken,
    this.deviceExpiresIn,
  }) : super._();
  @override
  TokenResponse rebuild(void Function(TokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenResponseBuilder toBuilder() => TokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenResponse &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        expiresIn == other.expiresIn &&
        tokenType == other.tokenType &&
        recoveryCodesRunningLow == other.recoveryCodesRunningLow &&
        deviceToken == other.deviceToken &&
        deviceExpiresIn == other.deviceExpiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, recoveryCodesRunningLow.hashCode);
    _$hash = $jc(_$hash, deviceToken.hashCode);
    _$hash = $jc(_$hash, deviceExpiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenResponse')
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('expiresIn', expiresIn)
          ..add('tokenType', tokenType)
          ..add('recoveryCodesRunningLow', recoveryCodesRunningLow)
          ..add('deviceToken', deviceToken)
          ..add('deviceExpiresIn', deviceExpiresIn))
        .toString();
  }
}

class TokenResponseBuilder
    implements Builder<TokenResponse, TokenResponseBuilder> {
  _$TokenResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  bool? _recoveryCodesRunningLow;
  bool? get recoveryCodesRunningLow => _$this._recoveryCodesRunningLow;
  set recoveryCodesRunningLow(bool? recoveryCodesRunningLow) =>
      _$this._recoveryCodesRunningLow = recoveryCodesRunningLow;

  String? _deviceToken;
  String? get deviceToken => _$this._deviceToken;
  set deviceToken(String? deviceToken) => _$this._deviceToken = deviceToken;

  int? _deviceExpiresIn;
  int? get deviceExpiresIn => _$this._deviceExpiresIn;
  set deviceExpiresIn(int? deviceExpiresIn) =>
      _$this._deviceExpiresIn = deviceExpiresIn;

  TokenResponseBuilder() {
    TokenResponse._defaults(this);
  }

  TokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _expiresIn = $v.expiresIn;
      _tokenType = $v.tokenType;
      _recoveryCodesRunningLow = $v.recoveryCodesRunningLow;
      _deviceToken = $v.deviceToken;
      _deviceExpiresIn = $v.deviceExpiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenResponse other) {
    _$v = other as _$TokenResponse;
  }

  @override
  void update(void Function(TokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenResponse build() => _build();

  _$TokenResponse _build() {
    final _$result =
        _$v ??
        _$TokenResponse._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'TokenResponse',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'TokenResponse',
            'refreshToken',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'TokenResponse',
            'expiresIn',
          ),
          tokenType: tokenType,
          recoveryCodesRunningLow: recoveryCodesRunningLow,
          deviceToken: deviceToken,
          deviceExpiresIn: deviceExpiresIn,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
