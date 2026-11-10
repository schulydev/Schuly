// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AbsenceDto extends AbsenceDto {
  @override
  final String? id;
  @override
  final String reason;
  @override
  final AbsenceType type;
  @override
  final DateTime from;
  @override
  final DateTime until;
  @override
  final bool? isExcused;
  @override
  final String? startTime;
  @override
  final String? endTime;
  @override
  final String? parentStatus;
  @override
  final String? parentStatusDate;
  @override
  final String? trainerStatus;
  @override
  final String? trainerStatusDate;
  @override
  final String? trainerComment;
  @override
  final String? comment;
  @override
  final String? excuseDeadline;
  @override
  final int? lessons;
  @override
  final String? schoolUserId;
  @override
  final String? schoolId;

  factory _$AbsenceDto([void Function(AbsenceDtoBuilder)? updates]) =>
      (AbsenceDtoBuilder()..update(updates))._build();

  _$AbsenceDto._({
    this.id,
    required this.reason,
    required this.type,
    required this.from,
    required this.until,
    this.isExcused,
    this.startTime,
    this.endTime,
    this.parentStatus,
    this.parentStatusDate,
    this.trainerStatus,
    this.trainerStatusDate,
    this.trainerComment,
    this.comment,
    this.excuseDeadline,
    this.lessons,
    this.schoolUserId,
    this.schoolId,
  }) : super._();
  @override
  AbsenceDto rebuild(void Function(AbsenceDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AbsenceDtoBuilder toBuilder() => AbsenceDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AbsenceDto &&
        id == other.id &&
        reason == other.reason &&
        type == other.type &&
        from == other.from &&
        until == other.until &&
        isExcused == other.isExcused &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        parentStatus == other.parentStatus &&
        parentStatusDate == other.parentStatusDate &&
        trainerStatus == other.trainerStatus &&
        trainerStatusDate == other.trainerStatusDate &&
        trainerComment == other.trainerComment &&
        comment == other.comment &&
        excuseDeadline == other.excuseDeadline &&
        lessons == other.lessons &&
        schoolUserId == other.schoolUserId &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, until.hashCode);
    _$hash = $jc(_$hash, isExcused.hashCode);
    _$hash = $jc(_$hash, startTime.hashCode);
    _$hash = $jc(_$hash, endTime.hashCode);
    _$hash = $jc(_$hash, parentStatus.hashCode);
    _$hash = $jc(_$hash, parentStatusDate.hashCode);
    _$hash = $jc(_$hash, trainerStatus.hashCode);
    _$hash = $jc(_$hash, trainerStatusDate.hashCode);
    _$hash = $jc(_$hash, trainerComment.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jc(_$hash, excuseDeadline.hashCode);
    _$hash = $jc(_$hash, lessons.hashCode);
    _$hash = $jc(_$hash, schoolUserId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AbsenceDto')
          ..add('id', id)
          ..add('reason', reason)
          ..add('type', type)
          ..add('from', from)
          ..add('until', until)
          ..add('isExcused', isExcused)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('parentStatus', parentStatus)
          ..add('parentStatusDate', parentStatusDate)
          ..add('trainerStatus', trainerStatus)
          ..add('trainerStatusDate', trainerStatusDate)
          ..add('trainerComment', trainerComment)
          ..add('comment', comment)
          ..add('excuseDeadline', excuseDeadline)
          ..add('lessons', lessons)
          ..add('schoolUserId', schoolUserId)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class AbsenceDtoBuilder implements Builder<AbsenceDto, AbsenceDtoBuilder> {
  _$AbsenceDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  AbsenceType? _type;
  AbsenceType? get type => _$this._type;
  set type(AbsenceType? type) => _$this._type = type;

  DateTime? _from;
  DateTime? get from => _$this._from;
  set from(DateTime? from) => _$this._from = from;

  DateTime? _until;
  DateTime? get until => _$this._until;
  set until(DateTime? until) => _$this._until = until;

  bool? _isExcused;
  bool? get isExcused => _$this._isExcused;
  set isExcused(bool? isExcused) => _$this._isExcused = isExcused;

  String? _startTime;
  String? get startTime => _$this._startTime;
  set startTime(String? startTime) => _$this._startTime = startTime;

  String? _endTime;
  String? get endTime => _$this._endTime;
  set endTime(String? endTime) => _$this._endTime = endTime;

  String? _parentStatus;
  String? get parentStatus => _$this._parentStatus;
  set parentStatus(String? parentStatus) => _$this._parentStatus = parentStatus;

  String? _parentStatusDate;
  String? get parentStatusDate => _$this._parentStatusDate;
  set parentStatusDate(String? parentStatusDate) =>
      _$this._parentStatusDate = parentStatusDate;

  String? _trainerStatus;
  String? get trainerStatus => _$this._trainerStatus;
  set trainerStatus(String? trainerStatus) =>
      _$this._trainerStatus = trainerStatus;

  String? _trainerStatusDate;
  String? get trainerStatusDate => _$this._trainerStatusDate;
  set trainerStatusDate(String? trainerStatusDate) =>
      _$this._trainerStatusDate = trainerStatusDate;

  String? _trainerComment;
  String? get trainerComment => _$this._trainerComment;
  set trainerComment(String? trainerComment) =>
      _$this._trainerComment = trainerComment;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  String? _excuseDeadline;
  String? get excuseDeadline => _$this._excuseDeadline;
  set excuseDeadline(String? excuseDeadline) =>
      _$this._excuseDeadline = excuseDeadline;

  int? _lessons;
  int? get lessons => _$this._lessons;
  set lessons(int? lessons) => _$this._lessons = lessons;

  String? _schoolUserId;
  String? get schoolUserId => _$this._schoolUserId;
  set schoolUserId(String? schoolUserId) => _$this._schoolUserId = schoolUserId;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  AbsenceDtoBuilder() {
    AbsenceDto._defaults(this);
  }

  AbsenceDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _reason = $v.reason;
      _type = $v.type;
      _from = $v.from;
      _until = $v.until;
      _isExcused = $v.isExcused;
      _startTime = $v.startTime;
      _endTime = $v.endTime;
      _parentStatus = $v.parentStatus;
      _parentStatusDate = $v.parentStatusDate;
      _trainerStatus = $v.trainerStatus;
      _trainerStatusDate = $v.trainerStatusDate;
      _trainerComment = $v.trainerComment;
      _comment = $v.comment;
      _excuseDeadline = $v.excuseDeadline;
      _lessons = $v.lessons;
      _schoolUserId = $v.schoolUserId;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AbsenceDto other) {
    _$v = other as _$AbsenceDto;
  }

  @override
  void update(void Function(AbsenceDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AbsenceDto build() => _build();

  _$AbsenceDto _build() {
    final _$result =
        _$v ??
        _$AbsenceDto._(
          id: id,
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'AbsenceDto',
            'reason',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'AbsenceDto',
            'type',
          ),
          from: BuiltValueNullFieldError.checkNotNull(
            from,
            r'AbsenceDto',
            'from',
          ),
          until: BuiltValueNullFieldError.checkNotNull(
            until,
            r'AbsenceDto',
            'until',
          ),
          isExcused: isExcused,
          startTime: startTime,
          endTime: endTime,
          parentStatus: parentStatus,
          parentStatusDate: parentStatusDate,
          trainerStatus: trainerStatus,
          trainerStatusDate: trainerStatusDate,
          trainerComment: trainerComment,
          comment: comment,
          excuseDeadline: excuseDeadline,
          lessons: lessons,
          schoolUserId: schoolUserId,
          schoolId: schoolId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
