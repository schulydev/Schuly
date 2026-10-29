// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_activity_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpActivityDto extends McpActivityDto {
  @override
  final String toolName;
  @override
  final bool allowed;
  @override
  final DateTime at;

  factory _$McpActivityDto([void Function(McpActivityDtoBuilder)? updates]) =>
      (McpActivityDtoBuilder()..update(updates))._build();

  _$McpActivityDto._({
    required this.toolName,
    required this.allowed,
    required this.at,
  }) : super._();
  @override
  McpActivityDto rebuild(void Function(McpActivityDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  McpActivityDtoBuilder toBuilder() => McpActivityDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpActivityDto &&
        toolName == other.toolName &&
        allowed == other.allowed &&
        at == other.at;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, toolName.hashCode);
    _$hash = $jc(_$hash, allowed.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpActivityDto')
          ..add('toolName', toolName)
          ..add('allowed', allowed)
          ..add('at', at))
        .toString();
  }
}

class McpActivityDtoBuilder
    implements Builder<McpActivityDto, McpActivityDtoBuilder> {
  _$McpActivityDto? _$v;

  String? _toolName;
  String? get toolName => _$this._toolName;
  set toolName(String? toolName) => _$this._toolName = toolName;

  bool? _allowed;
  bool? get allowed => _$this._allowed;
  set allowed(bool? allowed) => _$this._allowed = allowed;

  DateTime? _at;
  DateTime? get at => _$this._at;
  set at(DateTime? at) => _$this._at = at;

  McpActivityDtoBuilder() {
    McpActivityDto._defaults(this);
  }

  McpActivityDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _toolName = $v.toolName;
      _allowed = $v.allowed;
      _at = $v.at;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpActivityDto other) {
    _$v = other as _$McpActivityDto;
  }

  @override
  void update(void Function(McpActivityDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpActivityDto build() => _build();

  _$McpActivityDto _build() {
    final _$result =
        _$v ??
        _$McpActivityDto._(
          toolName: BuiltValueNullFieldError.checkNotNull(
            toolName,
            r'McpActivityDto',
            'toolName',
          ),
          allowed: BuiltValueNullFieldError.checkNotNull(
            allowed,
            r'McpActivityDto',
            'allowed',
          ),
          at: BuiltValueNullFieldError.checkNotNull(
            at,
            r'McpActivityDto',
            'at',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
