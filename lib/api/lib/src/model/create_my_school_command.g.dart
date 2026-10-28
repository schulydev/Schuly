// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_my_school_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateMySchoolCommand extends CreateMySchoolCommand {
  @override
  final String schoolName;
  @override
  final String firstName;
  @override
  final String lastName;

  factory _$CreateMySchoolCommand([
    void Function(CreateMySchoolCommandBuilder)? updates,
  ]) => (CreateMySchoolCommandBuilder()..update(updates))._build();

  _$CreateMySchoolCommand._({
    required this.schoolName,
    required this.firstName,
    required this.lastName,
  }) : super._();
  @override
  CreateMySchoolCommand rebuild(
    void Function(CreateMySchoolCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateMySchoolCommandBuilder toBuilder() =>
      CreateMySchoolCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMySchoolCommand &&
        schoolName == other.schoolName &&
        firstName == other.firstName &&
        lastName == other.lastName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, schoolName.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateMySchoolCommand')
          ..add('schoolName', schoolName)
          ..add('firstName', firstName)
          ..add('lastName', lastName))
        .toString();
  }
}

class CreateMySchoolCommandBuilder
    implements Builder<CreateMySchoolCommand, CreateMySchoolCommandBuilder> {
  _$CreateMySchoolCommand? _$v;

  String? _schoolName;
  String? get schoolName => _$this._schoolName;
  set schoolName(String? schoolName) => _$this._schoolName = schoolName;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  CreateMySchoolCommandBuilder() {
    CreateMySchoolCommand._defaults(this);
  }

  CreateMySchoolCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _schoolName = $v.schoolName;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateMySchoolCommand other) {
    _$v = other as _$CreateMySchoolCommand;
  }

  @override
  void update(void Function(CreateMySchoolCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMySchoolCommand build() => _build();

  _$CreateMySchoolCommand _build() {
    final _$result =
        _$v ??
        _$CreateMySchoolCommand._(
          schoolName: BuiltValueNullFieldError.checkNotNull(
            schoolName,
            r'CreateMySchoolCommand',
            'schoolName',
          ),
          firstName: BuiltValueNullFieldError.checkNotNull(
            firstName,
            r'CreateMySchoolCommand',
            'firstName',
          ),
          lastName: BuiltValueNullFieldError.checkNotNull(
            lastName,
            r'CreateMySchoolCommand',
            'lastName',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
