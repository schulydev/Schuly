// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LogoutRequest extends LogoutRequest {
  @override
  final String refreshToken;

  factory _$LogoutRequest([void Function(LogoutRequestBuilder)? updates]) =>
      (LogoutRequestBuilder()..update(updates))._build();

  _$LogoutRequest._({required this.refreshToken}) : super._();
  @override
  LogoutRequest rebuild(void Function(LogoutRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LogoutRequestBuilder toBuilder() => LogoutRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LogoutRequest && refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'LogoutRequest',
    )..add('refreshToken', refreshToken)).toString();
  }
}

class LogoutRequestBuilder
    implements Builder<LogoutRequest, LogoutRequestBuilder> {
  _$LogoutRequest? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  LogoutRequestBuilder() {
    LogoutRequest._defaults(this);
  }

  LogoutRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LogoutRequest other) {
    _$v = other as _$LogoutRequest;
  }

  @override
  void update(void Function(LogoutRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LogoutRequest build() => _build();

  _$LogoutRequest _build() {
    final _$result =
        _$v ??
        _$LogoutRequest._(
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'LogoutRequest',
            'refreshToken',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
