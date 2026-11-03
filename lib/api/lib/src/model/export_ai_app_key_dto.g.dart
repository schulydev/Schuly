// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_ai_app_key_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportAiAppKeyDto extends ExportAiAppKeyDto {
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

  factory _$ExportAiAppKeyDto([
    void Function(ExportAiAppKeyDtoBuilder)? updates,
  ]) => (ExportAiAppKeyDtoBuilder()..update(updates))._build();

  _$ExportAiAppKeyDto._({
    required this.name,
    required this.prefix,
    required this.permissions,
    required this.createdAt,
    this.expiresAt,
    this.lastUsedAt,
  }) : super._();
  @override
  ExportAiAppKeyDto rebuild(void Function(ExportAiAppKeyDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportAiAppKeyDtoBuilder toBuilder() =>
      ExportAiAppKeyDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportAiAppKeyDto &&
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
    return (newBuiltValueToStringHelper(r'ExportAiAppKeyDto')
          ..add('name', name)
          ..add('prefix', prefix)
          ..add('permissions', permissions)
          ..add('createdAt', createdAt)
          ..add('expiresAt', expiresAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class ExportAiAppKeyDtoBuilder
    implements Builder<ExportAiAppKeyDto, ExportAiAppKeyDtoBuilder> {
  _$ExportAiAppKeyDto? _$v;

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

  ExportAiAppKeyDtoBuilder() {
    ExportAiAppKeyDto._defaults(this);
  }

  ExportAiAppKeyDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(ExportAiAppKeyDto other) {
    _$v = other as _$ExportAiAppKeyDto;
  }

  @override
  void update(void Function(ExportAiAppKeyDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportAiAppKeyDto build() => _build();

  _$ExportAiAppKeyDto _build() {
    _$ExportAiAppKeyDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportAiAppKeyDto._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'ExportAiAppKeyDto',
              'name',
            ),
            prefix: BuiltValueNullFieldError.checkNotNull(
              prefix,
              r'ExportAiAppKeyDto',
              'prefix',
            ),
            permissions: permissions.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'ExportAiAppKeyDto',
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
          r'ExportAiAppKeyDto',
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
