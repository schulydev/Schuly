// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessRequest extends OdaorgStatelessRequest {
  @override
  final String baseUrl;
  @override
  final String username;
  @override
  final String password;

  factory _$OdaorgStatelessRequest([
    void Function(OdaorgStatelessRequestBuilder)? updates,
  ]) => (OdaorgStatelessRequestBuilder()..update(updates))._build();

  _$OdaorgStatelessRequest._({
    required this.baseUrl,
    required this.username,
    required this.password,
  }) : super._();
  @override
  OdaorgStatelessRequest rebuild(
    void Function(OdaorgStatelessRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessRequestBuilder toBuilder() =>
      OdaorgStatelessRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessRequest &&
        baseUrl == other.baseUrl &&
        username == other.username &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessRequest')
          ..add('baseUrl', baseUrl)
          ..add('username', username)
          ..add('password', password))
        .toString();
  }
}

class OdaorgStatelessRequestBuilder
    implements Builder<OdaorgStatelessRequest, OdaorgStatelessRequestBuilder> {
  _$OdaorgStatelessRequest? _$v;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  OdaorgStatelessRequestBuilder() {
    OdaorgStatelessRequest._defaults(this);
  }

  OdaorgStatelessRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _baseUrl = $v.baseUrl;
      _username = $v.username;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessRequest other) {
    _$v = other as _$OdaorgStatelessRequest;
  }

  @override
  void update(void Function(OdaorgStatelessRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessRequest build() => _build();

  _$OdaorgStatelessRequest _build() {
    final _$result =
        _$v ??
        _$OdaorgStatelessRequest._(
          baseUrl: BuiltValueNullFieldError.checkNotNull(
            baseUrl,
            r'OdaorgStatelessRequest',
            'baseUrl',
          ),
          username: BuiltValueNullFieldError.checkNotNull(
            username,
            r'OdaorgStatelessRequest',
            'username',
          ),
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'OdaorgStatelessRequest',
            'password',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
