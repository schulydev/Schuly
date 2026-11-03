// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_ai_app_connection_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportAiAppConnectionDto extends ExportAiAppConnectionDto {
  @override
  final String clientName;
  @override
  final String? clientUri;
  @override
  final McpPermissionSet permissions;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUsedAt;

  factory _$ExportAiAppConnectionDto([
    void Function(ExportAiAppConnectionDtoBuilder)? updates,
  ]) => (ExportAiAppConnectionDtoBuilder()..update(updates))._build();

  _$ExportAiAppConnectionDto._({
    required this.clientName,
    this.clientUri,
    required this.permissions,
    required this.createdAt,
    this.lastUsedAt,
  }) : super._();
  @override
  ExportAiAppConnectionDto rebuild(
    void Function(ExportAiAppConnectionDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportAiAppConnectionDtoBuilder toBuilder() =>
      ExportAiAppConnectionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportAiAppConnectionDto &&
        clientName == other.clientName &&
        clientUri == other.clientUri &&
        permissions == other.permissions &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, clientUri.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportAiAppConnectionDto')
          ..add('clientName', clientName)
          ..add('clientUri', clientUri)
          ..add('permissions', permissions)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class ExportAiAppConnectionDtoBuilder
    implements
        Builder<ExportAiAppConnectionDto, ExportAiAppConnectionDtoBuilder> {
  _$ExportAiAppConnectionDto? _$v;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

  String? _clientUri;
  String? get clientUri => _$this._clientUri;
  set clientUri(String? clientUri) => _$this._clientUri = clientUri;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  ExportAiAppConnectionDtoBuilder() {
    ExportAiAppConnectionDto._defaults(this);
  }

  ExportAiAppConnectionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientName = $v.clientName;
      _clientUri = $v.clientUri;
      _permissions = $v.permissions.toBuilder();
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportAiAppConnectionDto other) {
    _$v = other as _$ExportAiAppConnectionDto;
  }

  @override
  void update(void Function(ExportAiAppConnectionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportAiAppConnectionDto build() => _build();

  _$ExportAiAppConnectionDto _build() {
    _$ExportAiAppConnectionDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportAiAppConnectionDto._(
            clientName: BuiltValueNullFieldError.checkNotNull(
              clientName,
              r'ExportAiAppConnectionDto',
              'clientName',
            ),
            clientUri: clientUri,
            permissions: permissions.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'ExportAiAppConnectionDto',
              'createdAt',
            ),
            lastUsedAt: lastUsedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportAiAppConnectionDto',
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
