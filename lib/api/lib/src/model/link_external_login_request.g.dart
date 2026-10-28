// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_external_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkExternalLoginRequest extends LinkExternalLoginRequest {
  @override
  final String returnUrl;
  @override
  final String? state;
  @override
  final String? currentPassword;
  @override
  final String? code;

  factory _$LinkExternalLoginRequest([
    void Function(LinkExternalLoginRequestBuilder)? updates,
  ]) => (LinkExternalLoginRequestBuilder()..update(updates))._build();

  _$LinkExternalLoginRequest._({
    required this.returnUrl,
    this.state,
    this.currentPassword,
    this.code,
  }) : super._();
  @override
  LinkExternalLoginRequest rebuild(
    void Function(LinkExternalLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LinkExternalLoginRequestBuilder toBuilder() =>
      LinkExternalLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkExternalLoginRequest &&
        returnUrl == other.returnUrl &&
        state == other.state &&
        currentPassword == other.currentPassword &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, returnUrl.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkExternalLoginRequest')
          ..add('returnUrl', returnUrl)
          ..add('state', state)
          ..add('currentPassword', currentPassword)
          ..add('code', code))
        .toString();
  }
}

class LinkExternalLoginRequestBuilder
    implements
        Builder<LinkExternalLoginRequest, LinkExternalLoginRequestBuilder> {
  _$LinkExternalLoginRequest? _$v;

  String? _returnUrl;
  String? get returnUrl => _$this._returnUrl;
  set returnUrl(String? returnUrl) => _$this._returnUrl = returnUrl;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  LinkExternalLoginRequestBuilder() {
    LinkExternalLoginRequest._defaults(this);
  }

  LinkExternalLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _returnUrl = $v.returnUrl;
      _state = $v.state;
      _currentPassword = $v.currentPassword;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkExternalLoginRequest other) {
    _$v = other as _$LinkExternalLoginRequest;
  }

  @override
  void update(void Function(LinkExternalLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkExternalLoginRequest build() => _build();

  _$LinkExternalLoginRequest _build() {
    final _$result =
        _$v ??
        _$LinkExternalLoginRequest._(
          returnUrl: BuiltValueNullFieldError.checkNotNull(
            returnUrl,
            r'LinkExternalLoginRequest',
            'returnUrl',
          ),
          state: state,
          currentPassword: currentPassword,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
