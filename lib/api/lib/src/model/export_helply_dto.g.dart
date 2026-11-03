// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_helply_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportHelplyDto extends ExportHelplyDto {
  @override
  final McpPermissionSet permissions;
  @override
  final bool workspaceEnabled;
  @override
  final BuiltList<ExportHelplyConversationDto> conversations;

  factory _$ExportHelplyDto([void Function(ExportHelplyDtoBuilder)? updates]) =>
      (ExportHelplyDtoBuilder()..update(updates))._build();

  _$ExportHelplyDto._({
    required this.permissions,
    required this.workspaceEnabled,
    required this.conversations,
  }) : super._();
  @override
  ExportHelplyDto rebuild(void Function(ExportHelplyDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportHelplyDtoBuilder toBuilder() => ExportHelplyDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportHelplyDto &&
        permissions == other.permissions &&
        workspaceEnabled == other.workspaceEnabled &&
        conversations == other.conversations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, workspaceEnabled.hashCode);
    _$hash = $jc(_$hash, conversations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportHelplyDto')
          ..add('permissions', permissions)
          ..add('workspaceEnabled', workspaceEnabled)
          ..add('conversations', conversations))
        .toString();
  }
}

class ExportHelplyDtoBuilder
    implements Builder<ExportHelplyDto, ExportHelplyDtoBuilder> {
  _$ExportHelplyDto? _$v;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  bool? _workspaceEnabled;
  bool? get workspaceEnabled => _$this._workspaceEnabled;
  set workspaceEnabled(bool? workspaceEnabled) =>
      _$this._workspaceEnabled = workspaceEnabled;

  ListBuilder<ExportHelplyConversationDto>? _conversations;
  ListBuilder<ExportHelplyConversationDto> get conversations =>
      _$this._conversations ??= ListBuilder<ExportHelplyConversationDto>();
  set conversations(ListBuilder<ExportHelplyConversationDto>? conversations) =>
      _$this._conversations = conversations;

  ExportHelplyDtoBuilder() {
    ExportHelplyDto._defaults(this);
  }

  ExportHelplyDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _permissions = $v.permissions.toBuilder();
      _workspaceEnabled = $v.workspaceEnabled;
      _conversations = $v.conversations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportHelplyDto other) {
    _$v = other as _$ExportHelplyDto;
  }

  @override
  void update(void Function(ExportHelplyDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportHelplyDto build() => _build();

  _$ExportHelplyDto _build() {
    _$ExportHelplyDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportHelplyDto._(
            permissions: permissions.build(),
            workspaceEnabled: BuiltValueNullFieldError.checkNotNull(
              workspaceEnabled,
              r'ExportHelplyDto',
              'workspaceEnabled',
            ),
            conversations: conversations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();

        _$failedField = 'conversations';
        conversations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportHelplyDto',
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
