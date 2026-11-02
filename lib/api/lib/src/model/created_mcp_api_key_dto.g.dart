// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_mcp_api_key_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreatedMcpApiKeyDto extends CreatedMcpApiKeyDto {
  @override
  final McpApiKeyDto key;
  @override
  final String secret;

  factory _$CreatedMcpApiKeyDto([
    void Function(CreatedMcpApiKeyDtoBuilder)? updates,
  ]) => (CreatedMcpApiKeyDtoBuilder()..update(updates))._build();

  _$CreatedMcpApiKeyDto._({required this.key, required this.secret})
    : super._();
  @override
  CreatedMcpApiKeyDto rebuild(
    void Function(CreatedMcpApiKeyDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreatedMcpApiKeyDtoBuilder toBuilder() =>
      CreatedMcpApiKeyDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatedMcpApiKeyDto &&
        key == other.key &&
        secret == other.secret;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, secret.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreatedMcpApiKeyDto')
          ..add('key', key)
          ..add('secret', secret))
        .toString();
  }
}

class CreatedMcpApiKeyDtoBuilder
    implements Builder<CreatedMcpApiKeyDto, CreatedMcpApiKeyDtoBuilder> {
  _$CreatedMcpApiKeyDto? _$v;

  McpApiKeyDtoBuilder? _key;
  McpApiKeyDtoBuilder get key => _$this._key ??= McpApiKeyDtoBuilder();
  set key(McpApiKeyDtoBuilder? key) => _$this._key = key;

  String? _secret;
  String? get secret => _$this._secret;
  set secret(String? secret) => _$this._secret = secret;

  CreatedMcpApiKeyDtoBuilder() {
    CreatedMcpApiKeyDto._defaults(this);
  }

  CreatedMcpApiKeyDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key.toBuilder();
      _secret = $v.secret;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreatedMcpApiKeyDto other) {
    _$v = other as _$CreatedMcpApiKeyDto;
  }

  @override
  void update(void Function(CreatedMcpApiKeyDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatedMcpApiKeyDto build() => _build();

  _$CreatedMcpApiKeyDto _build() {
    _$CreatedMcpApiKeyDto _$result;
    try {
      _$result =
          _$v ??
          _$CreatedMcpApiKeyDto._(
            key: key.build(),
            secret: BuiltValueNullFieldError.checkNotNull(
              secret,
              r'CreatedMcpApiKeyDto',
              'secret',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'key';
        key.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CreatedMcpApiKeyDto',
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
