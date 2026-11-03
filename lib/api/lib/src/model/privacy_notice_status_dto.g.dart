// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_notice_status_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrivacyNoticeStatusDto extends PrivacyNoticeStatusDto {
  @override
  final String policyVersion;
  @override
  final String policyUrl;
  @override
  final bool acceptanceRequired;
  @override
  final bool swissSchoolConfirmationRequired;
  @override
  final String? acceptedVersion;
  @override
  final DateTime? acceptedAt;
  @override
  final DateTime? swissSchoolConfirmedAt;

  factory _$PrivacyNoticeStatusDto([
    void Function(PrivacyNoticeStatusDtoBuilder)? updates,
  ]) => (PrivacyNoticeStatusDtoBuilder()..update(updates))._build();

  _$PrivacyNoticeStatusDto._({
    required this.policyVersion,
    required this.policyUrl,
    required this.acceptanceRequired,
    required this.swissSchoolConfirmationRequired,
    this.acceptedVersion,
    this.acceptedAt,
    this.swissSchoolConfirmedAt,
  }) : super._();
  @override
  PrivacyNoticeStatusDto rebuild(
    void Function(PrivacyNoticeStatusDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PrivacyNoticeStatusDtoBuilder toBuilder() =>
      PrivacyNoticeStatusDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivacyNoticeStatusDto &&
        policyVersion == other.policyVersion &&
        policyUrl == other.policyUrl &&
        acceptanceRequired == other.acceptanceRequired &&
        swissSchoolConfirmationRequired ==
            other.swissSchoolConfirmationRequired &&
        acceptedVersion == other.acceptedVersion &&
        acceptedAt == other.acceptedAt &&
        swissSchoolConfirmedAt == other.swissSchoolConfirmedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, policyVersion.hashCode);
    _$hash = $jc(_$hash, policyUrl.hashCode);
    _$hash = $jc(_$hash, acceptanceRequired.hashCode);
    _$hash = $jc(_$hash, swissSchoolConfirmationRequired.hashCode);
    _$hash = $jc(_$hash, acceptedVersion.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, swissSchoolConfirmedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivacyNoticeStatusDto')
          ..add('policyVersion', policyVersion)
          ..add('policyUrl', policyUrl)
          ..add('acceptanceRequired', acceptanceRequired)
          ..add(
            'swissSchoolConfirmationRequired',
            swissSchoolConfirmationRequired,
          )
          ..add('acceptedVersion', acceptedVersion)
          ..add('acceptedAt', acceptedAt)
          ..add('swissSchoolConfirmedAt', swissSchoolConfirmedAt))
        .toString();
  }
}

class PrivacyNoticeStatusDtoBuilder
    implements Builder<PrivacyNoticeStatusDto, PrivacyNoticeStatusDtoBuilder> {
  _$PrivacyNoticeStatusDto? _$v;

  String? _policyVersion;
  String? get policyVersion => _$this._policyVersion;
  set policyVersion(String? policyVersion) =>
      _$this._policyVersion = policyVersion;

  String? _policyUrl;
  String? get policyUrl => _$this._policyUrl;
  set policyUrl(String? policyUrl) => _$this._policyUrl = policyUrl;

  bool? _acceptanceRequired;
  bool? get acceptanceRequired => _$this._acceptanceRequired;
  set acceptanceRequired(bool? acceptanceRequired) =>
      _$this._acceptanceRequired = acceptanceRequired;

  bool? _swissSchoolConfirmationRequired;
  bool? get swissSchoolConfirmationRequired =>
      _$this._swissSchoolConfirmationRequired;
  set swissSchoolConfirmationRequired(bool? swissSchoolConfirmationRequired) =>
      _$this._swissSchoolConfirmationRequired = swissSchoolConfirmationRequired;

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

  PrivacyNoticeStatusDtoBuilder() {
    PrivacyNoticeStatusDto._defaults(this);
  }

  PrivacyNoticeStatusDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _policyVersion = $v.policyVersion;
      _policyUrl = $v.policyUrl;
      _acceptanceRequired = $v.acceptanceRequired;
      _swissSchoolConfirmationRequired = $v.swissSchoolConfirmationRequired;
      _acceptedVersion = $v.acceptedVersion;
      _acceptedAt = $v.acceptedAt;
      _swissSchoolConfirmedAt = $v.swissSchoolConfirmedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivacyNoticeStatusDto other) {
    _$v = other as _$PrivacyNoticeStatusDto;
  }

  @override
  void update(void Function(PrivacyNoticeStatusDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivacyNoticeStatusDto build() => _build();

  _$PrivacyNoticeStatusDto _build() {
    final _$result =
        _$v ??
        _$PrivacyNoticeStatusDto._(
          policyVersion: BuiltValueNullFieldError.checkNotNull(
            policyVersion,
            r'PrivacyNoticeStatusDto',
            'policyVersion',
          ),
          policyUrl: BuiltValueNullFieldError.checkNotNull(
            policyUrl,
            r'PrivacyNoticeStatusDto',
            'policyUrl',
          ),
          acceptanceRequired: BuiltValueNullFieldError.checkNotNull(
            acceptanceRequired,
            r'PrivacyNoticeStatusDto',
            'acceptanceRequired',
          ),
          swissSchoolConfirmationRequired:
              BuiltValueNullFieldError.checkNotNull(
                swissSchoolConfirmationRequired,
                r'PrivacyNoticeStatusDto',
                'swissSchoolConfirmationRequired',
              ),
          acceptedVersion: acceptedVersion,
          acceptedAt: acceptedAt,
          swissSchoolConfirmedAt: swissSchoolConfirmedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
