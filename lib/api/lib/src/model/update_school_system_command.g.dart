// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_school_system_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSchoolSystemCommand extends UpdateSchoolSystemCommand {
  @override
  final String id;
  @override
  final String key;
  @override
  final String displayName;
  @override
  final String loginMethod;
  @override
  final String? logoUrl;
  @override
  final String? schulwareApiBaseUrl;
  @override
  final String? statelessBasePath;
  @override
  final String? pluginBasePath;
  @override
  final bool? enabled;
  @override
  final int? sortOrder;
  @override
  final BuiltList<SchoolSystemLoginFieldDto>? loginFields;

  factory _$UpdateSchoolSystemCommand([
    void Function(UpdateSchoolSystemCommandBuilder)? updates,
  ]) => (UpdateSchoolSystemCommandBuilder()..update(updates))._build();

  _$UpdateSchoolSystemCommand._({
    required this.id,
    required this.key,
    required this.displayName,
    required this.loginMethod,
    this.logoUrl,
    this.schulwareApiBaseUrl,
    this.statelessBasePath,
    this.pluginBasePath,
    this.enabled,
    this.sortOrder,
    this.loginFields,
  }) : super._();
  @override
  UpdateSchoolSystemCommand rebuild(
    void Function(UpdateSchoolSystemCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateSchoolSystemCommandBuilder toBuilder() =>
      UpdateSchoolSystemCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSchoolSystemCommand &&
        id == other.id &&
        key == other.key &&
        displayName == other.displayName &&
        loginMethod == other.loginMethod &&
        logoUrl == other.logoUrl &&
        schulwareApiBaseUrl == other.schulwareApiBaseUrl &&
        statelessBasePath == other.statelessBasePath &&
        pluginBasePath == other.pluginBasePath &&
        enabled == other.enabled &&
        sortOrder == other.sortOrder &&
        loginFields == other.loginFields;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, loginMethod.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jc(_$hash, schulwareApiBaseUrl.hashCode);
    _$hash = $jc(_$hash, statelessBasePath.hashCode);
    _$hash = $jc(_$hash, pluginBasePath.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, loginFields.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSchoolSystemCommand')
          ..add('id', id)
          ..add('key', key)
          ..add('displayName', displayName)
          ..add('loginMethod', loginMethod)
          ..add('logoUrl', logoUrl)
          ..add('schulwareApiBaseUrl', schulwareApiBaseUrl)
          ..add('statelessBasePath', statelessBasePath)
          ..add('pluginBasePath', pluginBasePath)
          ..add('enabled', enabled)
          ..add('sortOrder', sortOrder)
          ..add('loginFields', loginFields))
        .toString();
  }
}

class UpdateSchoolSystemCommandBuilder
    implements
        Builder<UpdateSchoolSystemCommand, UpdateSchoolSystemCommandBuilder> {
  _$UpdateSchoolSystemCommand? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _loginMethod;
  String? get loginMethod => _$this._loginMethod;
  set loginMethod(String? loginMethod) => _$this._loginMethod = loginMethod;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  String? _schulwareApiBaseUrl;
  String? get schulwareApiBaseUrl => _$this._schulwareApiBaseUrl;
  set schulwareApiBaseUrl(String? schulwareApiBaseUrl) =>
      _$this._schulwareApiBaseUrl = schulwareApiBaseUrl;

  String? _statelessBasePath;
  String? get statelessBasePath => _$this._statelessBasePath;
  set statelessBasePath(String? statelessBasePath) =>
      _$this._statelessBasePath = statelessBasePath;

  String? _pluginBasePath;
  String? get pluginBasePath => _$this._pluginBasePath;
  set pluginBasePath(String? pluginBasePath) =>
      _$this._pluginBasePath = pluginBasePath;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  ListBuilder<SchoolSystemLoginFieldDto>? _loginFields;
  ListBuilder<SchoolSystemLoginFieldDto> get loginFields =>
      _$this._loginFields ??= ListBuilder<SchoolSystemLoginFieldDto>();
  set loginFields(ListBuilder<SchoolSystemLoginFieldDto>? loginFields) =>
      _$this._loginFields = loginFields;

  UpdateSchoolSystemCommandBuilder() {
    UpdateSchoolSystemCommand._defaults(this);
  }

  UpdateSchoolSystemCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _key = $v.key;
      _displayName = $v.displayName;
      _loginMethod = $v.loginMethod;
      _logoUrl = $v.logoUrl;
      _schulwareApiBaseUrl = $v.schulwareApiBaseUrl;
      _statelessBasePath = $v.statelessBasePath;
      _pluginBasePath = $v.pluginBasePath;
      _enabled = $v.enabled;
      _sortOrder = $v.sortOrder;
      _loginFields = $v.loginFields?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSchoolSystemCommand other) {
    _$v = other as _$UpdateSchoolSystemCommand;
  }

  @override
  void update(void Function(UpdateSchoolSystemCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSchoolSystemCommand build() => _build();

  _$UpdateSchoolSystemCommand _build() {
    _$UpdateSchoolSystemCommand _$result;
    try {
      _$result =
          _$v ??
          _$UpdateSchoolSystemCommand._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'UpdateSchoolSystemCommand',
              'id',
            ),
            key: BuiltValueNullFieldError.checkNotNull(
              key,
              r'UpdateSchoolSystemCommand',
              'key',
            ),
            displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'UpdateSchoolSystemCommand',
              'displayName',
            ),
            loginMethod: BuiltValueNullFieldError.checkNotNull(
              loginMethod,
              r'UpdateSchoolSystemCommand',
              'loginMethod',
            ),
            logoUrl: logoUrl,
            schulwareApiBaseUrl: schulwareApiBaseUrl,
            statelessBasePath: statelessBasePath,
            pluginBasePath: pluginBasePath,
            enabled: enabled,
            sortOrder: sortOrder,
            loginFields: _loginFields?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loginFields';
        _loginFields?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateSchoolSystemCommand',
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
