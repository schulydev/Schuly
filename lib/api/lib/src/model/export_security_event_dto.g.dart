// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_security_event_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportSecurityEventDto extends ExportSecurityEventDto {
  @override
  final String kind;
  @override
  final String? detail;
  @override
  final DateTime occurredAt;

  factory _$ExportSecurityEventDto([
    void Function(ExportSecurityEventDtoBuilder)? updates,
  ]) => (ExportSecurityEventDtoBuilder()..update(updates))._build();

  _$ExportSecurityEventDto._({
    required this.kind,
    this.detail,
    required this.occurredAt,
  }) : super._();
  @override
  ExportSecurityEventDto rebuild(
    void Function(ExportSecurityEventDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportSecurityEventDtoBuilder toBuilder() =>
      ExportSecurityEventDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportSecurityEventDto &&
        kind == other.kind &&
        detail == other.detail &&
        occurredAt == other.occurredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportSecurityEventDto')
          ..add('kind', kind)
          ..add('detail', detail)
          ..add('occurredAt', occurredAt))
        .toString();
  }
}

class ExportSecurityEventDtoBuilder
    implements Builder<ExportSecurityEventDto, ExportSecurityEventDtoBuilder> {
  _$ExportSecurityEventDto? _$v;

  String? _kind;
  String? get kind => _$this._kind;
  set kind(String? kind) => _$this._kind = kind;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  ExportSecurityEventDtoBuilder() {
    ExportSecurityEventDto._defaults(this);
  }

  ExportSecurityEventDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _detail = $v.detail;
      _occurredAt = $v.occurredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportSecurityEventDto other) {
    _$v = other as _$ExportSecurityEventDto;
  }

  @override
  void update(void Function(ExportSecurityEventDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportSecurityEventDto build() => _build();

  _$ExportSecurityEventDto _build() {
    final _$result =
        _$v ??
        _$ExportSecurityEventDto._(
          kind: BuiltValueNullFieldError.checkNotNull(
            kind,
            r'ExportSecurityEventDto',
            'kind',
          ),
          detail: detail,
          occurredAt: BuiltValueNullFieldError.checkNotNull(
            occurredAt,
            r'ExportSecurityEventDto',
            'occurredAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
