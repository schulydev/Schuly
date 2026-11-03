// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionSummary extends SessionSummary {
  @override
  final String id;
  @override
  final String? userAgent;
  @override
  final String? ipAddress;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastUsedAt;
  @override
  final DateTime expiresAt;
  @override
  final BuiltList<String> authenticationMethods;
  @override
  final bool isCurrent;

  factory _$SessionSummary([void Function(SessionSummaryBuilder)? updates]) =>
      (SessionSummaryBuilder()..update(updates))._build();

  _$SessionSummary._({
    required this.id,
    this.userAgent,
    this.ipAddress,
    required this.createdAt,
    required this.lastUsedAt,
    required this.expiresAt,
    required this.authenticationMethods,
    required this.isCurrent,
  }) : super._();
  @override
  SessionSummary rebuild(void Function(SessionSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionSummaryBuilder toBuilder() => SessionSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionSummary &&
        id == other.id &&
        userAgent == other.userAgent &&
        ipAddress == other.ipAddress &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt &&
        expiresAt == other.expiresAt &&
        authenticationMethods == other.authenticationMethods &&
        isCurrent == other.isCurrent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, authenticationMethods.hashCode);
    _$hash = $jc(_$hash, isCurrent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionSummary')
          ..add('id', id)
          ..add('userAgent', userAgent)
          ..add('ipAddress', ipAddress)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt)
          ..add('expiresAt', expiresAt)
          ..add('authenticationMethods', authenticationMethods)
          ..add('isCurrent', isCurrent))
        .toString();
  }
}

class SessionSummaryBuilder
    implements Builder<SessionSummary, SessionSummaryBuilder> {
  _$SessionSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _userAgent;
  String? get userAgent => _$this._userAgent;
  set userAgent(String? userAgent) => _$this._userAgent = userAgent;

  String? _ipAddress;
  String? get ipAddress => _$this._ipAddress;
  set ipAddress(String? ipAddress) => _$this._ipAddress = ipAddress;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastUsedAt;
  DateTime? get lastUsedAt => _$this._lastUsedAt;
  set lastUsedAt(DateTime? lastUsedAt) => _$this._lastUsedAt = lastUsedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  ListBuilder<String>? _authenticationMethods;
  ListBuilder<String> get authenticationMethods =>
      _$this._authenticationMethods ??= ListBuilder<String>();
  set authenticationMethods(ListBuilder<String>? authenticationMethods) =>
      _$this._authenticationMethods = authenticationMethods;

  bool? _isCurrent;
  bool? get isCurrent => _$this._isCurrent;
  set isCurrent(bool? isCurrent) => _$this._isCurrent = isCurrent;

  SessionSummaryBuilder() {
    SessionSummary._defaults(this);
  }

  SessionSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userAgent = $v.userAgent;
      _ipAddress = $v.ipAddress;
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _expiresAt = $v.expiresAt;
      _authenticationMethods = $v.authenticationMethods.toBuilder();
      _isCurrent = $v.isCurrent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionSummary other) {
    _$v = other as _$SessionSummary;
  }

  @override
  void update(void Function(SessionSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionSummary build() => _build();

  _$SessionSummary _build() {
    _$SessionSummary _$result;
    try {
      _$result =
          _$v ??
          _$SessionSummary._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'SessionSummary',
              'id',
            ),
            userAgent: userAgent,
            ipAddress: ipAddress,
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'SessionSummary',
              'createdAt',
            ),
            lastUsedAt: BuiltValueNullFieldError.checkNotNull(
              lastUsedAt,
              r'SessionSummary',
              'lastUsedAt',
            ),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt,
              r'SessionSummary',
              'expiresAt',
            ),
            authenticationMethods: authenticationMethods.build(),
            isCurrent: BuiltValueNullFieldError.checkNotNull(
              isCurrent,
              r'SessionSummary',
              'isCurrent',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authenticationMethods';
        authenticationMethods.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SessionSummary',
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
