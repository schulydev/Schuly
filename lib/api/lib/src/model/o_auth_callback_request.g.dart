// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_callback_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OAuthCallbackRequest extends OAuthCallbackRequest {
  @override
  final String code;
  @override
  final String codeVerifier;
  @override
  final String? state;
  @override
  final String? contextState;
  @override
  final String? userAgent;
  @override
  final String? webSessionId;
  @override
  final String? webSessionUserId;
  @override
  final String? webSessionTransId;

  factory _$OAuthCallbackRequest([
    void Function(OAuthCallbackRequestBuilder)? updates,
  ]) => (OAuthCallbackRequestBuilder()..update(updates))._build();

  _$OAuthCallbackRequest._({
    required this.code,
    required this.codeVerifier,
    this.state,
    this.contextState,
    this.userAgent,
    this.webSessionId,
    this.webSessionUserId,
    this.webSessionTransId,
  }) : super._();
  @override
  OAuthCallbackRequest rebuild(
    void Function(OAuthCallbackRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OAuthCallbackRequestBuilder toBuilder() =>
      OAuthCallbackRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OAuthCallbackRequest &&
        code == other.code &&
        codeVerifier == other.codeVerifier &&
        state == other.state &&
        contextState == other.contextState &&
        userAgent == other.userAgent &&
        webSessionId == other.webSessionId &&
        webSessionUserId == other.webSessionUserId &&
        webSessionTransId == other.webSessionTransId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, codeVerifier.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, contextState.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, webSessionId.hashCode);
    _$hash = $jc(_$hash, webSessionUserId.hashCode);
    _$hash = $jc(_$hash, webSessionTransId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OAuthCallbackRequest')
          ..add('code', code)
          ..add('codeVerifier', codeVerifier)
          ..add('state', state)
          ..add('contextState', contextState)
          ..add('userAgent', userAgent)
          ..add('webSessionId', webSessionId)
          ..add('webSessionUserId', webSessionUserId)
          ..add('webSessionTransId', webSessionTransId))
        .toString();
  }
}

class OAuthCallbackRequestBuilder
    implements Builder<OAuthCallbackRequest, OAuthCallbackRequestBuilder> {
  _$OAuthCallbackRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _codeVerifier;
  String? get codeVerifier => _$this._codeVerifier;
  set codeVerifier(String? codeVerifier) => _$this._codeVerifier = codeVerifier;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _contextState;
  String? get contextState => _$this._contextState;
  set contextState(String? contextState) => _$this._contextState = contextState;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  String? _webSessionId;
  String? get webSessionId => _$this._webSessionId;
  set webSessionId(String? webSessionId) => _$this._webSessionId = webSessionId;

  String? _webSessionUserId;
  String? get webSessionUserId => _$this._webSessionUserId;
  set webSessionUserId(String? webSessionUserId) =>
      _$this._webSessionUserId = webSessionUserId;

  String? _webSessionTransId;
  String? get webSessionTransId => _$this._webSessionTransId;
  set webSessionTransId(String? webSessionTransId) =>
      _$this._webSessionTransId = webSessionTransId;

  OAuthCallbackRequestBuilder() {
    OAuthCallbackRequest._defaults(this);
  }

  OAuthCallbackRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _codeVerifier = $v.codeVerifier;
      _state = $v.state;
      _contextState = $v.contextState;
      _userAgent = $v.userAgent;
      _webSessionId = $v.webSessionId;
      _webSessionUserId = $v.webSessionUserId;
      _webSessionTransId = $v.webSessionTransId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OAuthCallbackRequest other) {
    _$v = other as _$OAuthCallbackRequest;
  }

  @override
  void update(void Function(OAuthCallbackRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OAuthCallbackRequest build() => _build();

  _$OAuthCallbackRequest _build() {
    final _$result =
        _$v ??
        _$OAuthCallbackRequest._(
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'OAuthCallbackRequest',
            'code',
          ),
          codeVerifier: BuiltValueNullFieldError.checkNotNull(
            codeVerifier,
            r'OAuthCallbackRequest',
            'codeVerifier',
          ),
          state: state,
          contextState: contextState,
          userAgent: userAgent,
          webSessionId: webSessionId,
          webSessionUserId: webSessionUserId,
          webSessionTransId: webSessionTransId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
