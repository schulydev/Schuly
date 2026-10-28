// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_user_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessUserInfo extends OdaorgStatelessUserInfo {
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? birthday;

  factory _$OdaorgStatelessUserInfo([
    void Function(OdaorgStatelessUserInfoBuilder)? updates,
  ]) => (OdaorgStatelessUserInfoBuilder()..update(updates))._build();

  _$OdaorgStatelessUserInfo._({
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
  }) : super._();
  @override
  OdaorgStatelessUserInfo rebuild(
    void Function(OdaorgStatelessUserInfoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessUserInfoBuilder toBuilder() =>
      OdaorgStatelessUserInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessUserInfo &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        email == other.email &&
        birthday == other.birthday;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, birthday.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessUserInfo')
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('email', email)
          ..add('birthday', birthday))
        .toString();
  }
}

class OdaorgStatelessUserInfoBuilder
    implements
        Builder<OdaorgStatelessUserInfo, OdaorgStatelessUserInfoBuilder> {
  _$OdaorgStatelessUserInfo? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _birthday;
  String? get birthday => _$this._birthday;
  set birthday(String? birthday) => _$this._birthday = birthday;

  OdaorgStatelessUserInfoBuilder() {
    OdaorgStatelessUserInfo._defaults(this);
  }

  OdaorgStatelessUserInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _email = $v.email;
      _birthday = $v.birthday;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessUserInfo other) {
    _$v = other as _$OdaorgStatelessUserInfo;
  }

  @override
  void update(void Function(OdaorgStatelessUserInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessUserInfo build() => _build();

  _$OdaorgStatelessUserInfo _build() {
    final _$result =
        _$v ??
        _$OdaorgStatelessUserInfo._(
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthday: birthday,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
