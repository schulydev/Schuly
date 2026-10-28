// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_up_challenge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StepUpChallengeResponse extends StepUpChallengeResponse {
  @override
  final String challenge;
  @override
  final int expiresIn;

  factory _$StepUpChallengeResponse([
    void Function(StepUpChallengeResponseBuilder)? updates,
  ]) => (StepUpChallengeResponseBuilder()..update(updates))._build();

  _$StepUpChallengeResponse._({
    required this.challenge,
    required this.expiresIn,
  }) : super._();
  @override
  StepUpChallengeResponse rebuild(
    void Function(StepUpChallengeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StepUpChallengeResponseBuilder toBuilder() =>
      StepUpChallengeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StepUpChallengeResponse &&
        challenge == other.challenge &&
        expiresIn == other.expiresIn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challenge.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StepUpChallengeResponse')
          ..add('challenge', challenge)
          ..add('expiresIn', expiresIn))
        .toString();
  }
}

class StepUpChallengeResponseBuilder
    implements
        Builder<StepUpChallengeResponse, StepUpChallengeResponseBuilder> {
  _$StepUpChallengeResponse? _$v;

  String? _challenge;
  String? get challenge => _$this._challenge;
  set challenge(String? challenge) => _$this._challenge = challenge;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  StepUpChallengeResponseBuilder() {
    StepUpChallengeResponse._defaults(this);
  }

  StepUpChallengeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challenge = $v.challenge;
      _expiresIn = $v.expiresIn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StepUpChallengeResponse other) {
    _$v = other as _$StepUpChallengeResponse;
  }

  @override
  void update(void Function(StepUpChallengeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StepUpChallengeResponse build() => _build();

  _$StepUpChallengeResponse _build() {
    final _$result =
        _$v ??
        _$StepUpChallengeResponse._(
          challenge: BuiltValueNullFieldError.checkNotNull(
            challenge,
            r'StepUpChallengeResponse',
            'challenge',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'StepUpChallengeResponse',
            'expiresIn',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
