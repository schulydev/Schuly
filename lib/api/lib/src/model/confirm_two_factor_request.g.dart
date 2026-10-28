// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_two_factor_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmTwoFactorRequest extends ConfirmTwoFactorRequest {
  @override
  final String code;

  factory _$ConfirmTwoFactorRequest([
    void Function(ConfirmTwoFactorRequestBuilder)? updates,
  ]) => (ConfirmTwoFactorRequestBuilder()..update(updates))._build();

  _$ConfirmTwoFactorRequest._({required this.code}) : super._();
  @override
  ConfirmTwoFactorRequest rebuild(
    void Function(ConfirmTwoFactorRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ConfirmTwoFactorRequestBuilder toBuilder() =>
      ConfirmTwoFactorRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmTwoFactorRequest && code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ConfirmTwoFactorRequest',
    )..add('code', code)).toString();
  }
}

class ConfirmTwoFactorRequestBuilder
    implements
        Builder<ConfirmTwoFactorRequest, ConfirmTwoFactorRequestBuilder> {
  _$ConfirmTwoFactorRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  ConfirmTwoFactorRequestBuilder() {
    ConfirmTwoFactorRequest._defaults(this);
  }

  ConfirmTwoFactorRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmTwoFactorRequest other) {
    _$v = other as _$ConfirmTwoFactorRequest;
  }

  @override
  void update(void Function(ConfirmTwoFactorRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConfirmTwoFactorRequest build() => _build();

  _$ConfirmTwoFactorRequest _build() {
    final _$result =
        _$v ??
        _$ConfirmTwoFactorRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'ConfirmTwoFactorRequest',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
