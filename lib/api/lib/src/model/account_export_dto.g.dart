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
        documents == other.documents;
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
          ..add('documents', documents))
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
