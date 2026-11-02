// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_otp_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkOtpDto extends LinkOtpDto {
  @override
  final int length;
  @override
  final String? label;
  @override
  final bool numericOnly;

  factory _$LinkOtpDto([void Function(LinkOtpDtoBuilder)? updates]) =>
      (LinkOtpDtoBuilder()..update(updates))._build();

  _$LinkOtpDto._({required this.length, this.label, required this.numericOnly})
    : super._();
  @override
  LinkOtpDto rebuild(void Function(LinkOtpDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkOtpDtoBuilder toBuilder() => LinkOtpDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkOtpDto &&
        length == other.length &&
        label == other.label &&
        numericOnly == other.numericOnly;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, length.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, numericOnly.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkOtpDto')
          ..add('length', length)
          ..add('label', label)
          ..add('numericOnly', numericOnly))
        .toString();
  }
}

class LinkOtpDtoBuilder implements Builder<LinkOtpDto, LinkOtpDtoBuilder> {
  _$LinkOtpDto? _$v;

  int? _length;
  int? get length => _$this._length;
  set length(int? length) => _$this._length = length;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  bool? _numericOnly;
  bool? get numericOnly => _$this._numericOnly;
  set numericOnly(bool? numericOnly) => _$this._numericOnly = numericOnly;

  LinkOtpDtoBuilder() {
    LinkOtpDto._defaults(this);
  }

  LinkOtpDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _length = $v.length;
      _label = $v.label;
      _numericOnly = $v.numericOnly;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkOtpDto other) {
    _$v = other as _$LinkOtpDto;
  }

  @override
  void update(void Function(LinkOtpDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkOtpDto build() => _build();

  _$LinkOtpDto _build() {
    final _$result =
        _$v ??
        _$LinkOtpDto._(
          length: BuiltValueNullFieldError.checkNotNull(
            length,
            r'LinkOtpDto',
            'length',
          ),
          label: label,
          numericOnly: BuiltValueNullFieldError.checkNotNull(
            numericOnly,
            r'LinkOtpDto',
            'numericOnly',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
