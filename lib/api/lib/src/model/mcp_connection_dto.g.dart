// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_connection_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpConnectionDto extends McpConnectionDto {
  @override
  final String id;
  @override
  final String clientName;
  @override
  final String? clientUri;
  @override
  final BuiltList<String> redirectHosts;
  @override
  final McpPermissionSet permissions;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUsedAt;

  factory _$McpConnectionDto([
    void Function(McpConnectionDtoBuilder)? updates,
  ]) => (McpConnectionDtoBuilder()..update(updates))._build();

  _$McpConnectionDto._({
    required this.id,
    required this.clientName,
    this.clientUri,
    required this.redirectHosts,
    required this.permissions,
    required this.createdAt,
    this.lastUsedAt,
  }) : super._();
  @override
  McpConnectionDto rebuild(void Function(McpConnectionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  McpConnectionDtoBuilder toBuilder() =>
      McpConnectionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpConnectionDto &&
        id == other.id &&
        clientName == other.clientName &&
        clientUri == other.clientUri &&
        redirectHosts == other.redirectHosts &&
        permissions == other.permissions &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, clientUri.hashCode);
    _$hash = $jc(_$hash, redirectHosts.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpConnectionDto')
          ..add('id', id)
          ..add('clientName', clientName)
          ..add('clientUri', clientUri)
          ..add('redirectHosts', redirectHosts)
          ..add('permissions', permissions)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class McpConnectionDtoBuilder
    implements Builder<McpConnectionDto, McpConnectionDtoBuilder> {
  _$McpConnectionDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

  String? _clientUri;
  String? get clientUri => _$this._clientUri;
  set clientUri(String? clientUri) => _$this._clientUri = clientUri;

  ListBuilder<String>? _redirectHosts;
  ListBuilder<String> get redirectHosts =>
      _$this._redirectHosts ??= ListBuilder<String>();
  set redirectHosts(ListBuilder<String>? redirectHosts) =>
      _$this._redirectHosts = redirectHosts;

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

  McpConnectionDtoBuilder() {
    McpConnectionDto._defaults(this);
  }

  McpConnectionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _clientName = $v.clientName;
      _clientUri = $v.clientUri;
      _redirectHosts = $v.redirectHosts.toBuilder();
      _permissions = $v.permissions.toBuilder();
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpConnectionDto other) {
    _$v = other as _$McpConnectionDto;
  }

  @override
  void update(void Function(McpConnectionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpConnectionDto build() => _build();

  _$McpConnectionDto _build() {
    _$McpConnectionDto _$result;
    try {
      _$result =
          _$v ??
          _$McpConnectionDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'McpConnectionDto',
              'id',
            ),
            clientName: BuiltValueNullFieldError.checkNotNull(
              clientName,
              r'McpConnectionDto',
              'clientName',
            ),
            clientUri: clientUri,
            redirectHosts: redirectHosts.build(),
            permissions: permissions.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'McpConnectionDto',
              'createdAt',
            ),
            lastUsedAt: lastUsedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'redirectHosts';
        redirectHosts.build();
        _$failedField = 'permissions';
        permissions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'McpConnectionDto',
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
