// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_option_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkOptionDto extends LinkOptionDto {
  @override
  final String value;
  @override
  final String label;
  @override
  final String? detail;
  @override
  final String? icon;
  @override
  final String? linkProviderId;

  factory _$LinkOptionDto([void Function(LinkOptionDtoBuilder)? updates]) =>
      (LinkOptionDtoBuilder()..update(updates))._build();

  _$LinkOptionDto._({
    required this.value,
    required this.label,
    this.detail,
    this.icon,
    this.linkProviderId,
  }) : super._();
  @override
  LinkOptionDto rebuild(void Function(LinkOptionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkOptionDtoBuilder toBuilder() => LinkOptionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkOptionDto &&
        value == other.value &&
        label == other.label &&
        detail == other.detail &&
        icon == other.icon &&
        linkProviderId == other.linkProviderId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, icon.hashCode);
    _$hash = $jc(_$hash, linkProviderId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkOptionDto')
          ..add('value', value)
          ..add('label', label)
          ..add('detail', detail)
          ..add('icon', icon)
          ..add('linkProviderId', linkProviderId))
        .toString();
  }
}

class LinkOptionDtoBuilder
    implements Builder<LinkOptionDto, LinkOptionDtoBuilder> {
  _$LinkOptionDto? _$v;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  String? _icon;
  String? get icon => _$this._icon;
  set icon(String? icon) => _$this._icon = icon;

  String? _linkProviderId;
  String? get linkProviderId => _$this._linkProviderId;
  set linkProviderId(String? linkProviderId) =>
      _$this._linkProviderId = linkProviderId;

  LinkOptionDtoBuilder() {
    LinkOptionDto._defaults(this);
  }

  LinkOptionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _label = $v.label;
      _detail = $v.detail;
      _icon = $v.icon;
      _linkProviderId = $v.linkProviderId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkOptionDto other) {
    _$v = other as _$LinkOptionDto;
  }

  @override
  void update(void Function(LinkOptionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkOptionDto build() => _build();

  _$LinkOptionDto _build() {
    final _$result =
        _$v ??
        _$LinkOptionDto._(
          value: BuiltValueNullFieldError.checkNotNull(
            value,
            r'LinkOptionDto',
            'value',
          ),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'LinkOptionDto',
            'label',
          ),
          detail: detail,
          icon: icon,
          linkProviderId: linkProviderId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
