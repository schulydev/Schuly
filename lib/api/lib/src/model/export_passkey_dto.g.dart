// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_passkey_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportPasskeyDto extends ExportPasskeyDto {
  @override
  final String? label;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastUsedAt;

  factory _$ExportPasskeyDto([
    void Function(ExportPasskeyDtoBuilder)? updates,
  ]) => (ExportPasskeyDtoBuilder()..update(updates))._build();

  _$ExportPasskeyDto._({this.label, required this.createdAt, this.lastUsedAt})
    : super._();
  @override
  ExportPasskeyDto rebuild(void Function(ExportPasskeyDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportPasskeyDtoBuilder toBuilder() =>
      ExportPasskeyDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportPasskeyDto &&
        label == other.label &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportPasskeyDto')
          ..add('label', label)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt))
        .toString();
  }
}

class ExportPasskeyDtoBuilder
    implements Builder<ExportPasskeyDto, ExportPasskeyDtoBuilder> {
  _$ExportPasskeyDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  ExportPasskeyDtoBuilder() {
    ExportPasskeyDto._defaults(this);
  }

  ExportPasskeyDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportPasskeyDto other) {
    _$v = other as _$ExportPasskeyDto;
  }

  @override
  void update(void Function(ExportPasskeyDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportPasskeyDto build() => _build();

  _$ExportPasskeyDto _build() {
    final _$result =
        _$v ??
        _$ExportPasskeyDto._(
          label: label,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExportPasskeyDto',
            'createdAt',
          ),
          lastUsedAt: lastUsedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
