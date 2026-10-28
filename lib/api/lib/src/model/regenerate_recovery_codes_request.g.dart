// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regenerate_recovery_codes_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegenerateRecoveryCodesRequest extends RegenerateRecoveryCodesRequest {
  @override
  final String proof;

  factory _$RegenerateRecoveryCodesRequest([
    void Function(RegenerateRecoveryCodesRequestBuilder)? updates,
  ]) => (RegenerateRecoveryCodesRequestBuilder()..update(updates))._build();

  _$RegenerateRecoveryCodesRequest._({required this.proof}) : super._();
  @override
  RegenerateRecoveryCodesRequest rebuild(
    void Function(RegenerateRecoveryCodesRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RegenerateRecoveryCodesRequestBuilder toBuilder() =>
      RegenerateRecoveryCodesRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegenerateRecoveryCodesRequest && proof == other.proof;
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
      r'RegenerateRecoveryCodesRequest',
    )..add('proof', proof)).toString();
  }
}

class RegenerateRecoveryCodesRequestBuilder
    implements
        Builder<
          RegenerateRecoveryCodesRequest,
          RegenerateRecoveryCodesRequestBuilder
        > {
  _$RegenerateRecoveryCodesRequest? _$v;

  String? _proof;
  String? get proof => _$this._proof;
  set proof(String? proof) => _$this._proof = proof;

  RegenerateRecoveryCodesRequestBuilder() {
    RegenerateRecoveryCodesRequest._defaults(this);
  }

  RegenerateRecoveryCodesRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _proof = $v.proof;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegenerateRecoveryCodesRequest other) {
    _$v = other as _$RegenerateRecoveryCodesRequest;
  }

  @override
  void update(void Function(RegenerateRecoveryCodesRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegenerateRecoveryCodesRequest build() => _build();

  _$RegenerateRecoveryCodesRequest _build() {
    final _$result =
        _$v ??
        _$RegenerateRecoveryCodesRequest._(
          proof: BuiltValueNullFieldError.checkNotNull(
            proof,
            r'RegenerateRecoveryCodesRequest',
            'proof',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
