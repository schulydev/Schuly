// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_up_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StepUpResponse extends StepUpResponse {
  @override
  final String accessToken;
  @override
  final int expiresIn;
  @override
  final String? tokenType;
  @override
  final bool? recoveryCodesRunningLow;

  factory _$StepUpResponse([void Function(StepUpResponseBuilder)? updates]) =>
      (StepUpResponseBuilder()..update(updates))._build();

  _$StepUpResponse._({
    required this.accessToken,
    required this.expiresIn,
    this.tokenType,
    this.recoveryCodesRunningLow,
  }) : super._();
  @override
  StepUpResponse rebuild(void Function(StepUpResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StepUpResponseBuilder toBuilder() => StepUpResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StepUpResponse &&
        accessToken == other.accessToken &&
        expiresIn == other.expiresIn &&
        tokenType == other.tokenType &&
        recoveryCodesRunningLow == other.recoveryCodesRunningLow;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, expiresIn.hashCode);
    _$hash = $jc(_$hash, tokenType.hashCode);
    _$hash = $jc(_$hash, recoveryCodesRunningLow.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StepUpResponse')
          ..add('accessToken', accessToken)
          ..add('expiresIn', expiresIn)
          ..add('tokenType', tokenType)
          ..add('recoveryCodesRunningLow', recoveryCodesRunningLow))
        .toString();
  }
}

class StepUpResponseBuilder
    implements Builder<StepUpResponse, StepUpResponseBuilder> {
  _$StepUpResponse? _$v;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  int? _expiresIn;
  int? get expiresIn => _$this._expiresIn;
  set expiresIn(int? expiresIn) => _$this._expiresIn = expiresIn;

  String? _tokenType;
  String? get tokenType => _$this._tokenType;
  set tokenType(String? tokenType) => _$this._tokenType = tokenType;

  bool? _recoveryCodesRunningLow;
  bool? get recoveryCodesRunningLow => _$this._recoveryCodesRunningLow;
  set recoveryCodesRunningLow(bool? recoveryCodesRunningLow) =>
      _$this._recoveryCodesRunningLow = recoveryCodesRunningLow;

  StepUpResponseBuilder() {
    StepUpResponse._defaults(this);
  }

  StepUpResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accessToken = $v.accessToken;
      _expiresIn = $v.expiresIn;
      _tokenType = $v.tokenType;
      _recoveryCodesRunningLow = $v.recoveryCodesRunningLow;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StepUpResponse other) {
    _$v = other as _$StepUpResponse;
  }

  @override
  void update(void Function(StepUpResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StepUpResponse build() => _build();

  _$StepUpResponse _build() {
    final _$result =
        _$v ??
        _$StepUpResponse._(
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'StepUpResponse',
            'accessToken',
          ),
          expiresIn: BuiltValueNullFieldError.checkNotNull(
            expiresIn,
            r'StepUpResponse',
            'expiresIn',
          ),
          tokenType: tokenType,
          recoveryCodesRunningLow: recoveryCodesRunningLow,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
