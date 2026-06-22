// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_system_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolSystemDto extends SchoolSystemDto {
  @override
  final String? id;
  @override
  final String key;
  @override
  final String displayName;
  @override
  final String? logoUrl;
  @override
  final String? privateAuthStrategy;
  @override
  final String? statelessBasePath;
  @override
  final String? pluginBasePath;
  @override
  final String loginMethod;
  @override
  final bool? enabled;
  @override
  final int? sortOrder;
  @override
  final BuiltList<SchoolSystemLoginFieldDto>? loginFields;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$SchoolSystemDto([void Function(SchoolSystemDtoBuilder)? updates]) =>
      (SchoolSystemDtoBuilder()..update(updates))._build();

  _$SchoolSystemDto._({
    this.id,
    required this.key,
    required this.displayName,
    this.logoUrl,
    this.privateAuthStrategy,
    this.statelessBasePath,
    this.pluginBasePath,
    required this.loginMethod,
    this.enabled,
    this.sortOrder,
    this.loginFields,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  SchoolSystemDto rebuild(void Function(SchoolSystemDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SchoolSystemDtoBuilder toBuilder() => SchoolSystemDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolSystemDto &&
        id == other.id &&
        key == other.key &&
        displayName == other.displayName &&
        logoUrl == other.logoUrl &&
        privateAuthStrategy == other.privateAuthStrategy &&
        statelessBasePath == other.statelessBasePath &&
        pluginBasePath == other.pluginBasePath &&
        loginMethod == other.loginMethod &&
        enabled == other.enabled &&
        sortOrder == other.sortOrder &&
        loginFields == other.loginFields &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jc(_$hash, privateAuthStrategy.hashCode);
    _$hash = $jc(_$hash, statelessBasePath.hashCode);
    _$hash = $jc(_$hash, pluginBasePath.hashCode);
    _$hash = $jc(_$hash, loginMethod.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, loginFields.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolSystemDto')
          ..add('id', id)
          ..add('key', key)
          ..add('displayName', displayName)
          ..add('logoUrl', logoUrl)
          ..add('privateAuthStrategy', privateAuthStrategy)
          ..add('statelessBasePath', statelessBasePath)
          ..add('pluginBasePath', pluginBasePath)
          ..add('loginMethod', loginMethod)
          ..add('enabled', enabled)
          ..add('sortOrder', sortOrder)
          ..add('loginFields', loginFields)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SchoolSystemDtoBuilder
    implements Builder<SchoolSystemDto, SchoolSystemDtoBuilder> {
  _$SchoolSystemDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  String? _privateAuthStrategy;
  String? get privateAuthStrategy => _$this._privateAuthStrategy;
  set privateAuthStrategy(String? privateAuthStrategy) =>
      _$this._privateAuthStrategy = privateAuthStrategy;

  String? _statelessBasePath;
  String? get statelessBasePath => _$this._statelessBasePath;
  set statelessBasePath(String? statelessBasePath) =>
      _$this._statelessBasePath = statelessBasePath;

  String? _pluginBasePath;
  String? get pluginBasePath => _$this._pluginBasePath;
  set pluginBasePath(String? pluginBasePath) =>
      _$this._pluginBasePath = pluginBasePath;

  String? _loginMethod;
  String? get loginMethod => _$this._loginMethod;
  set loginMethod(String? loginMethod) => _$this._loginMethod = loginMethod;

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

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SchoolSystemDtoBuilder() {
    SchoolSystemDto._defaults(this);
  }

  SchoolSystemDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _key = $v.key;
      _displayName = $v.displayName;
      _logoUrl = $v.logoUrl;
      _privateAuthStrategy = $v.privateAuthStrategy;
      _statelessBasePath = $v.statelessBasePath;
      _pluginBasePath = $v.pluginBasePath;
      _loginMethod = $v.loginMethod;
      _enabled = $v.enabled;
      _sortOrder = $v.sortOrder;
      _loginFields = $v.loginFields?.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolSystemDto other) {
    _$v = other as _$SchoolSystemDto;
  }

  @override
  void update(void Function(SchoolSystemDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolSystemDto build() => _build();

  _$SchoolSystemDto _build() {
    _$SchoolSystemDto _$result;
    try {
      _$result =
          _$v ??
          _$SchoolSystemDto._(
            id: id,
            key: BuiltValueNullFieldError.checkNotNull(
              key,
              r'SchoolSystemDto',
              'key',
            ),
            displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'SchoolSystemDto',
              'displayName',
            ),
            logoUrl: logoUrl,
            privateAuthStrategy: privateAuthStrategy,
            statelessBasePath: statelessBasePath,
            pluginBasePath: pluginBasePath,
            loginMethod: BuiltValueNullFieldError.checkNotNull(
              loginMethod,
              r'SchoolSystemDto',
              'loginMethod',
            ),
            enabled: enabled,
            sortOrder: sortOrder,
            loginFields: _loginFields?.build(),
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loginFields';
        _loginFields?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SchoolSystemDto',
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
