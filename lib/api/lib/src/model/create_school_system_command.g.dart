// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_school_system_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSchoolSystemCommand extends CreateSchoolSystemCommand {
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

  factory _$CreateSchoolSystemCommand([
    void Function(CreateSchoolSystemCommandBuilder)? updates,
  ]) => (CreateSchoolSystemCommandBuilder()..update(updates))._build();

  _$CreateSchoolSystemCommand._({
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
  CreateSchoolSystemCommand rebuild(
    void Function(CreateSchoolSystemCommandBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateSchoolSystemCommandBuilder toBuilder() =>
      CreateSchoolSystemCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSchoolSystemCommand &&
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
    return (newBuiltValueToStringHelper(r'CreateSchoolSystemCommand')
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

class CreateSchoolSystemCommandBuilder
    implements
        Builder<CreateSchoolSystemCommand, CreateSchoolSystemCommandBuilder> {
  _$CreateSchoolSystemCommand? _$v;

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

  CreateSchoolSystemCommandBuilder() {
    CreateSchoolSystemCommand._defaults(this);
  }

  CreateSchoolSystemCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(CreateSchoolSystemCommand other) {
    _$v = other as _$CreateSchoolSystemCommand;
  }

  @override
  void update(void Function(CreateSchoolSystemCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSchoolSystemCommand build() => _build();

  _$CreateSchoolSystemCommand _build() {
    _$CreateSchoolSystemCommand _$result;
    try {
      _$result =
          _$v ??
          _$CreateSchoolSystemCommand._(
            key: BuiltValueNullFieldError.checkNotNull(
              key,
              r'CreateSchoolSystemCommand',
              'key',
            ),
            displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'CreateSchoolSystemCommand',
              'displayName',
            ),
            loginMethod: BuiltValueNullFieldError.checkNotNull(
              loginMethod,
              r'CreateSchoolSystemCommand',
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
          r'CreateSchoolSystemCommand',
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
