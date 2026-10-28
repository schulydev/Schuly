// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stateless_refresh_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StatelessRefreshRequest extends StatelessRefreshRequest {
  @override
  final String baseUrl;
  @override
  final String userAgent;
  @override
  final JsonObject? contextState;

  factory _$StatelessRefreshRequest([
    void Function(StatelessRefreshRequestBuilder)? updates,
  ]) => (StatelessRefreshRequestBuilder()..update(updates))._build();

  _$StatelessRefreshRequest._({
    required this.baseUrl,
    required this.userAgent,
    this.contextState,
  }) : super._();
  @override
  StatelessRefreshRequest rebuild(
    void Function(StatelessRefreshRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StatelessRefreshRequestBuilder toBuilder() =>
      StatelessRefreshRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StatelessRefreshRequest &&
        baseUrl == other.baseUrl &&
        userAgent == other.userAgent &&
        contextState == other.contextState;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, baseUrl.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, contextState.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StatelessRefreshRequest')
          ..add('baseUrl', baseUrl)
          ..add('userAgent', userAgent)
          ..add('contextState', contextState))
        .toString();
  }
}

class StatelessRefreshRequestBuilder
    implements
        Builder<StatelessRefreshRequest, StatelessRefreshRequestBuilder> {
  _$StatelessRefreshRequest? _$v;

  String? _baseUrl;
  String? get baseUrl => _$this._baseUrl;
  set baseUrl(String? baseUrl) => _$this._baseUrl = baseUrl;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  JsonObject? _contextState;
  JsonObject? get contextState => _$this._contextState;
  set contextState(JsonObject? contextState) =>
      _$this._contextState = contextState;

  StatelessRefreshRequestBuilder() {
    StatelessRefreshRequest._defaults(this);
  }

  StatelessRefreshRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _baseUrl = $v.baseUrl;
      _userAgent = $v.userAgent;
      _contextState = $v.contextState;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StatelessRefreshRequest other) {
    _$v = other as _$StatelessRefreshRequest;
  }

  @override
  void update(void Function(StatelessRefreshRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StatelessRefreshRequest build() => _build();

  _$StatelessRefreshRequest _build() {
    final _$result =
        _$v ??
        _$StatelessRefreshRequest._(
          baseUrl: BuiltValueNullFieldError.checkNotNull(
            baseUrl,
            r'StatelessRefreshRequest',
            'baseUrl',
          ),
          userAgent: BuiltValueNullFieldError.checkNotNull(
            userAgent,
            r'StatelessRefreshRequest',
            'userAgent',
          ),
          contextState: contextState,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
