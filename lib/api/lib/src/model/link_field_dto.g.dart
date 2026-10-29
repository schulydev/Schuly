// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_field_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkFieldDto extends LinkFieldDto {
  @override
  final String key;
  @override
  final String label;
  @override
  final LinkFieldTypeDto type;
  @override
  final String? placeholder;
  @override
  final String? help;
  @override
  final String? defaultValue;
  @override
  final bool required_;
  @override
  final bool secret;
  @override
  final int? maxLength;
  @override
  final String? pattern;
  @override
  final BuiltList<LinkOptionDto> options;
  @override
  final bool allowCustom;

  factory _$LinkFieldDto([void Function(LinkFieldDtoBuilder)? updates]) =>
      (LinkFieldDtoBuilder()..update(updates))._build();

  _$LinkFieldDto._({
    required this.key,
    required this.label,
    required this.type,
    this.placeholder,
    this.help,
    this.defaultValue,
    required this.required_,
    required this.secret,
    this.maxLength,
    this.pattern,
    required this.options,
    required this.allowCustom,
  }) : super._();
  @override
  LinkFieldDto rebuild(void Function(LinkFieldDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkFieldDtoBuilder toBuilder() => LinkFieldDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkFieldDto &&
        key == other.key &&
        label == other.label &&
        type == other.type &&
        placeholder == other.placeholder &&
        help == other.help &&
        defaultValue == other.defaultValue &&
        required_ == other.required_ &&
        secret == other.secret &&
        maxLength == other.maxLength &&
        pattern == other.pattern &&
        options == other.options &&
        allowCustom == other.allowCustom;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, placeholder.hashCode);
    _$hash = $jc(_$hash, help.hashCode);
    _$hash = $jc(_$hash, defaultValue.hashCode);
    _$hash = $jc(_$hash, required_.hashCode);
    _$hash = $jc(_$hash, secret.hashCode);
    _$hash = $jc(_$hash, maxLength.hashCode);
    _$hash = $jc(_$hash, pattern.hashCode);
    _$hash = $jc(_$hash, options.hashCode);
    _$hash = $jc(_$hash, allowCustom.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkFieldDto')
          ..add('key', key)
          ..add('label', label)
          ..add('type', type)
          ..add('placeholder', placeholder)
          ..add('help', help)
          ..add('defaultValue', defaultValue)
          ..add('required_', required_)
          ..add('secret', secret)
          ..add('maxLength', maxLength)
          ..add('pattern', pattern)
          ..add('options', options)
          ..add('allowCustom', allowCustom))
        .toString();
  }
}

class LinkFieldDtoBuilder
    implements Builder<LinkFieldDto, LinkFieldDtoBuilder> {
  _$LinkFieldDto? _$v;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  LinkFieldTypeDto? _type;
  LinkFieldTypeDto? get type => _$this._type;
  set type(LinkFieldTypeDto? type) => _$this._type = type;

  String? _placeholder;
  String? get placeholder => _$this._placeholder;
  set placeholder(String? placeholder) => _$this._placeholder = placeholder;

  String? _help;
  String? get help => _$this._help;
  set help(String? help) => _$this._help = help;

  String? _defaultValue;
  String? get defaultValue => _$this._defaultValue;
  set defaultValue(String? defaultValue) => _$this._defaultValue = defaultValue;

  bool? _required_;
  bool? get required_ => _$this._required_;
  set required_(bool? required_) => _$this._required_ = required_;

  bool? _secret;
  bool? get secret => _$this._secret;
  set secret(bool? secret) => _$this._secret = secret;

  int? _maxLength;
  int? get maxLength => _$this._maxLength;
  set maxLength(int? maxLength) => _$this._maxLength = maxLength;

  String? _pattern;
  String? get pattern => _$this._pattern;
  set pattern(String? pattern) => _$this._pattern = pattern;

  ListBuilder<LinkOptionDto>? _options;
  ListBuilder<LinkOptionDto> get options =>
      _$this._options ??= ListBuilder<LinkOptionDto>();
  set options(ListBuilder<LinkOptionDto>? options) => _$this._options = options;

  bool? _allowCustom;
  bool? get allowCustom => _$this._allowCustom;
  set allowCustom(bool? allowCustom) => _$this._allowCustom = allowCustom;

  LinkFieldDtoBuilder() {
    LinkFieldDto._defaults(this);
  }

  LinkFieldDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _key = $v.key;
      _label = $v.label;
      _type = $v.type;
      _placeholder = $v.placeholder;
      _help = $v.help;
      _defaultValue = $v.defaultValue;
      _required_ = $v.required_;
      _secret = $v.secret;
      _maxLength = $v.maxLength;
      _pattern = $v.pattern;
      _options = $v.options.toBuilder();
      _allowCustom = $v.allowCustom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkFieldDto other) {
    _$v = other as _$LinkFieldDto;
  }

  @override
  void update(void Function(LinkFieldDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkFieldDto build() => _build();

  _$LinkFieldDto _build() {
    _$LinkFieldDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkFieldDto._(
            key: BuiltValueNullFieldError.checkNotNull(
              key,
              r'LinkFieldDto',
              'key',
            ),
            label: BuiltValueNullFieldError.checkNotNull(
              label,
              r'LinkFieldDto',
              'label',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'LinkFieldDto',
              'type',
            ),
            placeholder: placeholder,
            help: help,
            defaultValue: defaultValue,
            required_: BuiltValueNullFieldError.checkNotNull(
              required_,
              r'LinkFieldDto',
              'required_',
            ),
            secret: BuiltValueNullFieldError.checkNotNull(
              secret,
              r'LinkFieldDto',
              'secret',
            ),
            maxLength: maxLength,
            pattern: pattern,
            options: options.build(),
            allowCustom: BuiltValueNullFieldError.checkNotNull(
              allowCustom,
              r'LinkFieldDto',
              'allowCustom',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'options';
        options.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkFieldDto',
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
