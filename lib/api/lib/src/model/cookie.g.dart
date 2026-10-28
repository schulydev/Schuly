// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Cookie extends Cookie {
  @override
  final String domain;
  @override
  final String name;
  @override
  final String path;
  @override
  final String value;

  factory _$Cookie([void Function(CookieBuilder)? updates]) =>
      (CookieBuilder()..update(updates))._build();

  _$Cookie._({
    required this.domain,
    required this.name,
    required this.path,
    required this.value,
  }) : super._();
  @override
  Cookie rebuild(void Function(CookieBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CookieBuilder toBuilder() => CookieBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Cookie &&
        domain == other.domain &&
        name == other.name &&
        path == other.path &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, domain.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, path.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Cookie')
          ..add('domain', domain)
          ..add('name', name)
          ..add('path', path)
          ..add('value', value))
        .toString();
  }
}

class CookieBuilder implements Builder<Cookie, CookieBuilder> {
  _$Cookie? _$v;

  String? _domain;
  String? get domain => _$this._domain;
  set domain(String? domain) => _$this._domain = domain;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _path;
  String? get path => _$this._path;
  set path(String? path) => _$this._path = path;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  CookieBuilder() {
    Cookie._defaults(this);
  }

  CookieBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _domain = $v.domain;
      _name = $v.name;
      _path = $v.path;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Cookie other) {
    _$v = other as _$Cookie;
  }

  @override
  void update(void Function(CookieBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Cookie build() => _build();

  _$Cookie _build() {
    final _$result =
        _$v ??
        _$Cookie._(
          domain: BuiltValueNullFieldError.checkNotNull(
            domain,
            r'Cookie',
            'domain',
          ),
          name: BuiltValueNullFieldError.checkNotNull(name, r'Cookie', 'name'),
          path: BuiltValueNullFieldError.checkNotNull(path, r'Cookie', 'path'),
          value: BuiltValueNullFieldError.checkNotNull(
            value,
            r'Cookie',
            'value',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
