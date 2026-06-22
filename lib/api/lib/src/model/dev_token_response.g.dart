// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_token_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DevTokenResponse extends DevTokenResponse {
  @override
  final String accessToken;
  @override
  final String tokenType;
  @override
  final int expiresIn;
  @override
  final String role;

  factory _$DevTokenResponse([
    void Function(DevTokenResponseBuilder)? updates,
  ]) => (DevTokenResponseBuilder()..update(updates))._build();

  _$DevTokenResponse._({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.role,
  }) : super._();
  @override
  DevTokenResponse rebuild(void Function(DevTokenResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DevTokenResponseBuilder toBuilder() =>
      DevTokenResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DevTokenResponse &&
        accessToken == other.accessToken &&
        tokenType == other.tokenType &&
        expiresIn == other.expiresIn &&
        role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DevTokenResponse')
          ..add('accessToken', accessToken)
          ..add('tokenType', tokenType)
          ..add('expiresIn', expiresIn)
          ..add('role', role))
        .toString();
  }
}

class DevTokenResponseBuilder
    implements Builder<DevTokenResponse, DevTokenResponseBuilder> {
  _$DevTokenResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  DevTokenResponseBuilder() {
    DevTokenResponse._defaults(this);
  }

  DevTokenResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _tokenType = $v.tokenType;
      _expiresIn = $v.expiresIn;
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DevTokenResponse other) {
    _$v = other as _$DevTokenResponse;
  }

  @override
  void update(void Function(DevTokenResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DevTokenResponse build() => _build();

  _$DevTokenResponse _build() {
    final _$result =
        _$v ??
        _$DevTokenResponse._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'DevTokenResponse',
            'accessToken',
          ),
          tokenType: BuiltValueNullFieldError.checkNotNull(
            tokenType,
            r'DevTokenResponse',
            'tokenType',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'DevTokenResponse',
            'expiresIn',
          ),
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'DevTokenResponse',
            'role',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
