// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_privacy_notice_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcceptPrivacyNoticeCommand extends AcceptPrivacyNoticeCommand {
  @override
  final String policyVersion;
  @override
  final bool swissSchoolConfirmed;

  factory _$AcceptPrivacyNoticeCommand([
    void Function(AcceptPrivacyNoticeCommandBuilder)? updates,
  ]) => (AcceptPrivacyNoticeCommandBuilder()..update(updates))._build();

  _$AcceptPrivacyNoticeCommand._({
    required this.policyVersion,
    required this.swissSchoolConfirmed,
  }) : super._();
  @override
  AcceptPrivacyNoticeCommand rebuild(
    void Function(AcceptPrivacyNoticeCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AcceptPrivacyNoticeCommandBuilder toBuilder() =>
      AcceptPrivacyNoticeCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcceptPrivacyNoticeCommand &&
        policyVersion == other.policyVersion &&
        swissSchoolConfirmed == other.swissSchoolConfirmed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, policyVersion.hashCode);
    _$hash = $jc(_$hash, swissSchoolConfirmed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AcceptPrivacyNoticeCommand')
          ..add('policyVersion', policyVersion)
          ..add('swissSchoolConfirmed', swissSchoolConfirmed))
        .toString();
  }
}

class AcceptPrivacyNoticeCommandBuilder
    implements
        Builder<AcceptPrivacyNoticeCommand, AcceptPrivacyNoticeCommandBuilder> {
  _$AcceptPrivacyNoticeCommand? _$v;

  String? _policyVersion;
  String? get policyVersion => _$this._policyVersion;
  set policyVersion(String? policyVersion) =>
      _$this._policyVersion = policyVersion;

  bool? _swissSchoolConfirmed;
  bool? get swissSchoolConfirmed => _$this._swissSchoolConfirmed;
  set swissSchoolConfirmed(bool? swissSchoolConfirmed) =>
      _$this._swissSchoolConfirmed = swissSchoolConfirmed;

  AcceptPrivacyNoticeCommandBuilder() {
    AcceptPrivacyNoticeCommand._defaults(this);
  }

  AcceptPrivacyNoticeCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _policyVersion = $v.policyVersion;
      _swissSchoolConfirmed = $v.swissSchoolConfirmed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcceptPrivacyNoticeCommand other) {
    _$v = other as _$AcceptPrivacyNoticeCommand;
  }

  @override
  void update(void Function(AcceptPrivacyNoticeCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcceptPrivacyNoticeCommand build() => _build();

  _$AcceptPrivacyNoticeCommand _build() {
    final _$result =
        _$v ??
        _$AcceptPrivacyNoticeCommand._(
          policyVersion: BuiltValueNullFieldError.checkNotNull(
            policyVersion,
            r'AcceptPrivacyNoticeCommand',
            'policyVersion',
          ),
          swissSchoolConfirmed: BuiltValueNullFieldError.checkNotNull(
            swissSchoolConfirmed,
            r'AcceptPrivacyNoticeCommand',
            'swissSchoolConfirmed',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
