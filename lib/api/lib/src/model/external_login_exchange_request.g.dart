// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_login_exchange_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExternalLoginExchangeRequest extends ExternalLoginExchangeRequest {
  @override
  final String code;
  @override
  final String codeVerifier;

  factory _$ExternalLoginExchangeRequest([
    void Function(ExternalLoginExchangeRequestBuilder)? updates,
  ]) => (ExternalLoginExchangeRequestBuilder()..update(updates))._build();

  _$ExternalLoginExchangeRequest._({
    required this.code,
    required this.codeVerifier,
  }) : super._();
  @override
  ExternalLoginExchangeRequest rebuild(
    void Function(ExternalLoginExchangeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExternalLoginExchangeRequestBuilder toBuilder() =>
      ExternalLoginExchangeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExternalLoginExchangeRequest &&
        code == other.code &&
        codeVerifier == other.codeVerifier;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, codeVerifier.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExternalLoginExchangeRequest')
          ..add('code', code)
          ..add('codeVerifier', codeVerifier))
        .toString();
  }
}

class ExternalLoginExchangeRequestBuilder
    implements
        Builder<
          ExternalLoginExchangeRequest,
          ExternalLoginExchangeRequestBuilder
        > {
  _$ExternalLoginExchangeRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _codeVerifier;
  String? get codeVerifier => _$this._codeVerifier;
  set codeVerifier(String? codeVerifier) => _$this._codeVerifier = codeVerifier;

  ExternalLoginExchangeRequestBuilder() {
    ExternalLoginExchangeRequest._defaults(this);
  }

  ExternalLoginExchangeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _codeVerifier = $v.codeVerifier;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExternalLoginExchangeRequest other) {
    _$v = other as _$ExternalLoginExchangeRequest;
  }

  @override
  void update(void Function(ExternalLoginExchangeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExternalLoginExchangeRequest build() => _build();

  _$ExternalLoginExchangeRequest _build() {
    final _$result =
        _$v ??
        _$ExternalLoginExchangeRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'ExternalLoginExchangeRequest',
            'code',
          ),
          codeVerifier: BuiltValueNullFieldError.checkNotNull(
            codeVerifier,
            r'ExternalLoginExchangeRequest',
            'codeVerifier',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
