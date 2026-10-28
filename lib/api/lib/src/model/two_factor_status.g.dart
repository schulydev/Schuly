// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TwoFactorStatus extends TwoFactorStatus {
  @override
  final bool enabled;
  @override
  final bool enrolmentPending;
  @override
  final int recoveryCodesRemaining;

  factory _$TwoFactorStatus([void Function(TwoFactorStatusBuilder)? updates]) =>
      (TwoFactorStatusBuilder()..update(updates))._build();

  _$TwoFactorStatus._({
    required this.enabled,
    required this.enrolmentPending,
    required this.recoveryCodesRemaining,
  }) : super._();
  @override
  TwoFactorStatus rebuild(void Function(TwoFactorStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TwoFactorStatusBuilder toBuilder() => TwoFactorStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TwoFactorStatus &&
        enabled == other.enabled &&
        enrolmentPending == other.enrolmentPending &&
        recoveryCodesRemaining == other.recoveryCodesRemaining;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, enrolmentPending.hashCode);
    _$hash = $jc(_$hash, recoveryCodesRemaining.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TwoFactorStatus')
          ..add('enabled', enabled)
          ..add('enrolmentPending', enrolmentPending)
          ..add('recoveryCodesRemaining', recoveryCodesRemaining))
        .toString();
  }
}

class TwoFactorStatusBuilder
    implements Builder<TwoFactorStatus, TwoFactorStatusBuilder> {
  _$TwoFactorStatus? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  bool? _enrolmentPending;
  bool? get enrolmentPending => _$this._enrolmentPending;
  set enrolmentPending(bool? enrolmentPending) =>
      _$this._enrolmentPending = enrolmentPending;

  int? _recoveryCodesRemaining;
  int? get recoveryCodesRemaining => _$this._recoveryCodesRemaining;
  set recoveryCodesRemaining(int? recoveryCodesRemaining) =>
      _$this._recoveryCodesRemaining = recoveryCodesRemaining;

  TwoFactorStatusBuilder() {
    TwoFactorStatus._defaults(this);
  }

  TwoFactorStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _enrolmentPending = $v.enrolmentPending;
      _recoveryCodesRemaining = $v.recoveryCodesRemaining;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TwoFactorStatus other) {
    _$v = other as _$TwoFactorStatus;
  }

  @override
  void update(void Function(TwoFactorStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TwoFactorStatus build() => _build();

  _$TwoFactorStatus _build() {
    final _$result =
        _$v ??
        _$TwoFactorStatus._(
          enabled: BuiltValueNullFieldError.checkNotNull(
            enabled,
            r'TwoFactorStatus',
            'enabled',
          ),
          enrolmentPending: BuiltValueNullFieldError.checkNotNull(
            enrolmentPending,
            r'TwoFactorStatus',
            'enrolmentPending',
          ),
          recoveryCodesRemaining: BuiltValueNullFieldError.checkNotNull(
            recoveryCodesRemaining,
            r'TwoFactorStatus',
            'recoveryCodesRemaining',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
