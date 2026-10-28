// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_link_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExternalLinkResponse extends ExternalLinkResponse {
  @override
  final String authorizationUrl;

  factory _$ExternalLinkResponse([
    void Function(ExternalLinkResponseBuilder)? updates,
  ]) => (ExternalLinkResponseBuilder()..update(updates))._build();

  _$ExternalLinkResponse._({required this.authorizationUrl}) : super._();
  @override
  ExternalLinkResponse rebuild(
    void Function(ExternalLinkResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExternalLinkResponseBuilder toBuilder() =>
      ExternalLinkResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExternalLinkResponse &&
        authorizationUrl == other.authorizationUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, authorizationUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ExternalLinkResponse',
    )..add('authorizationUrl', authorizationUrl)).toString();
  }
}

class ExternalLinkResponseBuilder
    implements Builder<ExternalLinkResponse, ExternalLinkResponseBuilder> {
  _$ExternalLinkResponse? _$v;

  String? _authorizationUrl;
  String? get authorizationUrl => _$this._authorizationUrl;
  set authorizationUrl(String? authorizationUrl) =>
      _$this._authorizationUrl = authorizationUrl;

  ExternalLinkResponseBuilder() {
    ExternalLinkResponse._defaults(this);
  }

  ExternalLinkResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _authorizationUrl = $v.authorizationUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExternalLinkResponse other) {
    _$v = other as _$ExternalLinkResponse;
  }

  @override
  void update(void Function(ExternalLinkResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExternalLinkResponse build() => _build();

  _$ExternalLinkResponse _build() {
    final _$result =
        _$v ??
        _$ExternalLinkResponse._(
          authorizationUrl: BuiltValueNullFieldError.checkNotNull(
            authorizationUrl,
            r'ExternalLinkResponse',
            'authorizationUrl',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
