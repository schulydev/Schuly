// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_authorization_decision_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpAuthorizationDecisionDto extends McpAuthorizationDecisionDto {
  @override
  final String redirectUrl;

  factory _$McpAuthorizationDecisionDto([
    void Function(McpAuthorizationDecisionDtoBuilder)? updates,
  ]) => (McpAuthorizationDecisionDtoBuilder()..update(updates))._build();

  _$McpAuthorizationDecisionDto._({required this.redirectUrl}) : super._();
  @override
  McpAuthorizationDecisionDto rebuild(
    void Function(McpAuthorizationDecisionDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  McpAuthorizationDecisionDtoBuilder toBuilder() =>
      McpAuthorizationDecisionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpAuthorizationDecisionDto &&
        redirectUrl == other.redirectUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, redirectUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'McpAuthorizationDecisionDto',
    )..add('redirectUrl', redirectUrl)).toString();
  }
}

class McpAuthorizationDecisionDtoBuilder
    implements
        Builder<
          McpAuthorizationDecisionDto,
          McpAuthorizationDecisionDtoBuilder
        > {
  _$McpAuthorizationDecisionDto? _$v;

  String? _redirectUrl;
  String? get redirectUrl => _$this._redirectUrl;
  set redirectUrl(String? redirectUrl) => _$this._redirectUrl = redirectUrl;

  McpAuthorizationDecisionDtoBuilder() {
    McpAuthorizationDecisionDto._defaults(this);
  }

  McpAuthorizationDecisionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _redirectUrl = $v.redirectUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpAuthorizationDecisionDto other) {
    _$v = other as _$McpAuthorizationDecisionDto;
  }

  @override
  void update(void Function(McpAuthorizationDecisionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpAuthorizationDecisionDto build() => _build();

  _$McpAuthorizationDecisionDto _build() {
    final _$result =
        _$v ??
        _$McpAuthorizationDecisionDto._(
          redirectUrl: BuiltValueNullFieldError.checkNotNull(
            redirectUrl,
            r'McpAuthorizationDecisionDto',
            'redirectUrl',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
