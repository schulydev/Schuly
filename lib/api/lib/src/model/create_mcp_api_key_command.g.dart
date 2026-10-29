// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_mcp_api_key_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateMcpApiKeyCommand extends CreateMcpApiKeyCommand {
  @override
  final String name;
  @override
  final McpPermissionSet? permissions;
  @override
  final DateTime? expiresAt;

  factory _$CreateMcpApiKeyCommand([
    void Function(CreateMcpApiKeyCommandBuilder)? updates,
  ]) => (CreateMcpApiKeyCommandBuilder()..update(updates))._build();

  _$CreateMcpApiKeyCommand._({
    required this.name,
    this.permissions,
    this.expiresAt,
  }) : super._();
  @override
  CreateMcpApiKeyCommand rebuild(
    void Function(CreateMcpApiKeyCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateMcpApiKeyCommandBuilder toBuilder() =>
      CreateMcpApiKeyCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMcpApiKeyCommand &&
        name == other.name &&
        permissions == other.permissions &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateMcpApiKeyCommand')
          ..add('name', name)
          ..add('permissions', permissions)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class CreateMcpApiKeyCommandBuilder
    implements Builder<CreateMcpApiKeyCommand, CreateMcpApiKeyCommandBuilder> {
  _$CreateMcpApiKeyCommand? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  CreateMcpApiKeyCommandBuilder() {
    CreateMcpApiKeyCommand._defaults(this);
  }

  CreateMcpApiKeyCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _permissions = $v.permissions?.toBuilder();
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateMcpApiKeyCommand other) {
    _$v = other as _$CreateMcpApiKeyCommand;
  }

  @override
  void update(void Function(CreateMcpApiKeyCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMcpApiKeyCommand build() => _build();

  _$CreateMcpApiKeyCommand _build() {
    _$CreateMcpApiKeyCommand _$result;
    try {
      _$result =
          _$v ??
          _$CreateMcpApiKeyCommand._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'CreateMcpApiKeyCommand',
              'name',
            ),
            permissions: _permissions?.build(),
            expiresAt: expiresAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        _permissions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreateMcpApiKeyCommand',
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
