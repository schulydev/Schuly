// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_two_factor_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyTwoFactorRequest extends VerifyTwoFactorRequest {
  @override
  final String challenge;
  @override
  final String code;
  @override
  final bool? rememberDevice;
  @override
  final String? deviceLabel;

  factory _$VerifyTwoFactorRequest([
    void Function(VerifyTwoFactorRequestBuilder)? updates,
  ]) => (VerifyTwoFactorRequestBuilder()..update(updates))._build();

  _$VerifyTwoFactorRequest._({
    required this.challenge,
    required this.code,
    this.rememberDevice,
    this.deviceLabel,
  }) : super._();
  @override
  VerifyTwoFactorRequest rebuild(
    void Function(VerifyTwoFactorRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  VerifyTwoFactorRequestBuilder toBuilder() =>
      VerifyTwoFactorRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyTwoFactorRequest &&
        challenge == other.challenge &&
        code == other.code &&
        rememberDevice == other.rememberDevice &&
        deviceLabel == other.deviceLabel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, challenge.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, rememberDevice.hashCode);
    _$hash = $jc(_$hash, deviceLabel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyTwoFactorRequest')
          ..add('challenge', challenge)
          ..add('code', code)
          ..add('rememberDevice', rememberDevice)
          ..add('deviceLabel', deviceLabel))
        .toString();
  }
}

class VerifyTwoFactorRequestBuilder
    implements Builder<VerifyTwoFactorRequest, VerifyTwoFactorRequestBuilder> {
  _$VerifyTwoFactorRequest? _$v;

  String? _challenge;
  String? get challenge => _$this._challenge;
  set challenge(String? challenge) => _$this._challenge = challenge;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  bool? _rememberDevice;
  bool? get rememberDevice => _$this._rememberDevice;
  set rememberDevice(bool? rememberDevice) =>
      _$this._rememberDevice = rememberDevice;

  String? _deviceLabel;
  String? get deviceLabel => _$this._deviceLabel;
  set deviceLabel(String? deviceLabel) => _$this._deviceLabel = deviceLabel;

  VerifyTwoFactorRequestBuilder() {
    VerifyTwoFactorRequest._defaults(this);
  }

  VerifyTwoFactorRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _challenge = $v.challenge;
      _code = $v.code;
      _rememberDevice = $v.rememberDevice;
      _deviceLabel = $v.deviceLabel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyTwoFactorRequest other) {
    _$v = other as _$VerifyTwoFactorRequest;
  }

  @override
  void update(void Function(VerifyTwoFactorRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyTwoFactorRequest build() => _build();

  _$VerifyTwoFactorRequest _build() {
    final _$result =
        _$v ??
        _$VerifyTwoFactorRequest._(
          challenge: BuiltValueNullFieldError.checkNotNull(
            challenge,
            r'VerifyTwoFactorRequest',
            'challenge',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'VerifyTwoFactorRequest',
            'code',
          ),
          rememberDevice: rememberDevice,
          deviceLabel: deviceLabel,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
