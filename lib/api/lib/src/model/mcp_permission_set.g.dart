// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_permission_set.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$McpPermissionSet extends McpPermissionSet {
  @override
  final BuiltMap<String, McpAccessLevel>? areas;
  @override
  final bool? allowDestructive;
  @override
  final BuiltList<String>? microsoftAccountIds;

  factory _$McpPermissionSet([
    void Function(McpPermissionSetBuilder)? updates,
  ]) => (McpPermissionSetBuilder()..update(updates))._build();

  _$McpPermissionSet._({
    this.areas,
    this.allowDestructive,
    this.microsoftAccountIds,
  }) : super._();
  @override
  McpPermissionSet rebuild(void Function(McpPermissionSetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  McpPermissionSetBuilder toBuilder() =>
      McpPermissionSetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McpPermissionSet &&
        areas == other.areas &&
        allowDestructive == other.allowDestructive &&
        microsoftAccountIds == other.microsoftAccountIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, areas.hashCode);
    _$hash = $jc(_$hash, allowDestructive.hashCode);
    _$hash = $jc(_$hash, microsoftAccountIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'McpPermissionSet')
          ..add('areas', areas)
          ..add('allowDestructive', allowDestructive)
          ..add('microsoftAccountIds', microsoftAccountIds))
        .toString();
  }
}

class McpPermissionSetBuilder
    implements Builder<McpPermissionSet, McpPermissionSetBuilder> {
  _$McpPermissionSet? _$v;

  MapBuilder<String, McpAccessLevel>? _areas;
  MapBuilder<String, McpAccessLevel> get areas =>
      _$this._areas ??= MapBuilder<String, McpAccessLevel>();
  set areas(MapBuilder<String, McpAccessLevel>? areas) => _$this._areas = areas;

  bool? _allowDestructive;
  bool? get allowDestructive => _$this._allowDestructive;
  set allowDestructive(bool? allowDestructive) =>
      _$this._allowDestructive = allowDestructive;

  ListBuilder<String>? _microsoftAccountIds;
  ListBuilder<String> get microsoftAccountIds =>
      _$this._microsoftAccountIds ??= ListBuilder<String>();
  set microsoftAccountIds(ListBuilder<String>? microsoftAccountIds) =>
      _$this._microsoftAccountIds = microsoftAccountIds;

  McpPermissionSetBuilder() {
    McpPermissionSet._defaults(this);
  }

  McpPermissionSetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _areas = $v.areas?.toBuilder();
      _allowDestructive = $v.allowDestructive;
      _microsoftAccountIds = $v.microsoftAccountIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McpPermissionSet other) {
    _$v = other as _$McpPermissionSet;
  }

  @override
  void update(void Function(McpPermissionSetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  McpPermissionSet build() => _build();

  _$McpPermissionSet _build() {
    _$McpPermissionSet _$result;
    try {
      _$result =
          _$v ??
          _$McpPermissionSet._(
            areas: _areas?.build(),
            allowDestructive: allowDestructive,
            microsoftAccountIds: _microsoftAccountIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'areas';
        _areas?.build();

        _$failedField = 'microsoftAccountIds';
        _microsoftAccountIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'McpPermissionSet',
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
