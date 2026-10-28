// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'begin_two_factor_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BeginTwoFactorRequest extends BeginTwoFactorRequest {
  @override
  final String? currentPassword;

  factory _$BeginTwoFactorRequest([
    void Function(BeginTwoFactorRequestBuilder)? updates,
  ]) => (BeginTwoFactorRequestBuilder()..update(updates))._build();

  _$BeginTwoFactorRequest._({this.currentPassword}) : super._();
  @override
  BeginTwoFactorRequest rebuild(
    void Function(BeginTwoFactorRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  BeginTwoFactorRequestBuilder toBuilder() =>
      BeginTwoFactorRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BeginTwoFactorRequest &&
        currentPassword == other.currentPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'BeginTwoFactorRequest',
    )..add('currentPassword', currentPassword)).toString();
  }
}

class BeginTwoFactorRequestBuilder
    implements Builder<BeginTwoFactorRequest, BeginTwoFactorRequestBuilder> {
  _$BeginTwoFactorRequest? _$v;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  BeginTwoFactorRequestBuilder() {
    BeginTwoFactorRequest._defaults(this);
  }

  BeginTwoFactorRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPassword = $v.currentPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BeginTwoFactorRequest other) {
    _$v = other as _$BeginTwoFactorRequest;
  }

  @override
  void update(void Function(BeginTwoFactorRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BeginTwoFactorRequest build() => _build();

  _$BeginTwoFactorRequest _build() {
    final _$result =
        _$v ?? _$BeginTwoFactorRequest._(currentPassword: currentPassword);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
