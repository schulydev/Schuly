// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_exam.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessExam extends OdaorgStatelessExam {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? subject;

  factory _$OdaorgStatelessExam([
    void Function(OdaorgStatelessExamBuilder)? updates,
  ]) => (OdaorgStatelessExamBuilder()..update(updates))._build();

  _$OdaorgStatelessExam._({this.id, this.name, this.subject}) : super._();
  @override
  OdaorgStatelessExam rebuild(
    void Function(OdaorgStatelessExamBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessExamBuilder toBuilder() =>
      OdaorgStatelessExamBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessExam &&
        id == other.id &&
        name == other.name &&
        subject == other.subject;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessExam')
          ..add('id', id)
          ..add('name', name)
          ..add('subject', subject))
        .toString();
  }
}

class OdaorgStatelessExamBuilder
    implements Builder<OdaorgStatelessExam, OdaorgStatelessExamBuilder> {
  _$OdaorgStatelessExam? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  OdaorgStatelessExamBuilder() {
    OdaorgStatelessExam._defaults(this);
  }

  OdaorgStatelessExamBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _subject = $v.subject;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessExam other) {
    _$v = other as _$OdaorgStatelessExam;
  }

  @override
  void update(void Function(OdaorgStatelessExamBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessExam build() => _build();

  _$OdaorgStatelessExam _build() {
    final _$result =
        _$v ?? _$OdaorgStatelessExam._(id: id, name: name, subject: subject);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
