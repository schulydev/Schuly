// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_authorization_request_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpAuthorizationRequestDto extends McpAuthorizationRequestDto {
  @override
  final bool valid;
  @override
  final String? error;
  @override
  final String? errorDescription;
  @override
  final String? clientName;
  @override
  final String? clientUri;
  @override
  final String? redirectHost;
  @override
  final McpPermissionSet requested;
  @override
  final String? redirectUrl;

  factory _$McpAuthorizationRequestDto([
    void Function(McpAuthorizationRequestDtoBuilder)? updates,
  ]) => (McpAuthorizationRequestDtoBuilder()..update(updates))._build();

  _$McpAuthorizationRequestDto._({
    required this.valid,
    this.error,
    this.errorDescription,
    this.clientName,
    this.clientUri,
    this.redirectHost,
    required this.requested,
    this.redirectUrl,
  }) : super._();
  @override
  McpAuthorizationRequestDto rebuild(
    void Function(McpAuthorizationRequestDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  McpAuthorizationRequestDtoBuilder toBuilder() =>
      McpAuthorizationRequestDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpAuthorizationRequestDto &&
        valid == other.valid &&
        error == other.error &&
        errorDescription == other.errorDescription &&
        clientName == other.clientName &&
        clientUri == other.clientUri &&
        redirectHost == other.redirectHost &&
        requested == other.requested &&
        redirectUrl == other.redirectUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, valid.hashCode);
    _$hash = $jc(_$hash, error.hashCode);
    _$hash = $jc(_$hash, errorDescription.hashCode);
    _$hash = $jc(_$hash, clientName.hashCode);
    _$hash = $jc(_$hash, clientUri.hashCode);
    _$hash = $jc(_$hash, redirectHost.hashCode);
    _$hash = $jc(_$hash, requested.hashCode);
    _$hash = $jc(_$hash, redirectUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpAuthorizationRequestDto')
          ..add('valid', valid)
          ..add('error', error)
          ..add('errorDescription', errorDescription)
          ..add('clientName', clientName)
          ..add('clientUri', clientUri)
          ..add('redirectHost', redirectHost)
          ..add('requested', requested)
          ..add('redirectUrl', redirectUrl))
        .toString();
  }
}

class McpAuthorizationRequestDtoBuilder
    implements
        Builder<McpAuthorizationRequestDto, McpAuthorizationRequestDtoBuilder> {
  _$McpAuthorizationRequestDto? _$v;

  bool? _valid;
  bool? get valid => _$this._valid;
  set valid(bool? valid) => _$this._valid = valid;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  String? _errorDescription;
  String? get errorDescription => _$this._errorDescription;
  set errorDescription(String? errorDescription) =>
      _$this._errorDescription = errorDescription;

  String? _clientName;
  String? get clientName => _$this._clientName;
  set clientName(String? clientName) => _$this._clientName = clientName;

  String? _clientUri;
  String? get clientUri => _$this._clientUri;
  set clientUri(String? clientUri) => _$this._clientUri = clientUri;

  String? _redirectHost;
  String? get redirectHost => _$this._redirectHost;
  set redirectHost(String? redirectHost) => _$this._redirectHost = redirectHost;

  McpPermissionSetBuilder? _requested;
  McpPermissionSetBuilder get requested =>
      _$this._requested ??= McpPermissionSetBuilder();
  set requested(McpPermissionSetBuilder? requested) =>
      _$this._requested = requested;

  String? _redirectUrl;
  String? get redirectUrl => _$this._redirectUrl;
  set redirectUrl(String? redirectUrl) => _$this._redirectUrl = redirectUrl;

  McpAuthorizationRequestDtoBuilder() {
    McpAuthorizationRequestDto._defaults(this);
  }

  McpAuthorizationRequestDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _valid = $v.valid;
      _error = $v.error;
      _errorDescription = $v.errorDescription;
      _clientName = $v.clientName;
      _clientUri = $v.clientUri;
      _redirectHost = $v.redirectHost;
      _requested = $v.requested.toBuilder();
      _redirectUrl = $v.redirectUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpAuthorizationRequestDto other) {
    _$v = other as _$McpAuthorizationRequestDto;
  }

  @override
  void update(void Function(McpAuthorizationRequestDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpAuthorizationRequestDto build() => _build();

  _$McpAuthorizationRequestDto _build() {
    _$McpAuthorizationRequestDto _$result;
    try {
      _$result =
          _$v ??
          _$McpAuthorizationRequestDto._(
            valid: BuiltValueNullFieldError.checkNotNull(
              valid,
              r'McpAuthorizationRequestDto',
              'valid',
            ),
            error: error,
            errorDescription: errorDescription,
            clientName: clientName,
            clientUri: clientUri,
            redirectHost: redirectHost,
            requested: requested.build(),
            redirectUrl: redirectUrl,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'requested';
        requested.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'McpAuthorizationRequestDto',
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
