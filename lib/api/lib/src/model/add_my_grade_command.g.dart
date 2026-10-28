// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_my_grade_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AddMyGradeCommand extends AddMyGradeCommand {
  @override
  final String schoolUserId;
  @override
  final String subject;
  @override
  final String examName;
  @override
  final double score;
  @override
  final double weight;
  @override
  final Date? examDate;

  factory _$AddMyGradeCommand([
    void Function(AddMyGradeCommandBuilder)? updates,
  ]) => (AddMyGradeCommandBuilder()..update(updates))._build();

  _$AddMyGradeCommand._({
    required this.schoolUserId,
    required this.subject,
    required this.examName,
    required this.score,
    required this.weight,
    this.examDate,
  }) : super._();
  @override
  AddMyGradeCommand rebuild(void Function(AddMyGradeCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddMyGradeCommandBuilder toBuilder() =>
      AddMyGradeCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddMyGradeCommand &&
        schoolUserId == other.schoolUserId &&
        subject == other.subject &&
        examName == other.examName &&
        score == other.score &&
        weight == other.weight &&
        examDate == other.examDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, examName.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jc(_$hash, examDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AddMyGradeCommand')
          ..add('schoolUserId', schoolUserId)
          ..add('subject', subject)
          ..add('examName', examName)
          ..add('score', score)
          ..add('weight', weight)
          ..add('examDate', examDate))
        .toString();
  }
}

class AddMyGradeCommandBuilder
    implements Builder<AddMyGradeCommand, AddMyGradeCommandBuilder> {
  _$AddMyGradeCommand? _$v;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _examName;
  String? get examName => _$this._examName;
  set examName(String? examName) => _$this._examName = examName;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  Date? _examDate;
  Date? get examDate => _$this._examDate;
  set examDate(Date? examDate) => _$this._examDate = examDate;

  AddMyGradeCommandBuilder() {
    AddMyGradeCommand._defaults(this);
  }

  AddMyGradeCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schoolUserId = $v.schoolUserId;
      _subject = $v.subject;
      _examName = $v.examName;
      _score = $v.score;
      _weight = $v.weight;
      _examDate = $v.examDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddMyGradeCommand other) {
    _$v = other as _$AddMyGradeCommand;
  }

  @override
  void update(void Function(AddMyGradeCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddMyGradeCommand build() => _build();

  _$AddMyGradeCommand _build() {
    final _$result =
        _$v ??
        _$AddMyGradeCommand._(
          schoolUserId: BuiltValueNullFieldError.checkNotNull(
            schoolUserId,
            r'AddMyGradeCommand',
            'schoolUserId',
          ),
          subject: BuiltValueNullFieldError.checkNotNull(
            subject,
            r'AddMyGradeCommand',
            'subject',
          ),
          examName: BuiltValueNullFieldError.checkNotNull(
            examName,
            r'AddMyGradeCommand',
            'examName',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'AddMyGradeCommand',
            'score',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'AddMyGradeCommand',
            'weight',
          ),
          examDate: examDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
