// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_authorization_parameters.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpAuthorizationParameters extends McpAuthorizationParameters {
  @override
  final String? responseType;
  @override
  final String? clientId;
  @override
  final String? redirectUri;
  @override
  final String? scope;
  @override
  final String? state;
  @override
  final String? codeChallenge;
  @override
  final String? codeChallengeMethod;
  @override
  final String? resource;

  factory _$McpAuthorizationParameters([
    void Function(McpAuthorizationParametersBuilder)? updates,
  ]) => (McpAuthorizationParametersBuilder()..update(updates))._build();

  _$McpAuthorizationParameters._({
    this.responseType,
    this.clientId,
    this.redirectUri,
    this.scope,
    this.state,
    this.codeChallenge,
    this.codeChallengeMethod,
    this.resource,
  }) : super._();
  @override
  McpAuthorizationParameters rebuild(
    void Function(McpAuthorizationParametersBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  McpAuthorizationParametersBuilder toBuilder() =>
      McpAuthorizationParametersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpAuthorizationParameters &&
        responseType == other.responseType &&
        clientId == other.clientId &&
        redirectUri == other.redirectUri &&
        scope == other.scope &&
        state == other.state &&
        codeChallenge == other.codeChallenge &&
        codeChallengeMethod == other.codeChallengeMethod &&
        resource == other.resource;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, responseType.hashCode);
    _$hash = $jc(_$hash, clientId.hashCode);
    _$hash = $jc(_$hash, redirectUri.hashCode);
    _$hash = $jc(_$hash, scope.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, codeChallenge.hashCode);
    _$hash = $jc(_$hash, codeChallengeMethod.hashCode);
    _$hash = $jc(_$hash, resource.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpAuthorizationParameters')
          ..add('responseType', responseType)
          ..add('clientId', clientId)
          ..add('redirectUri', redirectUri)
          ..add('scope', scope)
          ..add('state', state)
          ..add('codeChallenge', codeChallenge)
          ..add('codeChallengeMethod', codeChallengeMethod)
          ..add('resource', resource))
        .toString();
  }
}

class McpAuthorizationParametersBuilder
    implements
        Builder<McpAuthorizationParameters, McpAuthorizationParametersBuilder> {
  _$McpAuthorizationParameters? _$v;

  String? _responseType;
  String? get responseType => _$this._responseType;
  set responseType(String? responseType) => _$this._responseType = responseType;

  String? _clientId;
  String? get clientId => _$this._clientId;
  set clientId(String? clientId) => _$this._clientId = clientId;

  String? _redirectUri;
  String? get redirectUri => _$this._redirectUri;
  set redirectUri(String? redirectUri) => _$this._redirectUri = redirectUri;

  String? _scope;
  String? get scope => _$this._scope;
  set scope(String? scope) => _$this._scope = scope;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _codeChallenge;
  String? get codeChallenge => _$this._codeChallenge;
  set codeChallenge(String? codeChallenge) =>
      _$this._codeChallenge = codeChallenge;

  String? _codeChallengeMethod;
  String? get codeChallengeMethod => _$this._codeChallengeMethod;
  set codeChallengeMethod(String? codeChallengeMethod) =>
      _$this._codeChallengeMethod = codeChallengeMethod;

  String? _resource;
  String? get resource => _$this._resource;
  set resource(String? resource) => _$this._resource = resource;

  McpAuthorizationParametersBuilder() {
    McpAuthorizationParameters._defaults(this);
  }

  McpAuthorizationParametersBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _responseType = $v.responseType;
      _clientId = $v.clientId;
      _redirectUri = $v.redirectUri;
      _scope = $v.scope;
      _state = $v.state;
      _codeChallenge = $v.codeChallenge;
      _codeChallengeMethod = $v.codeChallengeMethod;
      _resource = $v.resource;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpAuthorizationParameters other) {
    _$v = other as _$McpAuthorizationParameters;
  }

  @override
  void update(void Function(McpAuthorizationParametersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpAuthorizationParameters build() => _build();

  _$McpAuthorizationParameters _build() {
    final _$result =
        _$v ??
        _$McpAuthorizationParameters._(
          responseType: responseType,
          clientId: clientId,
          redirectUri: redirectUri,
          scope: scope,
          state: state,
          codeChallenge: codeChallenge,
          codeChallengeMethod: codeChallengeMethod,
          resource: resource,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
