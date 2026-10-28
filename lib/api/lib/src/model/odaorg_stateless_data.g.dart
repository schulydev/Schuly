// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessData extends OdaorgStatelessData {
  @override
  final OdaorgStatelessUserInfo? userInfo;
  @override
  final BuiltList<OdaorgStatelessGrade> grades;
  @override
  final BuiltList<OdaorgStatelessExam> exams;
  @override
  final BuiltList<OdaorgStatelessAgendaEvent> agenda;

  factory _$OdaorgStatelessData([
    void Function(OdaorgStatelessDataBuilder)? updates,
  ]) => (OdaorgStatelessDataBuilder()..update(updates))._build();

  _$OdaorgStatelessData._({
    this.userInfo,
    required this.grades,
    required this.exams,
    required this.agenda,
  }) : super._();
  @override
  OdaorgStatelessData rebuild(
    void Function(OdaorgStatelessDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessDataBuilder toBuilder() =>
      OdaorgStatelessDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessData &&
        userInfo == other.userInfo &&
        grades == other.grades &&
        exams == other.exams &&
        agenda == other.agenda;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userInfo.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jc(_$hash, exams.hashCode);
    _$hash = $jc(_$hash, agenda.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessData')
          ..add('userInfo', userInfo)
          ..add('grades', grades)
          ..add('exams', exams)
          ..add('agenda', agenda))
        .toString();
  }
}

class OdaorgStatelessDataBuilder
    implements Builder<OdaorgStatelessData, OdaorgStatelessDataBuilder> {
  _$OdaorgStatelessData? _$v;

  OdaorgStatelessUserInfoBuilder? _userInfo;
  OdaorgStatelessUserInfoBuilder get userInfo =>
      _$this._userInfo ??= OdaorgStatelessUserInfoBuilder();
  set userInfo(OdaorgStatelessUserInfoBuilder? userInfo) =>
      _$this._userInfo = userInfo;

  ListBuilder<OdaorgStatelessGrade>? _grades;
  ListBuilder<OdaorgStatelessGrade> get grades =>
      _$this._grades ??= ListBuilder<OdaorgStatelessGrade>();
  set grades(ListBuilder<OdaorgStatelessGrade>? grades) =>
      _$this._grades = grades;

  ListBuilder<OdaorgStatelessExam>? _exams;
  ListBuilder<OdaorgStatelessExam> get exams =>
      _$this._exams ??= ListBuilder<OdaorgStatelessExam>();
  set exams(ListBuilder<OdaorgStatelessExam>? exams) => _$this._exams = exams;

  ListBuilder<OdaorgStatelessAgendaEvent>? _agenda;
  ListBuilder<OdaorgStatelessAgendaEvent> get agenda =>
      _$this._agenda ??= ListBuilder<OdaorgStatelessAgendaEvent>();
  set agenda(ListBuilder<OdaorgStatelessAgendaEvent>? agenda) =>
      _$this._agenda = agenda;

  OdaorgStatelessDataBuilder() {
    OdaorgStatelessData._defaults(this);
  }

  OdaorgStatelessDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userInfo = $v.userInfo?.toBuilder();
      _grades = $v.grades.toBuilder();
      _exams = $v.exams.toBuilder();
      _agenda = $v.agenda.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessData other) {
    _$v = other as _$OdaorgStatelessData;
  }

  @override
  void update(void Function(OdaorgStatelessDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessData build() => _build();

  _$OdaorgStatelessData _build() {
    _$OdaorgStatelessData _$result;
    try {
      _$result =
          _$v ??
          _$OdaorgStatelessData._(
            userInfo: _userInfo?.build(),
            grades: grades.build(),
            exams: exams.build(),
            agenda: agenda.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userInfo';
        _userInfo?.build();
        _$failedField = 'grades';
        grades.build();
        _$failedField = 'exams';
        exams.build();
        _$failedField = 'agenda';
        agenda.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'OdaorgStatelessData',
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
