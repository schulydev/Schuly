// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_provider_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExternalProviderResponse extends ExternalProviderResponse {
  @override
  final String key;
  @override
  final String displayName;
  @override
  final String? iconUrl;

  factory _$ExternalProviderResponse([
    void Function(ExternalProviderResponseBuilder)? updates,
  ]) => (ExternalProviderResponseBuilder()..update(updates))._build();

  _$ExternalProviderResponse._({
    required this.key,
    required this.displayName,
    this.iconUrl,
  }) : super._();
  @override
  ExternalProviderResponse rebuild(
    void Function(ExternalProviderResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExternalProviderResponseBuilder toBuilder() =>
      ExternalProviderResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExternalProviderResponse &&
        key == other.key &&
        displayName == other.displayName &&
        iconUrl == other.iconUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, iconUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExternalProviderResponse')
          ..add('key', key)
          ..add('displayName', displayName)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class ExternalProviderResponseBuilder
    implements
        Builder<ExternalProviderResponse, ExternalProviderResponseBuilder> {
  _$ExternalProviderResponse? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _iconUrl;
  String? get iconUrl => _$this._iconUrl;
  set iconUrl(String? iconUrl) => _$this._iconUrl = iconUrl;

  ExternalProviderResponseBuilder() {
    ExternalProviderResponse._defaults(this);
  }

  ExternalProviderResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _displayName = $v.displayName;
      _iconUrl = $v.iconUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExternalProviderResponse other) {
    _$v = other as _$ExternalProviderResponse;
  }

  @override
  void update(void Function(ExternalProviderResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExternalProviderResponse build() => _build();

  _$ExternalProviderResponse _build() {
    final _$result =
        _$v ??
        _$ExternalProviderResponse._(
          key: BuiltValueNullFieldError.checkNotNull(
            key,
            r'ExternalProviderResponse',
            'key',
          ),
          displayName: BuiltValueNullFieldError.checkNotNull(
            displayName,
            r'ExternalProviderResponse',
            'displayName',
          ),
          iconUrl: iconUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
