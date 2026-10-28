// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_enrolment_completed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TwoFactorEnrolmentCompleted extends TwoFactorEnrolmentCompleted {
  @override
  final BuiltList<String> recoveryCodes;

  factory _$TwoFactorEnrolmentCompleted([
    void Function(TwoFactorEnrolmentCompletedBuilder)? updates,
  ]) => (TwoFactorEnrolmentCompletedBuilder()..update(updates))._build();

  _$TwoFactorEnrolmentCompleted._({required this.recoveryCodes}) : super._();
  @override
  TwoFactorEnrolmentCompleted rebuild(
    void Function(TwoFactorEnrolmentCompletedBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TwoFactorEnrolmentCompletedBuilder toBuilder() =>
      TwoFactorEnrolmentCompletedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TwoFactorEnrolmentCompleted &&
        recoveryCodes == other.recoveryCodes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recoveryCodes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'TwoFactorEnrolmentCompleted',
    )..add('recoveryCodes', recoveryCodes)).toString();
  }
}

class TwoFactorEnrolmentCompletedBuilder
    implements
        Builder<
          TwoFactorEnrolmentCompleted,
          TwoFactorEnrolmentCompletedBuilder
        > {
  _$TwoFactorEnrolmentCompleted? _$v;

  ListBuilder<String>? _recoveryCodes;
  ListBuilder<String> get recoveryCodes =>
      _$this._recoveryCodes ??= ListBuilder<String>();
  set recoveryCodes(ListBuilder<String>? recoveryCodes) =>
      _$this._recoveryCodes = recoveryCodes;

  TwoFactorEnrolmentCompletedBuilder() {
    TwoFactorEnrolmentCompleted._defaults(this);
  }

  TwoFactorEnrolmentCompletedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recoveryCodes = $v.recoveryCodes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TwoFactorEnrolmentCompleted other) {
    _$v = other as _$TwoFactorEnrolmentCompleted;
  }

  @override
  void update(void Function(TwoFactorEnrolmentCompletedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TwoFactorEnrolmentCompleted build() => _build();

  _$TwoFactorEnrolmentCompleted _build() {
    _$TwoFactorEnrolmentCompleted _$result;
    try {
      _$result =
          _$v ??
          _$TwoFactorEnrolmentCompleted._(recoveryCodes: recoveryCodes.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'recoveryCodes';
        recoveryCodes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TwoFactorEnrolmentCompleted',
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
