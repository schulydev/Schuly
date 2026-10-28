// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unlink_external_login_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnlinkExternalLoginRequest extends UnlinkExternalLoginRequest {
  @override
  final String? currentPassword;
  @override
  final String? code;

  factory _$UnlinkExternalLoginRequest([
    void Function(UnlinkExternalLoginRequestBuilder)? updates,
  ]) => (UnlinkExternalLoginRequestBuilder()..update(updates))._build();

  _$UnlinkExternalLoginRequest._({this.currentPassword, this.code}) : super._();
  @override
  UnlinkExternalLoginRequest rebuild(
    void Function(UnlinkExternalLoginRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UnlinkExternalLoginRequestBuilder toBuilder() =>
      UnlinkExternalLoginRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnlinkExternalLoginRequest &&
        currentPassword == other.currentPassword &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnlinkExternalLoginRequest')
          ..add('currentPassword', currentPassword)
          ..add('code', code))
        .toString();
  }
}

class UnlinkExternalLoginRequestBuilder
    implements
        Builder<UnlinkExternalLoginRequest, UnlinkExternalLoginRequestBuilder> {
  _$UnlinkExternalLoginRequest? _$v;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  UnlinkExternalLoginRequestBuilder() {
    UnlinkExternalLoginRequest._defaults(this);
  }

  UnlinkExternalLoginRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPassword = $v.currentPassword;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnlinkExternalLoginRequest other) {
    _$v = other as _$UnlinkExternalLoginRequest;
  }

  @override
  void update(void Function(UnlinkExternalLoginRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnlinkExternalLoginRequest build() => _build();

  _$UnlinkExternalLoginRequest _build() {
    final _$result =
        _$v ??
        _$UnlinkExternalLoginRequest._(
          currentPassword: currentPassword,
          code: code,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
