// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DevTokenRequest extends DevTokenRequest {
  @override
  final String? role;
  @override
  final String? sub;
  @override
  final String? name;
  @override
  final String? email;

  factory _$DevTokenRequest([void Function(DevTokenRequestBuilder)? updates]) =>
      (DevTokenRequestBuilder()..update(updates))._build();

  _$DevTokenRequest._({this.role, this.sub, this.name, this.email}) : super._();
  @override
  DevTokenRequest rebuild(void Function(DevTokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DevTokenRequestBuilder toBuilder() => DevTokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DevTokenRequest &&
        role == other.role &&
        sub == other.sub &&
        name == other.name &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, sub.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DevTokenRequest')
          ..add('role', role)
          ..add('sub', sub)
          ..add('name', name)
          ..add('email', email))
        .toString();
  }
}

class DevTokenRequestBuilder
    implements Builder<DevTokenRequest, DevTokenRequestBuilder> {
  _$DevTokenRequest? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _sub;
  String? get sub => _$this._sub;
  set sub(String? sub) => _$this._sub = sub;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DevTokenRequestBuilder() {
    DevTokenRequest._defaults(this);
  }

  DevTokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _sub = $v.sub;
      _name = $v.name;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DevTokenRequest other) {
    _$v = other as _$DevTokenRequest;
  }

  @override
  void update(void Function(DevTokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DevTokenRequest build() => _build();

  _$DevTokenRequest _build() {
    final _$result =
        _$v ??
        _$DevTokenRequest._(role: role, sub: sub, name: name, email: email);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
