// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_field_suggestion_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginFieldSuggestionDto extends LoginFieldSuggestionDto {
  @override
  final String label;
  @override
  final String value;

  factory _$LoginFieldSuggestionDto([
    void Function(LoginFieldSuggestionDtoBuilder)? updates,
  ]) => (LoginFieldSuggestionDtoBuilder()..update(updates))._build();

  _$LoginFieldSuggestionDto._({required this.label, required this.value})
    : super._();
  @override
  LoginFieldSuggestionDto rebuild(
    void Function(LoginFieldSuggestionDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LoginFieldSuggestionDtoBuilder toBuilder() =>
      LoginFieldSuggestionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginFieldSuggestionDto &&
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
    return (newBuiltValueToStringHelper(r'LoginFieldSuggestionDto')
          ..add('label', label)
          ..add('value', value))
        .toString();
  }
}

class LoginFieldSuggestionDtoBuilder
    implements
        Builder<LoginFieldSuggestionDto, LoginFieldSuggestionDtoBuilder> {
  _$LoginFieldSuggestionDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  LoginFieldSuggestionDtoBuilder() {
    LoginFieldSuggestionDto._defaults(this);
  }

  LoginFieldSuggestionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginFieldSuggestionDto other) {
    _$v = other as _$LoginFieldSuggestionDto;
  }

  @override
  void update(void Function(LoginFieldSuggestionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginFieldSuggestionDto build() => _build();

  _$LoginFieldSuggestionDto _build() {
    final _$result =
        _$v ??
        _$LoginFieldSuggestionDto._(
          label: BuiltValueNullFieldError.checkNotNull(
            label,
            r'LoginFieldSuggestionDto',
            'label',
          ),
          value: BuiltValueNullFieldError.checkNotNull(
            value,
            r'LoginFieldSuggestionDto',
            'value',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
