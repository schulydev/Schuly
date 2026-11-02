// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_provider_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkProviderDto extends LinkProviderDto {
  @override
  final String id;
  @override
  final String displayName;
  @override
  final String? description;
  @override
  final LinkIconDto icon;
  @override
  final BuiltList<LinkCapabilityDto> capabilities;
  @override
  final BuiltList<LinkFlowDto> flows;
  @override
  final int sortOrder;

  factory _$LinkProviderDto([void Function(LinkProviderDtoBuilder)? updates]) =>
      (LinkProviderDtoBuilder()..update(updates))._build();

  _$LinkProviderDto._({
    required this.id,
    required this.displayName,
    this.description,
    required this.icon,
    required this.capabilities,
    required this.flows,
    required this.sortOrder,
  }) : super._();
  @override
  LinkProviderDto rebuild(void Function(LinkProviderDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkProviderDtoBuilder toBuilder() => LinkProviderDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkProviderDto &&
        id == other.id &&
        displayName == other.displayName &&
        description == other.description &&
        icon == other.icon &&
        capabilities == other.capabilities &&
        flows == other.flows &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, capabilities.hashCode);
    _$hash = $jc(_$hash, flows.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkProviderDto')
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('description', description)
          ..add('icon', icon)
          ..add('capabilities', capabilities)
          ..add('flows', flows)
          ..add('sortOrder', sortOrder))
        .toString();
  }
}

class LinkProviderDtoBuilder
    implements Builder<LinkProviderDto, LinkProviderDtoBuilder> {
  _$LinkProviderDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  LinkIconDtoBuilder? _icon;
  LinkIconDtoBuilder get icon => _$this._icon ??= LinkIconDtoBuilder();
  set icon(LinkIconDtoBuilder? icon) => _$this._icon = icon;

  ListBuilder<LinkCapabilityDto>? _capabilities;
  ListBuilder<LinkCapabilityDto> get capabilities =>
      _$this._capabilities ??= ListBuilder<LinkCapabilityDto>();
  set capabilities(ListBuilder<LinkCapabilityDto>? capabilities) =>
      _$this._capabilities = capabilities;

  ListBuilder<LinkFlowDto>? _flows;
  ListBuilder<LinkFlowDto> get flows =>
      _$this._flows ??= ListBuilder<LinkFlowDto>();
  set flows(ListBuilder<LinkFlowDto>? flows) => _$this._flows = flows;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  LinkProviderDtoBuilder() {
    LinkProviderDto._defaults(this);
  }

  LinkProviderDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _displayName = $v.displayName;
      _description = $v.description;
      _icon = $v.icon.toBuilder();
      _capabilities = $v.capabilities.toBuilder();
      _flows = $v.flows.toBuilder();
      _sortOrder = $v.sortOrder;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkProviderDto other) {
    _$v = other as _$LinkProviderDto;
  }

  @override
  void update(void Function(LinkProviderDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkProviderDto build() => _build();

  _$LinkProviderDto _build() {
    _$LinkProviderDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkProviderDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'LinkProviderDto',
              'id',
            ),
            displayName: BuiltValueNullFieldError.checkNotNull(
              displayName,
              r'LinkProviderDto',
              'displayName',
            ),
            description: description,
            icon: icon.build(),
            capabilities: capabilities.build(),
            flows: flows.build(),
            sortOrder: BuiltValueNullFieldError.checkNotNull(
              sortOrder,
              r'LinkProviderDto',
              'sortOrder',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'icon';
        icon.build();
        _$failedField = 'capabilities';
        capabilities.build();
        _$failedField = 'flows';
        flows.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkProviderDto',
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
