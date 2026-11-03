// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_settings_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplySettingsDto extends HelplySettingsDto {
  @override
  final McpPermissionSet permissions;
  @override
  final bool workspace;
  @override
  final bool workspaceAvailable;

  factory _$HelplySettingsDto([
    void Function(HelplySettingsDtoBuilder)? updates,
  ]) => (HelplySettingsDtoBuilder()..update(updates))._build();

  _$HelplySettingsDto._({
    required this.permissions,
    required this.workspace,
    required this.workspaceAvailable,
  }) : super._();
  @override
  HelplySettingsDto rebuild(void Function(HelplySettingsDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HelplySettingsDtoBuilder toBuilder() =>
      HelplySettingsDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplySettingsDto &&
        permissions == other.permissions &&
        workspace == other.workspace &&
        workspaceAvailable == other.workspaceAvailable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, workspace.hashCode);
    _$hash = $jc(_$hash, workspaceAvailable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplySettingsDto')
          ..add('permissions', permissions)
          ..add('workspace', workspace)
          ..add('workspaceAvailable', workspaceAvailable))
        .toString();
  }
}

class HelplySettingsDtoBuilder
    implements Builder<HelplySettingsDto, HelplySettingsDtoBuilder> {
  _$HelplySettingsDto? _$v;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  bool? _workspace;
  bool? get workspace => _$this._workspace;
  set workspace(bool? workspace) => _$this._workspace = workspace;

  bool? _workspaceAvailable;
  bool? get workspaceAvailable => _$this._workspaceAvailable;
  set workspaceAvailable(bool? workspaceAvailable) =>
      _$this._workspaceAvailable = workspaceAvailable;

  HelplySettingsDtoBuilder() {
    HelplySettingsDto._defaults(this);
  }

  HelplySettingsDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _permissions = $v.permissions.toBuilder();
      _workspace = $v.workspace;
      _workspaceAvailable = $v.workspaceAvailable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplySettingsDto other) {
    _$v = other as _$HelplySettingsDto;
  }

  @override
  void update(void Function(HelplySettingsDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplySettingsDto build() => _build();

  _$HelplySettingsDto _build() {
    _$HelplySettingsDto _$result;
    try {
      _$result =
          _$v ??
          _$HelplySettingsDto._(
            permissions: permissions.build(),
            workspace: BuiltValueNullFieldError.checkNotNull(
              workspace,
              r'HelplySettingsDto',
              'workspace',
            ),
            workspaceAvailable: BuiltValueNullFieldError.checkNotNull(
              workspaceAvailable,
              r'HelplySettingsDto',
              'workspaceAvailable',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HelplySettingsDto',
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
