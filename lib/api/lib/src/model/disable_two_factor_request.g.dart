// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disable_two_factor_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DisableTwoFactorRequest extends DisableTwoFactorRequest {
  @override
  final String proof;

  factory _$DisableTwoFactorRequest([
    void Function(DisableTwoFactorRequestBuilder)? updates,
  ]) => (DisableTwoFactorRequestBuilder()..update(updates))._build();

  _$DisableTwoFactorRequest._({required this.proof}) : super._();
  @override
  DisableTwoFactorRequest rebuild(
    void Function(DisableTwoFactorRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DisableTwoFactorRequestBuilder toBuilder() =>
      DisableTwoFactorRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DisableTwoFactorRequest && proof == other.proof;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, proof.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'DisableTwoFactorRequest',
    )..add('proof', proof)).toString();
  }
}

class DisableTwoFactorRequestBuilder
    implements
        Builder<DisableTwoFactorRequest, DisableTwoFactorRequestBuilder> {
  _$DisableTwoFactorRequest? _$v;

  String? _proof;
  String? get proof => _$this._proof;
  set proof(String? proof) => _$this._proof = proof;

  DisableTwoFactorRequestBuilder() {
    DisableTwoFactorRequest._defaults(this);
  }

  DisableTwoFactorRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _proof = $v.proof;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DisableTwoFactorRequest other) {
    _$v = other as _$DisableTwoFactorRequest;
  }

  @override
  void update(void Function(DisableTwoFactorRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DisableTwoFactorRequest build() => _build();

  _$DisableTwoFactorRequest _build() {
    final _$result =
        _$v ??
        _$DisableTwoFactorRequest._(
          proof: BuiltValueNullFieldError.checkNotNull(
            proof,
            r'DisableTwoFactorRequest',
            'proof',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
