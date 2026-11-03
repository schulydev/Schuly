// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_export_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountExportDto extends AccountExportDto {
  @override
  final DateTime? exportedAt;
  @override
  final ApplicationUserDto profile;
  @override
  final BuiltList<SchoolUserDto>? schoolUsers;
  @override
  final BuiltList<AgendaEntryDto>? agendaEntries;
  @override
  final BuiltList<SemesterReportDto>? semesterReports;
  @override
  final BuiltList<StudentDocumentDto>? documents;
  @override
  final BuiltList<LinkedAccountDto>? linkedAccounts;
  @override
  final ExportPrivacyNoticeDto? privacyNotice;
  @override
  final ExportSignInDto? signIn;
  @override
  final BuiltList<ExportConnectedAccountDto>? connectedAccounts;
  @override
  final ExportHelplyDto? helply;
  @override
  final ExportAiAppsDto? aiApps;
  @override
  final ExportNotificationsDto? notifications;
  @override
  final BuiltList<String>? notIncluded;

  factory _$AccountExportDto([
    void Function(AccountExportDtoBuilder)? updates,
  ]) => (AccountExportDtoBuilder()..update(updates))._build();

  _$AccountExportDto._({
    this.exportedAt,
    required this.profile,
    this.schoolUsers,
    this.agendaEntries,
    this.semesterReports,
    this.documents,
    this.linkedAccounts,
    this.privacyNotice,
    this.signIn,
    this.connectedAccounts,
    this.helply,
    this.aiApps,
    this.notifications,
    this.notIncluded,
  }) : super._();
  @override
  AccountExportDto rebuild(void Function(AccountExportDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AccountExportDtoBuilder toBuilder() =>
      AccountExportDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountExportDto &&
        exportedAt == other.exportedAt &&
        profile == other.profile &&
        schoolUsers == other.schoolUsers &&
        agendaEntries == other.agendaEntries &&
        semesterReports == other.semesterReports &&
        documents == other.documents &&
        linkedAccounts == other.linkedAccounts &&
        privacyNotice == other.privacyNotice &&
        signIn == other.signIn &&
        connectedAccounts == other.connectedAccounts &&
        helply == other.helply &&
        aiApps == other.aiApps &&
        notifications == other.notifications &&
        notIncluded == other.notIncluded;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, exportedAt.hashCode);
    _$hash = $jc(_$hash, profile.hashCode);
    _$hash = $jc(_$hash, schoolUsers.hashCode);
    _$hash = $jc(_$hash, agendaEntries.hashCode);
    _$hash = $jc(_$hash, semesterReports.hashCode);
    _$hash = $jc(_$hash, documents.hashCode);
    _$hash = $jc(_$hash, linkedAccounts.hashCode);
    _$hash = $jc(_$hash, privacyNotice.hashCode);
    _$hash = $jc(_$hash, signIn.hashCode);
    _$hash = $jc(_$hash, connectedAccounts.hashCode);
    _$hash = $jc(_$hash, helply.hashCode);
    _$hash = $jc(_$hash, aiApps.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jc(_$hash, notIncluded.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountExportDto')
          ..add('exportedAt', exportedAt)
          ..add('profile', profile)
          ..add('schoolUsers', schoolUsers)
          ..add('agendaEntries', agendaEntries)
          ..add('semesterReports', semesterReports)
          ..add('documents', documents)
          ..add('linkedAccounts', linkedAccounts)
          ..add('privacyNotice', privacyNotice)
          ..add('signIn', signIn)
          ..add('connectedAccounts', connectedAccounts)
          ..add('helply', helply)
          ..add('aiApps', aiApps)
          ..add('notifications', notifications)
          ..add('notIncluded', notIncluded))
        .toString();
  }
}

