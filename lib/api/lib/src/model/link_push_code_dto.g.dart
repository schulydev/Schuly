// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_push_code_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkPushCodeDto extends LinkPushCodeDto {
  @override
  final String? number;
  @override
  final DateTime expiresAt;
  @override
  final int pollIntervalSeconds;

  factory _$LinkPushCodeDto([void Function(LinkPushCodeDtoBuilder)? updates]) =>
      (LinkPushCodeDtoBuilder()..update(updates))._build();

  _$LinkPushCodeDto._({
    this.number,
    required this.expiresAt,
    required this.pollIntervalSeconds,
  }) : super._();
  @override
  LinkPushCodeDto rebuild(void Function(LinkPushCodeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkPushCodeDtoBuilder toBuilder() => LinkPushCodeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkPushCodeDto &&
        number == other.number &&
        expiresAt == other.expiresAt &&
        pollIntervalSeconds == other.pollIntervalSeconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, number.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, pollIntervalSeconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkPushCodeDto')
          ..add('number', number)
          ..add('expiresAt', expiresAt)
          ..add('pollIntervalSeconds', pollIntervalSeconds))
        .toString();
  }
}

class LinkPushCodeDtoBuilder
    implements Builder<LinkPushCodeDto, LinkPushCodeDtoBuilder> {
  _$LinkPushCodeDto? _$v;

  String? _number;
  String? get number => _$this._number;
  set number(String? number) => _$this._number = number;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  int? _pollIntervalSeconds;
  int? get pollIntervalSeconds => _$this._pollIntervalSeconds;
  set pollIntervalSeconds(int? pollIntervalSeconds) =>
      _$this._pollIntervalSeconds = pollIntervalSeconds;

  LinkPushCodeDtoBuilder() {
    LinkPushCodeDto._defaults(this);
  }

  LinkPushCodeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _number = $v.number;
      _expiresAt = $v.expiresAt;
      _pollIntervalSeconds = $v.pollIntervalSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkPushCodeDto other) {
    _$v = other as _$LinkPushCodeDto;
  }

  @override
  void update(void Function(LinkPushCodeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkPushCodeDto build() => _build();

  _$LinkPushCodeDto _build() {
    final _$result =
        _$v ??
        _$LinkPushCodeDto._(
          number: number,
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'LinkPushCodeDto',
            'expiresAt',
          ),
          pollIntervalSeconds: BuiltValueNullFieldError.checkNotNull(
            pollIntervalSeconds,
            r'LinkPushCodeDto',
            'pollIntervalSeconds',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
