// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationPreferencesDto extends NotificationPreferencesDto {
  @override
  final bool grades;
  @override
  final bool absences;
  @override
  final bool agenda;
  @override
  final bool includeGradeValue;

  factory _$NotificationPreferencesDto([
    void Function(NotificationPreferencesDtoBuilder)? updates,
  ]) => (NotificationPreferencesDtoBuilder()..update(updates))._build();

  _$NotificationPreferencesDto._({
    required this.grades,
    required this.absences,
    required this.agenda,
    required this.includeGradeValue,
  }) : super._();
  @override
  NotificationPreferencesDto rebuild(
    void Function(NotificationPreferencesDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  NotificationPreferencesDtoBuilder toBuilder() =>
      NotificationPreferencesDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationPreferencesDto &&
        grades == other.grades &&
        absences == other.absences &&
        agenda == other.agenda &&
        includeGradeValue == other.includeGradeValue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jc(_$hash, absences.hashCode);
    _$hash = $jc(_$hash, agenda.hashCode);
    _$hash = $jc(_$hash, includeGradeValue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationPreferencesDto')
          ..add('grades', grades)
          ..add('absences', absences)
          ..add('agenda', agenda)
          ..add('includeGradeValue', includeGradeValue))
        .toString();
  }
}

class NotificationPreferencesDtoBuilder
    implements
        Builder<NotificationPreferencesDto, NotificationPreferencesDtoBuilder> {
  _$NotificationPreferencesDto? _$v;

  bool? _grades;
  bool? get grades => _$this._grades;
  set grades(bool? grades) => _$this._grades = grades;

  bool? _absences;
  bool? get absences => _$this._absences;
  set absences(bool? absences) => _$this._absences = absences;

  bool? _agenda;
  bool? get agenda => _$this._agenda;
  set agenda(bool? agenda) => _$this._agenda = agenda;

  bool? _includeGradeValue;
  bool? get includeGradeValue => _$this._includeGradeValue;
  set includeGradeValue(bool? includeGradeValue) =>
      _$this._includeGradeValue = includeGradeValue;

  NotificationPreferencesDtoBuilder() {
    NotificationPreferencesDto._defaults(this);
  }

  NotificationPreferencesDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _grades = $v.grades;
      _absences = $v.absences;
      _agenda = $v.agenda;
      _includeGradeValue = $v.includeGradeValue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationPreferencesDto other) {
    _$v = other as _$NotificationPreferencesDto;
  }

  @override
  void update(void Function(NotificationPreferencesDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationPreferencesDto build() => _build();

  _$NotificationPreferencesDto _build() {
    final _$result =
        _$v ??
        _$NotificationPreferencesDto._(
          grades: BuiltValueNullFieldError.checkNotNull(
            grades,
            r'NotificationPreferencesDto',
            'grades',
          ),
          absences: BuiltValueNullFieldError.checkNotNull(
            absences,
            r'NotificationPreferencesDto',
            'absences',
          ),
          agenda: BuiltValueNullFieldError.checkNotNull(
            agenda,
            r'NotificationPreferencesDto',
            'agenda',
          ),
          includeGradeValue: BuiltValueNullFieldError.checkNotNull(
            includeGradeValue,
            r'NotificationPreferencesDto',
            'includeGradeValue',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
