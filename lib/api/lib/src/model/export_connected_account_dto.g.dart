// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_connected_account_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportConnectedAccountDto extends ExportConnectedAccountDto {
  @override
  final String provider;
  @override
  final String title;
  @override
  final String? detail;
  @override
  final String status;
  @override
  final DateTime? linkedAt;
  @override
  final DateTime? lastSyncedAt;

  factory _$ExportConnectedAccountDto([
    void Function(ExportConnectedAccountDtoBuilder)? updates,
  ]) => (ExportConnectedAccountDtoBuilder()..update(updates))._build();

  _$ExportConnectedAccountDto._({
    required this.provider,
    required this.title,
    this.detail,
    required this.status,
    this.linkedAt,
    this.lastSyncedAt,
  }) : super._();
  @override
  ExportConnectedAccountDto rebuild(
    void Function(ExportConnectedAccountDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportConnectedAccountDtoBuilder toBuilder() =>
      ExportConnectedAccountDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportConnectedAccountDto &&
        provider == other.provider &&
        title == other.title &&
        detail == other.detail &&
        status == other.status &&
        linkedAt == other.linkedAt &&
        lastSyncedAt == other.lastSyncedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, linkedAt.hashCode);
    _$hash = $jc(_$hash, lastSyncedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportConnectedAccountDto')
          ..add('provider', provider)
          ..add('title', title)
          ..add('detail', detail)
          ..add('status', status)
          ..add('linkedAt', linkedAt)
          ..add('lastSyncedAt', lastSyncedAt))
        .toString();
  }
}

class ExportConnectedAccountDtoBuilder
    implements
        Builder<ExportConnectedAccountDto, ExportConnectedAccountDtoBuilder> {
  _$ExportConnectedAccountDto? _$v;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _linkedAt;
  DateTime? get linkedAt => _$this._linkedAt;
  set linkedAt(DateTime? linkedAt) => _$this._linkedAt = linkedAt;

  DateTime? _lastSyncedAt;
  DateTime? get lastSyncedAt => _$this._lastSyncedAt;
  set lastSyncedAt(DateTime? lastSyncedAt) =>
      _$this._lastSyncedAt = lastSyncedAt;

  ExportConnectedAccountDtoBuilder() {
    ExportConnectedAccountDto._defaults(this);
  }

  ExportConnectedAccountDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _title = $v.title;
      _detail = $v.detail;
      _status = $v.status;
      _linkedAt = $v.linkedAt;
      _lastSyncedAt = $v.lastSyncedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportConnectedAccountDto other) {
    _$v = other as _$ExportConnectedAccountDto;
  }

  @override
  void update(void Function(ExportConnectedAccountDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportConnectedAccountDto build() => _build();

  _$ExportConnectedAccountDto _build() {
    final _$result =
        _$v ??
        _$ExportConnectedAccountDto._(
          provider: BuiltValueNullFieldError.checkNotNull(
            provider,
            r'ExportConnectedAccountDto',
            'provider',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'ExportConnectedAccountDto',
            'title',
          ),
          detail: detail,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'ExportConnectedAccountDto',
            'status',
          ),
          linkedAt: linkedAt,
          lastSyncedAt: lastSyncedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
