// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_challenge_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TwoFactorChallengeResponse extends TwoFactorChallengeResponse {
  @override
  final bool? twoFactorRequired;
  @override
  final String challenge;
  @override
  final int expiresIn;
  @override
  final BuiltList<String>? secondFactors;

  factory _$TwoFactorChallengeResponse([
    void Function(TwoFactorChallengeResponseBuilder)? updates,
  ]) => (TwoFactorChallengeResponseBuilder()..update(updates))._build();

  _$TwoFactorChallengeResponse._({
    this.twoFactorRequired,
    required this.challenge,
    required this.expiresIn,
    this.secondFactors,
  }) : super._();
  @override
  TwoFactorChallengeResponse rebuild(
    void Function(TwoFactorChallengeResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TwoFactorChallengeResponseBuilder toBuilder() =>
      TwoFactorChallengeResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TwoFactorChallengeResponse &&
        twoFactorRequired == other.twoFactorRequired &&
        challenge == other.challenge &&
        expiresIn == other.expiresIn &&
        secondFactors == other.secondFactors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, twoFactorRequired.hashCode);
    _$hash = $jc(_$hash, challenge.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, secondFactors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TwoFactorChallengeResponse')
          ..add('twoFactorRequired', twoFactorRequired)
          ..add('challenge', challenge)
          ..add('expiresIn', expiresIn)
          ..add('secondFactors', secondFactors))
        .toString();
  }
}

class TwoFactorChallengeResponseBuilder
    implements
        Builder<TwoFactorChallengeResponse, TwoFactorChallengeResponseBuilder> {
  _$TwoFactorChallengeResponse? _$v;

  bool? _twoFactorRequired;
  bool? get twoFactorRequired => _$this._twoFactorRequired;
  set twoFactorRequired(bool? twoFactorRequired) =>
      _$this._twoFactorRequired = twoFactorRequired;

  String? _challenge;
  String? get challenge => _$this._challenge;
  set challenge(String? challenge) => _$this._challenge = challenge;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  ListBuilder<String>? _secondFactors;
  ListBuilder<String> get secondFactors =>
      _$this._secondFactors ??= ListBuilder<String>();
  set secondFactors(ListBuilder<String>? secondFactors) =>
      _$this._secondFactors = secondFactors;

  TwoFactorChallengeResponseBuilder() {
    TwoFactorChallengeResponse._defaults(this);
  }

  TwoFactorChallengeResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _twoFactorRequired = $v.twoFactorRequired;
      _challenge = $v.challenge;
      _expiresIn = $v.expiresIn;
      _secondFactors = $v.secondFactors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TwoFactorChallengeResponse other) {
    _$v = other as _$TwoFactorChallengeResponse;
  }

  @override
  void update(void Function(TwoFactorChallengeResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TwoFactorChallengeResponse build() => _build();

  _$TwoFactorChallengeResponse _build() {
    _$TwoFactorChallengeResponse _$result;
    try {
      _$result =
          _$v ??
          _$TwoFactorChallengeResponse._(
            twoFactorRequired: twoFactorRequired,
            challenge: BuiltValueNullFieldError.checkNotNull(
              challenge,
              r'TwoFactorChallengeResponse',
              'challenge',
            ),
            expiresIn: BuiltValueNullFieldError.checkNotNull(
              expiresIn,
              r'TwoFactorChallengeResponse',
              'expiresIn',
            ),
            secondFactors: _secondFactors?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'secondFactors';
        _secondFactors?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TwoFactorChallengeResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
