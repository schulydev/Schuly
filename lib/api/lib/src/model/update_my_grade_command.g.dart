// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_my_grade_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateMyGradeCommand extends UpdateMyGradeCommand {
  @override
  final String gradeId;
  @override
  final double score;
  @override
  final double weight;

  factory _$UpdateMyGradeCommand([
    void Function(UpdateMyGradeCommandBuilder)? updates,
  ]) => (UpdateMyGradeCommandBuilder()..update(updates))._build();

  _$UpdateMyGradeCommand._({
    required this.gradeId,
    required this.score,
    required this.weight,
  }) : super._();
  @override
  UpdateMyGradeCommand rebuild(
    void Function(UpdateMyGradeCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateMyGradeCommandBuilder toBuilder() =>
      UpdateMyGradeCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateMyGradeCommand &&
        gradeId == other.gradeId &&
        score == other.score &&
        weight == other.weight;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gradeId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, weight.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateMyGradeCommand')
          ..add('gradeId', gradeId)
          ..add('score', score)
          ..add('weight', weight))
        .toString();
  }
}

class UpdateMyGradeCommandBuilder
    implements Builder<UpdateMyGradeCommand, UpdateMyGradeCommandBuilder> {
  _$UpdateMyGradeCommand? _$v;

  String? _gradeId;
  String? get gradeId => _$this._gradeId;
  set gradeId(String? gradeId) => _$this._gradeId = gradeId;

  double? _score;
  double? get score => _$this._score;
  set score(double? score) => _$this._score = score;

  double? _weight;
  double? get weight => _$this._weight;
  set weight(double? weight) => _$this._weight = weight;

  UpdateMyGradeCommandBuilder() {
    UpdateMyGradeCommand._defaults(this);
  }

  UpdateMyGradeCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gradeId = $v.gradeId;
      _score = $v.score;
      _weight = $v.weight;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateMyGradeCommand other) {
    _$v = other as _$UpdateMyGradeCommand;
  }

  @override
  void update(void Function(UpdateMyGradeCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateMyGradeCommand build() => _build();

  _$UpdateMyGradeCommand _build() {
    final _$result =
        _$v ??
        _$UpdateMyGradeCommand._(
          gradeId: BuiltValueNullFieldError.checkNotNull(
            gradeId,
            r'UpdateMyGradeCommand',
            'gradeId',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'UpdateMyGradeCommand',
            'score',
          ),
          weight: BuiltValueNullFieldError.checkNotNull(
            weight,
            r'UpdateMyGradeCommand',
            'weight',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
