// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notification_preferences_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateNotificationPreferencesCommand
    extends UpdateNotificationPreferencesCommand {
  @override
  final bool grades;
  @override
  final bool absences;
  @override
  final bool agenda;
  @override
  final bool includeGradeValue;

  factory _$UpdateNotificationPreferencesCommand([
    void Function(UpdateNotificationPreferencesCommandBuilder)? updates,
  ]) =>
      (UpdateNotificationPreferencesCommandBuilder()..update(updates))._build();

  _$UpdateNotificationPreferencesCommand._({
    required this.grades,
    required this.absences,
    required this.agenda,
    required this.includeGradeValue,
  }) : super._();
  @override
  UpdateNotificationPreferencesCommand rebuild(
    void Function(UpdateNotificationPreferencesCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateNotificationPreferencesCommandBuilder toBuilder() =>
      UpdateNotificationPreferencesCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateNotificationPreferencesCommand &&
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
    return (newBuiltValueToStringHelper(r'UpdateNotificationPreferencesCommand')
          ..add('grades', grades)
          ..add('absences', absences)
          ..add('agenda', agenda)
          ..add('includeGradeValue', includeGradeValue))
        .toString();
  }
}

class UpdateNotificationPreferencesCommandBuilder
    implements
        Builder<
          UpdateNotificationPreferencesCommand,
          UpdateNotificationPreferencesCommandBuilder
        > {
  _$UpdateNotificationPreferencesCommand? _$v;

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

  UpdateNotificationPreferencesCommandBuilder() {
    UpdateNotificationPreferencesCommand._defaults(this);
  }

  UpdateNotificationPreferencesCommandBuilder get _$this {
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
  void replace(UpdateNotificationPreferencesCommand other) {
    _$v = other as _$UpdateNotificationPreferencesCommand;
  }

  @override
  void update(
    void Function(UpdateNotificationPreferencesCommandBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  UpdateNotificationPreferencesCommand build() => _build();

  _$UpdateNotificationPreferencesCommand _build() {
    final _$result =
        _$v ??
        _$UpdateNotificationPreferencesCommand._(
          grades: BuiltValueNullFieldError.checkNotNull(
            grades,
            r'UpdateNotificationPreferencesCommand',
            'grades',
          ),
          absences: BuiltValueNullFieldError.checkNotNull(
            absences,
            r'UpdateNotificationPreferencesCommand',
            'absences',
          ),
          agenda: BuiltValueNullFieldError.checkNotNull(
            agenda,
            r'UpdateNotificationPreferencesCommand',
            'agenda',
          ),
          includeGradeValue: BuiltValueNullFieldError.checkNotNull(
            includeGradeValue,
            r'UpdateNotificationPreferencesCommand',
            'includeGradeValue',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
