// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_redirect_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkRedirectDto extends LinkRedirectDto {
  @override
  final String url;
  @override
  final LinkRedirectModeDto mode;
  @override
  final String? callbackPrefix;
  @override
  final BuiltList<String> captureCookieDomains;

  factory _$LinkRedirectDto([void Function(LinkRedirectDtoBuilder)? updates]) =>
      (LinkRedirectDtoBuilder()..update(updates))._build();

  _$LinkRedirectDto._({
    required this.url,
    required this.mode,
    this.callbackPrefix,
    required this.captureCookieDomains,
  }) : super._();
  @override
  LinkRedirectDto rebuild(void Function(LinkRedirectDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkRedirectDtoBuilder toBuilder() => LinkRedirectDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkRedirectDto &&
        url == other.url &&
        mode == other.mode &&
        callbackPrefix == other.callbackPrefix &&
        captureCookieDomains == other.captureCookieDomains;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, callbackPrefix.hashCode);
    _$hash = $jc(_$hash, captureCookieDomains.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkRedirectDto')
          ..add('url', url)
          ..add('mode', mode)
          ..add('callbackPrefix', callbackPrefix)
          ..add('captureCookieDomains', captureCookieDomains))
        .toString();
  }
}

class LinkRedirectDtoBuilder
    implements Builder<LinkRedirectDto, LinkRedirectDtoBuilder> {
  _$LinkRedirectDto? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  LinkRedirectModeDto? _mode;
  LinkRedirectModeDto? get mode => _$this._mode;
  set mode(LinkRedirectModeDto? mode) => _$this._mode = mode;

  String? _callbackPrefix;
  String? get callbackPrefix => _$this._callbackPrefix;
  set callbackPrefix(String? callbackPrefix) =>
      _$this._callbackPrefix = callbackPrefix;

  ListBuilder<String>? _captureCookieDomains;
  ListBuilder<String> get captureCookieDomains =>
      _$this._captureCookieDomains ??= ListBuilder<String>();
  set captureCookieDomains(ListBuilder<String>? captureCookieDomains) =>
      _$this._captureCookieDomains = captureCookieDomains;

  LinkRedirectDtoBuilder() {
    LinkRedirectDto._defaults(this);
  }

  LinkRedirectDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _mode = $v.mode;
      _callbackPrefix = $v.callbackPrefix;
      _captureCookieDomains = $v.captureCookieDomains.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkRedirectDto other) {
    _$v = other as _$LinkRedirectDto;
  }

  @override
  void update(void Function(LinkRedirectDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkRedirectDto build() => _build();

  _$LinkRedirectDto _build() {
    _$LinkRedirectDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkRedirectDto._(
            url: BuiltValueNullFieldError.checkNotNull(
              url,
              r'LinkRedirectDto',
              'url',
            ),
            mode: BuiltValueNullFieldError.checkNotNull(
              mode,
              r'LinkRedirectDto',
              'mode',
            ),
            callbackPrefix: callbackPrefix,
            captureCookieDomains: captureCookieDomains.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'captureCookieDomains';
        captureCookieDomains.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkRedirectDto',
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
