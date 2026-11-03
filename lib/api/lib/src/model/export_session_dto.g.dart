// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_session_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportSessionDto extends ExportSessionDto {
  @override
  final String? label;
  @override
  final String? ipAddress;
  @override
  final String? userAgent;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastUsedAt;

  factory _$ExportSessionDto([
    void Function(ExportSessionDtoBuilder)? updates,
  ]) => (ExportSessionDtoBuilder()..update(updates))._build();

  _$ExportSessionDto._({
    this.label,
    this.ipAddress,
    this.userAgent,
    required this.createdAt,
    required this.lastUsedAt,
  }) : super._();
  @override
  ExportSessionDto rebuild(void Function(ExportSessionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportSessionDtoBuilder toBuilder() =>
      ExportSessionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportSessionDto &&
        label == other.label &&
        ipAddress == other.ipAddress &&
        userAgent == other.userAgent &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportSessionDto')
          ..add('label', label)
          ..add('ipAddress', ipAddress)
          ..add('userAgent', userAgent)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class ExportSessionDtoBuilder
    implements Builder<ExportSessionDto, ExportSessionDtoBuilder> {
  _$ExportSessionDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  ExportSessionDtoBuilder() {
    ExportSessionDto._defaults(this);
  }

  ExportSessionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _ipAddress = $v.ipAddress;
      _userAgent = $v.userAgent;
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportSessionDto other) {
    _$v = other as _$ExportSessionDto;
  }

  @override
  void update(void Function(ExportSessionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportSessionDto build() => _build();

  _$ExportSessionDto _build() {
    final _$result =
        _$v ??
        _$ExportSessionDto._(
          label: label,
          ipAddress: ipAddress,
          userAgent: userAgent,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExportSessionDto',
            'createdAt',
          ),
          lastUsedAt: BuiltValueNullFieldError.checkNotNull(
            lastUsedAt,
            r'ExportSessionDto',
            'lastUsedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
