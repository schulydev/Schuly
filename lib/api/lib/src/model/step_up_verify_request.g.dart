// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_up_verify_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StepUpVerifyRequest extends StepUpVerifyRequest {
  @override
  final String challenge;
  @override
  final String code;

  factory _$StepUpVerifyRequest([
    void Function(StepUpVerifyRequestBuilder)? updates,
  ]) => (StepUpVerifyRequestBuilder()..update(updates))._build();

  _$StepUpVerifyRequest._({required this.challenge, required this.code})
    : super._();
  @override
  StepUpVerifyRequest rebuild(
    void Function(StepUpVerifyRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StepUpVerifyRequestBuilder toBuilder() =>
      StepUpVerifyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StepUpVerifyRequest &&
        challenge == other.challenge &&
        code == other.code;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challenge.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StepUpVerifyRequest')
          ..add('challenge', challenge)
          ..add('code', code))
        .toString();
  }
}

class StepUpVerifyRequestBuilder
    implements Builder<StepUpVerifyRequest, StepUpVerifyRequestBuilder> {
  _$StepUpVerifyRequest? _$v;

  String? _challenge;
  String? get challenge => _$this._challenge;
  set challenge(String? challenge) => _$this._challenge = challenge;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  StepUpVerifyRequestBuilder() {
    StepUpVerifyRequest._defaults(this);
  }

  StepUpVerifyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challenge = $v.challenge;
      _code = $v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StepUpVerifyRequest other) {
    _$v = other as _$StepUpVerifyRequest;
  }

  @override
  void update(void Function(StepUpVerifyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StepUpVerifyRequest build() => _build();

  _$StepUpVerifyRequest _build() {
    final _$result =
        _$v ??
        _$StepUpVerifyRequest._(
          challenge: BuiltValueNullFieldError.checkNotNull(
            challenge,
            r'StepUpVerifyRequest',
            'challenge',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'StepUpVerifyRequest',
            'code',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
