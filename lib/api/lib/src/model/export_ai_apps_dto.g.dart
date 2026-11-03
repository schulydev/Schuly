// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_ai_apps_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportAiAppsDto extends ExportAiAppsDto {
  @override
  final BuiltList<ExportAiAppConnectionDto> connections;
  @override
  final BuiltList<ExportAiAppKeyDto> apiKeys;
  @override
  final BuiltList<ExportAiAppActivityDto> activity;

  factory _$ExportAiAppsDto([void Function(ExportAiAppsDtoBuilder)? updates]) =>
      (ExportAiAppsDtoBuilder()..update(updates))._build();

  _$ExportAiAppsDto._({
    required this.connections,
    required this.apiKeys,
    required this.activity,
  }) : super._();
  @override
  ExportAiAppsDto rebuild(void Function(ExportAiAppsDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportAiAppsDtoBuilder toBuilder() => ExportAiAppsDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportAiAppsDto &&
        connections == other.connections &&
        apiKeys == other.apiKeys &&
        activity == other.activity;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, connections.hashCode);
    _$hash = $jc(_$hash, apiKeys.hashCode);
    _$hash = $jc(_$hash, activity.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportAiAppsDto')
          ..add('connections', connections)
          ..add('apiKeys', apiKeys)
          ..add('activity', activity))
        .toString();
  }
}

class ExportAiAppsDtoBuilder
    implements Builder<ExportAiAppsDto, ExportAiAppsDtoBuilder> {
  _$ExportAiAppsDto? _$v;

  ListBuilder<ExportAiAppConnectionDto>? _connections;
  ListBuilder<ExportAiAppConnectionDto> get connections =>
      _$this._connections ??= ListBuilder<ExportAiAppConnectionDto>();
  set connections(ListBuilder<ExportAiAppConnectionDto>? connections) =>
      _$this._connections = connections;

  ListBuilder<ExportAiAppKeyDto>? _apiKeys;
  ListBuilder<ExportAiAppKeyDto> get apiKeys =>
      _$this._apiKeys ??= ListBuilder<ExportAiAppKeyDto>();
  set apiKeys(ListBuilder<ExportAiAppKeyDto>? apiKeys) =>
      _$this._apiKeys = apiKeys;

  ListBuilder<ExportAiAppActivityDto>? _activity;
  ListBuilder<ExportAiAppActivityDto> get activity =>
      _$this._activity ??= ListBuilder<ExportAiAppActivityDto>();
  set activity(ListBuilder<ExportAiAppActivityDto>? activity) =>
      _$this._activity = activity;

  ExportAiAppsDtoBuilder() {
    ExportAiAppsDto._defaults(this);
  }

  ExportAiAppsDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _connections = $v.connections.toBuilder();
      _apiKeys = $v.apiKeys.toBuilder();
      _activity = $v.activity.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportAiAppsDto other) {
    _$v = other as _$ExportAiAppsDto;
  }

  @override
  void update(void Function(ExportAiAppsDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportAiAppsDto build() => _build();

  _$ExportAiAppsDto _build() {
    _$ExportAiAppsDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportAiAppsDto._(
            connections: connections.build(),
            apiKeys: apiKeys.build(),
            activity: activity.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'connections';
        connections.build();
        _$failedField = 'apiKeys';
        apiKeys.build();
        _$failedField = 'activity';
        activity.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportAiAppsDto',
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
