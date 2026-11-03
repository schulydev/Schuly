// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_tool_activity_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyToolActivityDto extends HelplyToolActivityDto {
  @override
  final String id;
  @override
  final String label;
  @override
  final String status;
  @override
  final HelplyCodeRunDto? code;
  @override
  final int? at;
  @override
  final String? detail;

  factory _$HelplyToolActivityDto([
    void Function(HelplyToolActivityDtoBuilder)? updates,
  ]) => (HelplyToolActivityDtoBuilder()..update(updates))._build();

  _$HelplyToolActivityDto._({
    required this.id,
    required this.label,
    required this.status,
    this.code,
    this.at,
    this.detail,
  }) : super._();
  @override
  HelplyToolActivityDto rebuild(
    void Function(HelplyToolActivityDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyToolActivityDtoBuilder toBuilder() =>
      HelplyToolActivityDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyToolActivityDto &&
        id == other.id &&
        label == other.label &&
        status == other.status &&
        code == other.code &&
        at == other.at &&
        detail == other.detail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, at.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyToolActivityDto')
          ..add('id', id)
          ..add('label', label)
          ..add('status', status)
          ..add('code', code)
          ..add('at', at)
          ..add('detail', detail))
        .toString();
  }
}

class HelplyToolActivityDtoBuilder
    implements Builder<HelplyToolActivityDto, HelplyToolActivityDtoBuilder> {
  _$HelplyToolActivityDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  HelplyCodeRunDtoBuilder? _code;
  HelplyCodeRunDtoBuilder get code =>
      _$this._code ??= HelplyCodeRunDtoBuilder();
  set code(HelplyCodeRunDtoBuilder? code) => _$this._code = code;

  int? _at;
  int? get at => _$this._at;
  set at(int? at) => _$this._at = at;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  HelplyToolActivityDtoBuilder() {
    HelplyToolActivityDto._defaults(this);
  }

  HelplyToolActivityDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _status = $v.status;
      _code = $v.code?.toBuilder();
      _at = $v.at;
      _detail = $v.detail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyToolActivityDto other) {
    _$v = other as _$HelplyToolActivityDto;
  }

  @override
  void update(void Function(HelplyToolActivityDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyToolActivityDto build() => _build();

  _$HelplyToolActivityDto _build() {
    _$HelplyToolActivityDto _$result;
    try {
      _$result =
          _$v ??
          _$HelplyToolActivityDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'HelplyToolActivityDto',
              'id',
            ),
            label: BuiltValueNullFieldError.checkNotNull(
              label,
              r'HelplyToolActivityDto',
              'label',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'HelplyToolActivityDto',
              'status',
            ),
            code: _code?.build(),
            at: at,
            detail: detail,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'code';
        _code?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HelplyToolActivityDto',
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
