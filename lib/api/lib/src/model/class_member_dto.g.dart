// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_member_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassMemberDto extends ClassMemberDto {
  @override
  final String? id;
  @override
  final String? schoolId;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? profilePictureUrl;
  @override
  final Roles role;
  @override
  final BuiltList<AbsenceDto>? absences;
  @override
  final BuiltList<GradeDto>? grades;

  factory _$ClassMemberDto([void Function(ClassMemberDtoBuilder)? updates]) =>
      (ClassMemberDtoBuilder()..update(updates))._build();

  _$ClassMemberDto._({
    this.id,
    this.schoolId,
    required this.firstName,
    required this.lastName,
    this.profilePictureUrl,
    required this.role,
    this.absences,
    this.grades,
  }) : super._();
  @override
  ClassMemberDto rebuild(void Function(ClassMemberDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassMemberDtoBuilder toBuilder() => ClassMemberDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassMemberDto &&
        id == other.id &&
        schoolId == other.schoolId &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        profilePictureUrl == other.profilePictureUrl &&
        role == other.role &&
        absences == other.absences &&
        grades == other.grades;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, profilePictureUrl.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, absences.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassMemberDto')
          ..add('id', id)
          ..add('schoolId', schoolId)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('profilePictureUrl', profilePictureUrl)
          ..add('role', role)
          ..add('absences', absences)
          ..add('grades', grades))
        .toString();
  }
}

class ClassMemberDtoBuilder
    implements Builder<ClassMemberDto, ClassMemberDtoBuilder> {
  _$ClassMemberDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _schoolId;
  String? get schoolId => _$this._schoolId;
  set schoolId(String? schoolId) => _$this._schoolId = schoolId;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _profilePictureUrl;
  String? get profilePictureUrl => _$this._profilePictureUrl;
  set profilePictureUrl(String? profilePictureUrl) =>
      _$this._profilePictureUrl = profilePictureUrl;

  Roles? _role;
  Roles? get role => _$this._role;
  set role(Roles? role) => _$this._role = role;

  ListBuilder<AbsenceDto>? _absences;
  ListBuilder<AbsenceDto> get absences =>
      _$this._absences ??= ListBuilder<AbsenceDto>();
  set absences(ListBuilder<AbsenceDto>? absences) =>
      _$this._absences = absences;

  ListBuilder<GradeDto>? _grades;
  ListBuilder<GradeDto> get grades =>
      _$this._grades ??= ListBuilder<GradeDto>();
  set grades(ListBuilder<GradeDto>? grades) => _$this._grades = grades;

  ClassMemberDtoBuilder() {
    ClassMemberDto._defaults(this);
  }

  ClassMemberDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _schoolId = $v.schoolId;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _profilePictureUrl = $v.profilePictureUrl;
      _role = $v.role;
      _absences = $v.absences?.toBuilder();
      _grades = $v.grades?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassMemberDto other) {
    _$v = other as _$ClassMemberDto;
  }

  @override
  void update(void Function(ClassMemberDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassMemberDto build() => _build();

  _$ClassMemberDto _build() {
    _$ClassMemberDto _$result;
    try {
      _$result =
          _$v ??
          _$ClassMemberDto._(
            id: id,
            schoolId: schoolId,
            firstName: BuiltValueNullFieldError.checkNotNull(
              firstName,
              r'ClassMemberDto',
              'firstName',
            ),
            lastName: BuiltValueNullFieldError.checkNotNull(
              lastName,
              r'ClassMemberDto',
              'lastName',
            ),
            profilePictureUrl: profilePictureUrl,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'ClassMemberDto',
              'role',
            ),
            absences: _absences?.build(),
            grades: _grades?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'absences';
        _absences?.build();
        _$failedField = 'grades';
        _grades?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ClassMemberDto',
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
