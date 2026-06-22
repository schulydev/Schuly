// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_system_login_field_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SchoolSystemLoginFieldDto extends SchoolSystemLoginFieldDto {
  @override
  final String key;
  @override
  final String label;
  @override
  final String type;
  @override
  final String? placeholder;
  @override
  final String? defaultValue;
  @override
  final bool? required_;

  factory _$SchoolSystemLoginFieldDto([
    void Function(SchoolSystemLoginFieldDtoBuilder)? updates,
  ]) => (SchoolSystemLoginFieldDtoBuilder()..update(updates))._build();

  _$SchoolSystemLoginFieldDto._({
    required this.key,
    required this.label,
    required this.type,
    this.placeholder,
    this.defaultValue,
    this.required_,
  }) : super._();
  @override
  SchoolSystemLoginFieldDto rebuild(
    void Function(SchoolSystemLoginFieldDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SchoolSystemLoginFieldDtoBuilder toBuilder() =>
      SchoolSystemLoginFieldDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SchoolSystemLoginFieldDto &&
        key == other.key &&
        label == other.label &&
        type == other.type &&
        placeholder == other.placeholder &&
        defaultValue == other.defaultValue &&
        required_ == other.required_;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, placeholder.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jc(_$hash, required_.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SchoolSystemLoginFieldDto')
          ..add('key', key)
          ..add('label', label)
          ..add('type', type)
          ..add('placeholder', placeholder)
          ..add('defaultValue', defaultValue)
          ..add('required_', required_))
        .toString();
  }
}

class SchoolSystemLoginFieldDtoBuilder
    implements
        Builder<SchoolSystemLoginFieldDto, SchoolSystemLoginFieldDtoBuilder> {
  _$SchoolSystemLoginFieldDto? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _placeholder;
  String? get placeholder => _$this._placeholder;
  set placeholder(String? placeholder) => _$this._placeholder = placeholder;

  String? _defaultValue;
  String? get defaultValue => _$this._defaultValue;
  set defaultValue(String? defaultValue) => _$this._defaultValue = defaultValue;

  bool? _required_;
  bool? get required_ => _$this._required_;
  set required_(bool? required_) => _$this._required_ = required_;

  SchoolSystemLoginFieldDtoBuilder() {
    SchoolSystemLoginFieldDto._defaults(this);
  }

  SchoolSystemLoginFieldDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _label = $v.label;
      _type = $v.type;
      _placeholder = $v.placeholder;
      _defaultValue = $v.defaultValue;
      _required_ = $v.required_;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SchoolSystemLoginFieldDto other) {
    _$v = other as _$SchoolSystemLoginFieldDto;
  }

  @override
  void update(void Function(SchoolSystemLoginFieldDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SchoolSystemLoginFieldDto build() => _build();

  _$SchoolSystemLoginFieldDto _build() {
    final _$result =
        _$v ??
        _$SchoolSystemLoginFieldDto._(
          key: BuiltValueNullFieldError.checkNotNull(
            key,
            r'SchoolSystemLoginFieldDto',
            'key',
          ),
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'SchoolSystemLoginFieldDto',
            'label',
          ),
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'SchoolSystemLoginFieldDto',
            'type',
          ),
          placeholder: placeholder,
          defaultValue: defaultValue,
          required_: required_,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
