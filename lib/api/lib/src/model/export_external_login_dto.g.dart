// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_external_login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportExternalLoginDto extends ExportExternalLoginDto {
  @override
  final String providerKey;
  @override
  final String? email;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastSignInAt;

  factory _$ExportExternalLoginDto([
    void Function(ExportExternalLoginDtoBuilder)? updates,
  ]) => (ExportExternalLoginDtoBuilder()..update(updates))._build();

  _$ExportExternalLoginDto._({
    required this.providerKey,
    this.email,
    required this.createdAt,
    this.lastSignInAt,
  }) : super._();
  @override
  ExportExternalLoginDto rebuild(
    void Function(ExportExternalLoginDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportExternalLoginDtoBuilder toBuilder() =>
      ExportExternalLoginDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportExternalLoginDto &&
        providerKey == other.providerKey &&
        email == other.email &&
        createdAt == other.createdAt &&
        lastSignInAt == other.lastSignInAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, providerKey.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastSignInAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportExternalLoginDto')
          ..add('providerKey', providerKey)
          ..add('email', email)
          ..add('createdAt', createdAt)
          ..add('lastSignInAt', lastSignInAt))
        .toString();
  }
}

class ExportExternalLoginDtoBuilder
    implements Builder<ExportExternalLoginDto, ExportExternalLoginDtoBuilder> {
  _$ExportExternalLoginDto? _$v;

  String? _providerKey;
  String? get providerKey => _$this._providerKey;
  set providerKey(String? providerKey) => _$this._providerKey = providerKey;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastSignInAt;
  DateTime? get lastSignInAt => _$this._lastSignInAt;
  set lastSignInAt(DateTime? lastSignInAt) =>
      _$this._lastSignInAt = lastSignInAt;

  ExportExternalLoginDtoBuilder() {
    ExportExternalLoginDto._defaults(this);
  }

  ExportExternalLoginDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _providerKey = $v.providerKey;
      _email = $v.email;
      _createdAt = $v.createdAt;
      _lastSignInAt = $v.lastSignInAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportExternalLoginDto other) {
    _$v = other as _$ExportExternalLoginDto;
  }

  @override
  void update(void Function(ExportExternalLoginDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportExternalLoginDto build() => _build();

  _$ExportExternalLoginDto _build() {
    final _$result =
        _$v ??
        _$ExportExternalLoginDto._(
          providerKey: BuiltValueNullFieldError.checkNotNull(
            providerKey,
            r'ExportExternalLoginDto',
            'providerKey',
          ),
          email: email,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExportExternalLoginDto',
            'createdAt',
          ),
          lastSignInAt: lastSignInAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
