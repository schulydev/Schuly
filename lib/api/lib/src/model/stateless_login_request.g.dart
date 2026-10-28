// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateless_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatelessLoginRequest extends StatelessLoginRequest {
  @override
  final String baseUrl;
  @override
  final String email;
  @override
  final String password;
  @override
  final String? totpSecret;

  factory _$StatelessLoginRequest([
    void Function(StatelessLoginRequestBuilder)? updates,
  ]) => (StatelessLoginRequestBuilder()..update(updates))._build();

  _$StatelessLoginRequest._({
    required this.baseUrl,
    required this.email,
    required this.password,
    this.totpSecret,
  }) : super._();
  @override
  StatelessLoginRequest rebuild(
    void Function(StatelessLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StatelessLoginRequestBuilder toBuilder() =>
      StatelessLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatelessLoginRequest &&
        baseUrl == other.baseUrl &&
        email == other.email &&
        password == other.password &&
        totpSecret == other.totpSecret;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, totpSecret.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatelessLoginRequest')
          ..add('baseUrl', baseUrl)
          ..add('email', email)
          ..add('password', password)
          ..add('totpSecret', totpSecret))
        .toString();
  }
}

class StatelessLoginRequestBuilder
    implements Builder<StatelessLoginRequest, StatelessLoginRequestBuilder> {
  _$StatelessLoginRequest? _$v;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _totpSecret;
  String? get totpSecret => _$this._totpSecret;
  set totpSecret(String? totpSecret) => _$this._totpSecret = totpSecret;

  StatelessLoginRequestBuilder() {
    StatelessLoginRequest._defaults(this);
  }

  StatelessLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _baseUrl = $v.baseUrl;
      _email = $v.email;
      _password = $v.password;
      _totpSecret = $v.totpSecret;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatelessLoginRequest other) {
    _$v = other as _$StatelessLoginRequest;
  }

  @override
  void update(void Function(StatelessLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatelessLoginRequest build() => _build();

  _$StatelessLoginRequest _build() {
    final _$result =
        _$v ??
        _$StatelessLoginRequest._(
          baseUrl: BuiltValueNullFieldError.checkNotNull(
            baseUrl,
            r'StatelessLoginRequest',
            'baseUrl',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'StatelessLoginRequest',
            'email',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'StatelessLoginRequest',
            'password',
          ),
          totpSecret: totpSecret,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
