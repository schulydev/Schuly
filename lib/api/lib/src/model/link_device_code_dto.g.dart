// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_device_code_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkDeviceCodeDto extends LinkDeviceCodeDto {
  @override
  final String userCode;
  @override
  final String verificationUri;
  @override
  final DateTime expiresAt;
  @override
  final int pollIntervalSeconds;

  factory _$LinkDeviceCodeDto([
    void Function(LinkDeviceCodeDtoBuilder)? updates,
  ]) => (LinkDeviceCodeDtoBuilder()..update(updates))._build();

  _$LinkDeviceCodeDto._({
    required this.userCode,
    required this.verificationUri,
    required this.expiresAt,
    required this.pollIntervalSeconds,
  }) : super._();
  @override
  LinkDeviceCodeDto rebuild(void Function(LinkDeviceCodeDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkDeviceCodeDtoBuilder toBuilder() =>
      LinkDeviceCodeDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkDeviceCodeDto &&
        userCode == other.userCode &&
        verificationUri == other.verificationUri &&
        expiresAt == other.expiresAt &&
        pollIntervalSeconds == other.pollIntervalSeconds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userCode.hashCode);
    _$hash = $jc(_$hash, verificationUri.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, pollIntervalSeconds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkDeviceCodeDto')
          ..add('userCode', userCode)
          ..add('verificationUri', verificationUri)
          ..add('expiresAt', expiresAt)
          ..add('pollIntervalSeconds', pollIntervalSeconds))
        .toString();
  }
}

class LinkDeviceCodeDtoBuilder
    implements Builder<LinkDeviceCodeDto, LinkDeviceCodeDtoBuilder> {
  _$LinkDeviceCodeDto? _$v;

  String? _userCode;
  String? get userCode => _$this._userCode;
  set userCode(String? userCode) => _$this._userCode = userCode;

  String? _verificationUri;
  String? get verificationUri => _$this._verificationUri;
  set verificationUri(String? verificationUri) =>
      _$this._verificationUri = verificationUri;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  int? _pollIntervalSeconds;
  int? get pollIntervalSeconds => _$this._pollIntervalSeconds;
  set pollIntervalSeconds(int? pollIntervalSeconds) =>
      _$this._pollIntervalSeconds = pollIntervalSeconds;

  LinkDeviceCodeDtoBuilder() {
    LinkDeviceCodeDto._defaults(this);
  }

  LinkDeviceCodeDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userCode = $v.userCode;
      _verificationUri = $v.verificationUri;
      _expiresAt = $v.expiresAt;
      _pollIntervalSeconds = $v.pollIntervalSeconds;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkDeviceCodeDto other) {
    _$v = other as _$LinkDeviceCodeDto;
  }

  @override
  void update(void Function(LinkDeviceCodeDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkDeviceCodeDto build() => _build();

  _$LinkDeviceCodeDto _build() {
    final _$result =
        _$v ??
        _$LinkDeviceCodeDto._(
          userCode: BuiltValueNullFieldError.checkNotNull(
            userCode,
            r'LinkDeviceCodeDto',
            'userCode',
          ),
          verificationUri: BuiltValueNullFieldError.checkNotNull(
            verificationUri,
            r'LinkDeviceCodeDto',
            'verificationUri',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'LinkDeviceCodeDto',
            'expiresAt',
          ),
          pollIntervalSeconds: BuiltValueNullFieldError.checkNotNull(
            pollIntervalSeconds,
            r'LinkDeviceCodeDto',
            'pollIntervalSeconds',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
