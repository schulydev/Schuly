// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_api_key_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpApiKeyDto extends McpApiKeyDto {
  @override
  final String id;
  @override
  final String name;
  @override
  final String prefix;
  @override
  final McpPermissionSet permissions;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? lastUsedAt;

  factory _$McpApiKeyDto([void Function(McpApiKeyDtoBuilder)? updates]) =>
      (McpApiKeyDtoBuilder()..update(updates))._build();

  _$McpApiKeyDto._({
    required this.id,
    required this.name,
    required this.prefix,
    required this.permissions,
    required this.createdAt,
    this.expiresAt,
    this.lastUsedAt,
  }) : super._();
  @override
  McpApiKeyDto rebuild(void Function(McpApiKeyDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  McpApiKeyDtoBuilder toBuilder() => McpApiKeyDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpApiKeyDto &&
        id == other.id &&
        name == other.name &&
        prefix == other.prefix &&
        permissions == other.permissions &&
        createdAt == other.createdAt &&
        expiresAt == other.expiresAt &&
        lastUsedAt == other.lastUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, prefix.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpApiKeyDto')
          ..add('id', id)
          ..add('name', name)
          ..add('prefix', prefix)
          ..add('permissions', permissions)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class McpApiKeyDtoBuilder
    implements Builder<McpApiKeyDto, McpApiKeyDtoBuilder> {
  _$McpApiKeyDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _prefix;
  String? get prefix => _$this._prefix;
  set prefix(String? prefix) => _$this._prefix = prefix;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  McpApiKeyDtoBuilder() {
    McpApiKeyDto._defaults(this);
  }

  McpApiKeyDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _prefix = $v.prefix;
      _permissions = $v.permissions.toBuilder();
      _createdAt = $v.createdAt;
      _expiresAt = $v.expiresAt;
      _lastUsedAt = $v.lastUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpApiKeyDto other) {
    _$v = other as _$McpApiKeyDto;
  }

  @override
  void update(void Function(McpApiKeyDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpApiKeyDto build() => _build();

  _$McpApiKeyDto _build() {
    _$McpApiKeyDto _$result;
    try {
      _$result =
          _$v ??
          _$McpApiKeyDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'McpApiKeyDto',
              'id',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'McpApiKeyDto',
              'name',
            ),
            prefix: BuiltValueNullFieldError.checkNotNull(
              prefix,
              r'McpApiKeyDto',
              'prefix',
            ),
            permissions: permissions.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'McpApiKeyDto',
              'createdAt',
            ),
            expiresAt: expiresAt,
            lastUsedAt: lastUsedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'McpApiKeyDto',
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
