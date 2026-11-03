// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_privacy_notice_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportPrivacyNoticeDto extends ExportPrivacyNoticeDto {
  @override
  final String? acceptedVersion;
  @override
  final DateTime? acceptedAt;
  @override
  final DateTime? swissSchoolConfirmedAt;

  factory _$ExportPrivacyNoticeDto([
    void Function(ExportPrivacyNoticeDtoBuilder)? updates,
  ]) => (ExportPrivacyNoticeDtoBuilder()..update(updates))._build();

  _$ExportPrivacyNoticeDto._({
    this.acceptedVersion,
    this.acceptedAt,
    this.swissSchoolConfirmedAt,
  }) : super._();
  @override
  ExportPrivacyNoticeDto rebuild(
    void Function(ExportPrivacyNoticeDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportPrivacyNoticeDtoBuilder toBuilder() =>
      ExportPrivacyNoticeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportPrivacyNoticeDto &&
        acceptedVersion == other.acceptedVersion &&
        acceptedAt == other.acceptedAt &&
        swissSchoolConfirmedAt == other.swissSchoolConfirmedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, acceptedVersion.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, swissSchoolConfirmedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportPrivacyNoticeDto')
          ..add('acceptedVersion', acceptedVersion)
          ..add('acceptedAt', acceptedAt)
          ..add('swissSchoolConfirmedAt', swissSchoolConfirmedAt))
        .toString();
  }
}

class ExportPrivacyNoticeDtoBuilder
    implements Builder<ExportPrivacyNoticeDto, ExportPrivacyNoticeDtoBuilder> {
  _$ExportPrivacyNoticeDto? _$v;

  String? _acceptedVersion;
  String? get acceptedVersion => _$this._acceptedVersion;
  set acceptedVersion(String? acceptedVersion) =>
      _$this._acceptedVersion = acceptedVersion;

  DateTime? _acceptedAt;
  DateTime? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(DateTime? acceptedAt) => _$this._acceptedAt = acceptedAt;

  DateTime? _swissSchoolConfirmedAt;
  DateTime? get swissSchoolConfirmedAt => _$this._swissSchoolConfirmedAt;
  set swissSchoolConfirmedAt(DateTime? swissSchoolConfirmedAt) =>
      _$this._swissSchoolConfirmedAt = swissSchoolConfirmedAt;

  ExportPrivacyNoticeDtoBuilder() {
    ExportPrivacyNoticeDto._defaults(this);
  }

  ExportPrivacyNoticeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _acceptedVersion = $v.acceptedVersion;
      _acceptedAt = $v.acceptedAt;
      _swissSchoolConfirmedAt = $v.swissSchoolConfirmedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportPrivacyNoticeDto other) {
    _$v = other as _$ExportPrivacyNoticeDto;
  }

  @override
  void update(void Function(ExportPrivacyNoticeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportPrivacyNoticeDto build() => _build();

  _$ExportPrivacyNoticeDto _build() {
    final _$result =
        _$v ??
        _$ExportPrivacyNoticeDto._(
          acceptedVersion: acceptedVersion,
          acceptedAt: acceptedAt,
          swissSchoolConfirmedAt: swissSchoolConfirmedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
