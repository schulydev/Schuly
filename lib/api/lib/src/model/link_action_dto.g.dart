// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_action_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkActionDto extends LinkActionDto {
  @override
  final String id;
  @override
  final String label;

  factory _$LinkActionDto([void Function(LinkActionDtoBuilder)? updates]) =>
      (LinkActionDtoBuilder()..update(updates))._build();

  _$LinkActionDto._({required this.id, required this.label}) : super._();
  @override
  LinkActionDto rebuild(void Function(LinkActionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkActionDtoBuilder toBuilder() => LinkActionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkActionDto && id == other.id && label == other.label;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkActionDto')
          ..add('id', id)
          ..add('label', label))
        .toString();
  }
}

class LinkActionDtoBuilder
    implements Builder<LinkActionDto, LinkActionDtoBuilder> {
  _$LinkActionDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  LinkActionDtoBuilder() {
    LinkActionDto._defaults(this);
  }

  LinkActionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkActionDto other) {
    _$v = other as _$LinkActionDto;
  }

  @override
  void update(void Function(LinkActionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkActionDto build() => _build();

  _$LinkActionDto _build() {
    final _$result =
        _$v ??
        _$LinkActionDto._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'LinkActionDto', 'id'),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'LinkActionDto',
            'label',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