class AccountExportDtoBuilder
    implements Builder<AccountExportDto, AccountExportDtoBuilder> {
  _$AccountExportDto? _$v;

  DateTime? _exportedAt;
  DateTime? get exportedAt => _$this._exportedAt;
  set exportedAt(DateTime? exportedAt) => _$this._exportedAt = exportedAt;

  ApplicationUserDtoBuilder? _profile;
  ApplicationUserDtoBuilder get profile =>
      _$this._profile ??= ApplicationUserDtoBuilder();
  set profile(ApplicationUserDtoBuilder? profile) => _$this._profile = profile;

  ListBuilder<SchoolUserDto>? _schoolUsers;
  ListBuilder<SchoolUserDto> get schoolUsers =>
      _$this._schoolUsers ??= ListBuilder<SchoolUserDto>();
  set schoolUsers(ListBuilder<SchoolUserDto>? schoolUsers) =>
      _$this._schoolUsers = schoolUsers;

  ListBuilder<AgendaEntryDto>? _agendaEntries;
  ListBuilder<AgendaEntryDto> get agendaEntries =>
      _$this._agendaEntries ??= ListBuilder<AgendaEntryDto>();
  set agendaEntries(ListBuilder<AgendaEntryDto>? agendaEntries) =>
      _$this._agendaEntries = agendaEntries;

  ListBuilder<SemesterReportDto>? _semesterReports;
  ListBuilder<SemesterReportDto> get semesterReports =>
      _$this._semesterReports ??= ListBuilder<SemesterReportDto>();
  set semesterReports(ListBuilder<SemesterReportDto>? semesterReports) =>
      _$this._semesterReports = semesterReports;

  ListBuilder<StudentDocumentDto>? _documents;
  ListBuilder<StudentDocumentDto> get documents =>
      _$this._documents ??= ListBuilder<StudentDocumentDto>();
  set documents(ListBuilder<StudentDocumentDto>? documents) =>
      _$this._documents = documents;

  ListBuilder<LinkedAccountDto>? _linkedAccounts;
  ListBuilder<LinkedAccountDto> get linkedAccounts =>
      _$this._linkedAccounts ??= ListBuilder<LinkedAccountDto>();
  set linkedAccounts(ListBuilder<LinkedAccountDto>? linkedAccounts) =>
      _$this._linkedAccounts = linkedAccounts;

  ExportPrivacyNoticeDtoBuilder? _privacyNotice;
  ExportPrivacyNoticeDtoBuilder get privacyNotice =>
      _$this._privacyNotice ??= ExportPrivacyNoticeDtoBuilder();
  set privacyNotice(ExportPrivacyNoticeDtoBuilder? privacyNotice) =>
      _$this._privacyNotice = privacyNotice;

  ExportSignInDtoBuilder? _signIn;
  ExportSignInDtoBuilder get signIn =>
      _$this._signIn ??= ExportSignInDtoBuilder();
  set signIn(ExportSignInDtoBuilder? signIn) => _$this._signIn = signIn;

  ListBuilder<ExportConnectedAccountDto>? _connectedAccounts;
  ListBuilder<ExportConnectedAccountDto> get connectedAccounts =>
      _$this._connectedAccounts ??= ListBuilder<ExportConnectedAccountDto>();
  set connectedAccounts(
    ListBuilder<ExportConnectedAccountDto>? connectedAccounts,
  ) => _$this._connectedAccounts = connectedAccounts;

  ExportHelplyDtoBuilder? _helply;
  ExportHelplyDtoBuilder get helply =>
      _$this._helply ??= ExportHelplyDtoBuilder();
  set helply(ExportHelplyDtoBuilder? helply) => _$this._helply = helply;

  ExportAiAppsDtoBuilder? _aiApps;
  ExportAiAppsDtoBuilder get aiApps =>
      _$this._aiApps ??= ExportAiAppsDtoBuilder();
  set aiApps(ExportAiAppsDtoBuilder? aiApps) => _$this._aiApps = aiApps;

  ExportNotificationsDtoBuilder? _notifications;
  ExportNotificationsDtoBuilder get notifications =>
      _$this._notifications ??= ExportNotificationsDtoBuilder();
  set notifications(ExportNotificationsDtoBuilder? notifications) =>
      _$this._notifications = notifications;

  ListBuilder<String>? _notIncluded;
  ListBuilder<String> get notIncluded =>
      _$this._notIncluded ??= ListBuilder<String>();
  set notIncluded(ListBuilder<String>? notIncluded) =>
      _$this._notIncluded = notIncluded;

  AccountExportDtoBuilder() {
    AccountExportDto._defaults(this);
  }

  AccountExportDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _exportedAt = $v.exportedAt;
      _profile = $v.profile.toBuilder();
      _schoolUsers = $v.schoolUsers?.toBuilder();
      _agendaEntries = $v.agendaEntries?.toBuilder();
      _semesterReports = $v.semesterReports?.toBuilder();
      _documents = $v.documents?.toBuilder();
      _linkedAccounts = $v.linkedAccounts?.toBuilder();
      _privacyNotice = $v.privacyNotice?.toBuilder();
      _signIn = $v.signIn?.toBuilder();
      _connectedAccounts = $v.connectedAccounts?.toBuilder();
      _helply = $v.helply?.toBuilder();
      _aiApps = $v.aiApps?.toBuilder();
      _notifications = $v.notifications?.toBuilder();
      _notIncluded = $v.notIncluded?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountExportDto other) {
    _$v = other as _$AccountExportDto;
  }

  @override
  void update(void Function(AccountExportDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountExportDto build() => _build();

  _$AccountExportDto _build() {
    _$AccountExportDto _$result;
    try {
      _$result =
          _$v ??
          _$AccountExportDto._(
            exportedAt: exportedAt,
            profile: profile.build(),
            schoolUsers: _schoolUsers?.build(),
            agendaEntries: _agendaEntries?.build(),
            semesterReports: _semesterReports?.build(),
            documents: _documents?.build(),
            linkedAccounts: _linkedAccounts?.build(),
            privacyNotice: _privacyNotice?.build(),
            signIn: _signIn?.build(),
            connectedAccounts: _connectedAccounts?.build(),
            helply: _helply?.build(),
            aiApps: _aiApps?.build(),
            notifications: _notifications?.build(),
            notIncluded: _notIncluded?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'profile';
        profile.build();
        _$failedField = 'schoolUsers';
        _schoolUsers?.build();
        _$failedField = 'agendaEntries';
        _agendaEntries?.build();
        _$failedField = 'semesterReports';
        _semesterReports?.build();
        _$failedField = 'documents';
        _documents?.build();
        _$failedField = 'linkedAccounts';
        _linkedAccounts?.build();
        _$failedField = 'privacyNotice';
        _privacyNotice?.build();
        _$failedField = 'signIn';
        _signIn?.build();
        _$failedField = 'connectedAccounts';
        _connectedAccounts?.build();
        _$failedField = 'helply';
        _helply?.build();
        _$failedField = 'aiApps';
        _aiApps?.build();
        _$failedField = 'notifications';
        _notifications?.build();
        _$failedField = 'notIncluded';
        _notIncluded?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountExportDto',
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
