// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_flow_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkFlowDto extends LinkFlowDto {
  @override
  final String id;
  @override
  final String label;
  @override
  final String? description;

  factory _$LinkFlowDto([void Function(LinkFlowDtoBuilder)? updates]) =>
      (LinkFlowDtoBuilder()..update(updates))._build();

  _$LinkFlowDto._({required this.id, required this.label, this.description})
    : super._();
  @override
  LinkFlowDto rebuild(void Function(LinkFlowDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkFlowDtoBuilder toBuilder() => LinkFlowDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkFlowDto &&
        id == other.id &&
        label == other.label &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkFlowDto')
          ..add('id', id)
          ..add('label', label)
          ..add('description', description))
        .toString();
  }
}

class LinkFlowDtoBuilder implements Builder<LinkFlowDto, LinkFlowDtoBuilder> {
  _$LinkFlowDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  LinkFlowDtoBuilder() {
    LinkFlowDto._defaults(this);
  }

  LinkFlowDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkFlowDto other) {
    _$v = other as _$LinkFlowDto;
  }

  @override
  void update(void Function(LinkFlowDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkFlowDto build() => _build();

  _$LinkFlowDto _build() {
    final _$result =
        _$v ??
        _$LinkFlowDto._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'LinkFlowDto', 'id'),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'LinkFlowDto',
            'label',
          ),
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
