// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_status_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyStatusDto extends HelplyStatusDto {
  @override
  final bool enabled;

  factory _$HelplyStatusDto([void Function(HelplyStatusDtoBuilder)? updates]) =>
      (HelplyStatusDtoBuilder()..update(updates))._build();

  _$HelplyStatusDto._({required this.enabled}) : super._();
  @override
  HelplyStatusDto rebuild(void Function(HelplyStatusDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HelplyStatusDtoBuilder toBuilder() => HelplyStatusDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyStatusDto && enabled == other.enabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'HelplyStatusDto',
    )..add('enabled', enabled)).toString();
  }
}

class HelplyStatusDtoBuilder
    implements Builder<HelplyStatusDto, HelplyStatusDtoBuilder> {
  _$HelplyStatusDto? _$v;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  HelplyStatusDtoBuilder() {
    HelplyStatusDto._defaults(this);
  }

  HelplyStatusDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _enabled = $v.enabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyStatusDto other) {
    _$v = other as _$HelplyStatusDto;
  }

  @override
  void update(void Function(HelplyStatusDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyStatusDto build() => _build();

  _$HelplyStatusDto _build() {
    final _$result =
        _$v ??
        _$HelplyStatusDto._(
          enabled: BuiltValueNullFieldError.checkNotNull(
            enabled,
            r'HelplyStatusDto',
            'enabled',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
