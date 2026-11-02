// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_session_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkSessionDto extends LinkSessionDto {
  @override
  final String sessionId;
  @override
  final String providerId;
  @override
  final String flowId;
  @override
  final LinkSessionStatus status;
  @override
  final DateTime expiresAt;
  @override
  final LinkStepDto step;

  factory _$LinkSessionDto([void Function(LinkSessionDtoBuilder)? updates]) =>
      (LinkSessionDtoBuilder()..update(updates))._build();

  _$LinkSessionDto._({
    required this.sessionId,
    required this.providerId,
    required this.flowId,
    required this.status,
    required this.expiresAt,
    required this.step,
  }) : super._();
  @override
  LinkSessionDto rebuild(void Function(LinkSessionDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkSessionDtoBuilder toBuilder() => LinkSessionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkSessionDto &&
        sessionId == other.sessionId &&
        providerId == other.providerId &&
        flowId == other.flowId &&
        status == other.status &&
        expiresAt == other.expiresAt &&
        step == other.step;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, flowId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, step.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkSessionDto')
          ..add('sessionId', sessionId)
          ..add('providerId', providerId)
          ..add('flowId', flowId)
          ..add('status', status)
          ..add('expiresAt', expiresAt)
          ..add('step', step))
        .toString();
  }
}

class LinkSessionDtoBuilder
    implements Builder<LinkSessionDto, LinkSessionDtoBuilder> {
  _$LinkSessionDto? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  String? _flowId;
  String? get flowId => _$this._flowId;
  set flowId(String? flowId) => _$this._flowId = flowId;

  LinkSessionStatus? _status;
  LinkSessionStatus? get status => _$this._status;
  set status(LinkSessionStatus? status) => _$this._status = status;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  LinkStepDtoBuilder? _step;
  LinkStepDtoBuilder get step => _$this._step ??= LinkStepDtoBuilder();
  set step(LinkStepDtoBuilder? step) => _$this._step = step;

  LinkSessionDtoBuilder() {
    LinkSessionDto._defaults(this);
  }

  LinkSessionDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _providerId = $v.providerId;
      _flowId = $v.flowId;
      _status = $v.status;
      _expiresAt = $v.expiresAt;
      _step = $v.step.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkSessionDto other) {
    _$v = other as _$LinkSessionDto;
  }

  @override
  void update(void Function(LinkSessionDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkSessionDto build() => _build();

  _$LinkSessionDto _build() {
    _$LinkSessionDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkSessionDto._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
              sessionId,
              r'LinkSessionDto',
              'sessionId',
            ),
            providerId: BuiltValueNullFieldError.checkNotNull(
              providerId,
              r'LinkSessionDto',
              'providerId',
            ),
            flowId: BuiltValueNullFieldError.checkNotNull(
              flowId,
              r'LinkSessionDto',
              'flowId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'LinkSessionDto',
              'status',
            ),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt,
              r'LinkSessionDto',
              'expiresAt',
            ),
            step: step.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'step';
        step.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkSessionDto',
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
