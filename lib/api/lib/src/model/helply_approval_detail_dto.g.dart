// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_approval_detail_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyApprovalDetailDto extends HelplyApprovalDetailDto {
  @override
  final String label;
  @override
  final String value;

  factory _$HelplyApprovalDetailDto([
    void Function(HelplyApprovalDetailDtoBuilder)? updates,
  ]) => (HelplyApprovalDetailDtoBuilder()..update(updates))._build();

  _$HelplyApprovalDetailDto._({required this.label, required this.value})
    : super._();
  @override
  HelplyApprovalDetailDto rebuild(
    void Function(HelplyApprovalDetailDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyApprovalDetailDtoBuilder toBuilder() =>
      HelplyApprovalDetailDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyApprovalDetailDto &&
        label == other.label &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyApprovalDetailDto')
          ..add('label', label)
          ..add('value', value))
        .toString();
  }
}

class HelplyApprovalDetailDtoBuilder
    implements
        Builder<HelplyApprovalDetailDto, HelplyApprovalDetailDtoBuilder> {
  _$HelplyApprovalDetailDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  HelplyApprovalDetailDtoBuilder() {
    HelplyApprovalDetailDto._defaults(this);
  }

  HelplyApprovalDetailDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyApprovalDetailDto other) {
    _$v = other as _$HelplyApprovalDetailDto;
  }

  @override
  void update(void Function(HelplyApprovalDetailDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyApprovalDetailDto build() => _build();

  _$HelplyApprovalDetailDto _build() {
    final _$result =
        _$v ??
        _$HelplyApprovalDetailDto._(
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'HelplyApprovalDetailDto',
            'label',
          ),
          value: BuiltValueNullFieldError.checkNotNull(
            value,
            r'HelplyApprovalDetailDto',
            'value',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
