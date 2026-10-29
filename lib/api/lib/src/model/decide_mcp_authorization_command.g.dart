// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decide_mcp_authorization_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DecideMcpAuthorizationCommand extends DecideMcpAuthorizationCommand {
  @override
  final McpAuthorizationParameters parameters;
  @override
  final bool approve;
  @override
  final McpPermissionSet? permissions;

  factory _$DecideMcpAuthorizationCommand([
    void Function(DecideMcpAuthorizationCommandBuilder)? updates,
  ]) => (DecideMcpAuthorizationCommandBuilder()..update(updates))._build();

  _$DecideMcpAuthorizationCommand._({
    required this.parameters,
    required this.approve,
    this.permissions,
  }) : super._();
  @override
  DecideMcpAuthorizationCommand rebuild(
    void Function(DecideMcpAuthorizationCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DecideMcpAuthorizationCommandBuilder toBuilder() =>
      DecideMcpAuthorizationCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DecideMcpAuthorizationCommand &&
        parameters == other.parameters &&
        approve == other.approve &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, parameters.hashCode);
    _$hash = $jc(_$hash, approve.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DecideMcpAuthorizationCommand')
          ..add('parameters', parameters)
          ..add('approve', approve)
          ..add('permissions', permissions))
        .toString();
  }
}

class DecideMcpAuthorizationCommandBuilder
    implements
        Builder<
          DecideMcpAuthorizationCommand,
          DecideMcpAuthorizationCommandBuilder
        > {
  _$DecideMcpAuthorizationCommand? _$v;

  McpAuthorizationParametersBuilder? _parameters;
  McpAuthorizationParametersBuilder get parameters =>
      _$this._parameters ??= McpAuthorizationParametersBuilder();
  set parameters(McpAuthorizationParametersBuilder? parameters) =>
      _$this._parameters = parameters;

  bool? _approve;
  bool? get approve => _$this._approve;
  set approve(bool? approve) => _$this._approve = approve;

  McpPermissionSetBuilder? _permissions;
  McpPermissionSetBuilder get permissions =>
      _$this._permissions ??= McpPermissionSetBuilder();
  set permissions(McpPermissionSetBuilder? permissions) =>
      _$this._permissions = permissions;

  DecideMcpAuthorizationCommandBuilder() {
    DecideMcpAuthorizationCommand._defaults(this);
  }

  DecideMcpAuthorizationCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _parameters = $v.parameters.toBuilder();
      _approve = $v.approve;
      _permissions = $v.permissions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DecideMcpAuthorizationCommand other) {
    _$v = other as _$DecideMcpAuthorizationCommand;
  }

  @override
  void update(void Function(DecideMcpAuthorizationCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DecideMcpAuthorizationCommand build() => _build();

  _$DecideMcpAuthorizationCommand _build() {
    _$DecideMcpAuthorizationCommand _$result;
    try {
      _$result =
          _$v ??
          _$DecideMcpAuthorizationCommand._(
            parameters: parameters.build(),
            approve: BuiltValueNullFieldError.checkNotNull(
              approve,
              r'DecideMcpAuthorizationCommand',
              'approve',
            ),
            permissions: _permissions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'parameters';
        parameters.build();

        _$failedField = 'permissions';
        _permissions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'DecideMcpAuthorizationCommand',
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
