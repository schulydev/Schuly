// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_capability_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkCapabilityDto extends LinkCapabilityDto {
  @override
  final String kind;
  @override
  final String label;
  @override
  final String? icon;
  @override
  final String? basePath;

  factory _$LinkCapabilityDto([
    void Function(LinkCapabilityDtoBuilder)? updates,
  ]) => (LinkCapabilityDtoBuilder()..update(updates))._build();

  _$LinkCapabilityDto._({
    required this.kind,
    required this.label,
    this.icon,
    this.basePath,
  }) : super._();
  @override
  LinkCapabilityDto rebuild(void Function(LinkCapabilityDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkCapabilityDtoBuilder toBuilder() =>
      LinkCapabilityDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkCapabilityDto &&
        kind == other.kind &&
        label == other.label &&
        icon == other.icon &&
        basePath == other.basePath;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, kind.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, basePath.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkCapabilityDto')
          ..add('kind', kind)
          ..add('label', label)
          ..add('icon', icon)
          ..add('basePath', basePath))
        .toString();
  }
}

class LinkCapabilityDtoBuilder
    implements Builder<LinkCapabilityDto, LinkCapabilityDtoBuilder> {
  _$LinkCapabilityDto? _$v;

  String? _kind;
  String? get kind => _$this._kind;
  set kind(String? kind) => _$this._kind = kind;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _basePath;
  String? get basePath => _$this._basePath;
  set basePath(String? basePath) => _$this._basePath = basePath;

  LinkCapabilityDtoBuilder() {
    LinkCapabilityDto._defaults(this);
  }

  LinkCapabilityDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _kind = $v.kind;
      _label = $v.label;
      _icon = $v.icon;
      _basePath = $v.basePath;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkCapabilityDto other) {
    _$v = other as _$LinkCapabilityDto;
  }

  @override
  void update(void Function(LinkCapabilityDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkCapabilityDto build() => _build();

  _$LinkCapabilityDto _build() {
    final _$result =
        _$v ??
        _$LinkCapabilityDto._(
          kind: BuiltValueNullFieldError.checkNotNull(
            kind,
            r'LinkCapabilityDto',
            'kind',
          ),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'LinkCapabilityDto',
            'label',
          ),
          icon: icon,
          basePath: basePath,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
