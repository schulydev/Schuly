// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_grade.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessGrade extends OdaorgStatelessGrade {
  @override
  final String? id;
  @override
  final String? examId;
  @override
  final String? subject;
  @override
  final double? score;

  factory _$OdaorgStatelessGrade([
    void Function(OdaorgStatelessGradeBuilder)? updates,
  ]) => (OdaorgStatelessGradeBuilder()..update(updates))._build();

  _$OdaorgStatelessGrade._({this.id, this.examId, this.subject, this.score})
    : super._();
  @override
  OdaorgStatelessGrade rebuild(
    void Function(OdaorgStatelessGradeBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessGradeBuilder toBuilder() =>
      OdaorgStatelessGradeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessGrade &&
        id == other.id &&
        examId == other.examId &&
        subject == other.subject &&
        score == other.score;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, examId.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessGrade')
          ..add('id', id)
          ..add('examId', examId)
          ..add('subject', subject)
          ..add('score', score))
        .toString();
  }
}

class OdaorgStatelessGradeBuilder
    implements Builder<OdaorgStatelessGrade, OdaorgStatelessGradeBuilder> {
  _$OdaorgStatelessGrade? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _examId;
  String? get examId => _$this._examId;
  set examId(String? examId) => _$this._examId = examId;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  OdaorgStatelessGradeBuilder() {
    OdaorgStatelessGrade._defaults(this);
  }

  OdaorgStatelessGradeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _examId = $v.examId;
      _subject = $v.subject;
      _score = $v.score;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessGrade other) {
    _$v = other as _$OdaorgStatelessGrade;
  }

  @override
  void update(void Function(OdaorgStatelessGradeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessGrade build() => _build();

  _$OdaorgStatelessGrade _build() {
    final _$result =
        _$v ??
        _$OdaorgStatelessGrade._(
          id: id,
          examId: examId,
          subject: subject,
          score: score,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
