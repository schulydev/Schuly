// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_queued_notification_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportQueuedNotificationDto extends ExportQueuedNotificationDto {
  @override
  final String type;
  @override
  final String? subjectName;
  @override
  final String? summary;
  @override
  final DateTime createdAt;

  factory _$ExportQueuedNotificationDto([
    void Function(ExportQueuedNotificationDtoBuilder)? updates,
  ]) => (ExportQueuedNotificationDtoBuilder()..update(updates))._build();

  _$ExportQueuedNotificationDto._({
    required this.type,
    this.subjectName,
    this.summary,
    required this.createdAt,
  }) : super._();
  @override
  ExportQueuedNotificationDto rebuild(
    void Function(ExportQueuedNotificationDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportQueuedNotificationDtoBuilder toBuilder() =>
      ExportQueuedNotificationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportQueuedNotificationDto &&
        type == other.type &&
        subjectName == other.subjectName &&
        summary == other.summary &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subjectName.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportQueuedNotificationDto')
          ..add('type', type)
          ..add('subjectName', subjectName)
          ..add('summary', summary)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ExportQueuedNotificationDtoBuilder
    implements
        Builder<
          ExportQueuedNotificationDto,
          ExportQueuedNotificationDtoBuilder
        > {
  _$ExportQueuedNotificationDto? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _subjectName;
  String? get subjectName => _$this._subjectName;
  set subjectName(String? subjectName) => _$this._subjectName = subjectName;

  String? _summary;
  String? get summary => _$this._summary;
  set summary(String? summary) => _$this._summary = summary;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ExportQueuedNotificationDtoBuilder() {
    ExportQueuedNotificationDto._defaults(this);
  }

  ExportQueuedNotificationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _subjectName = $v.subjectName;
      _summary = $v.summary;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportQueuedNotificationDto other) {
    _$v = other as _$ExportQueuedNotificationDto;
  }

  @override
  void update(void Function(ExportQueuedNotificationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportQueuedNotificationDto build() => _build();

  _$ExportQueuedNotificationDto _build() {
    final _$result =
        _$v ??
        _$ExportQueuedNotificationDto._(
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'ExportQueuedNotificationDto',
            'type',
          ),
          subjectName: subjectName,
          summary: summary,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExportQueuedNotificationDto',
            'createdAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
