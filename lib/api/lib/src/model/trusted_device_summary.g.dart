// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trusted_device_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TrustedDeviceSummary extends TrustedDeviceSummary {
  @override
  final String id;
  @override
  final String? label;
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
  final bool isCurrent;

  factory _$TrustedDeviceSummary([
    void Function(TrustedDeviceSummaryBuilder)? updates,
  ]) => (TrustedDeviceSummaryBuilder()..update(updates))._build();

  _$TrustedDeviceSummary._({
    required this.id,
    this.label,
    this.userAgent,
    this.ipAddress,
    required this.createdAt,
    required this.lastUsedAt,
    required this.expiresAt,
    required this.isCurrent,
  }) : super._();
  @override
  TrustedDeviceSummary rebuild(
    void Function(TrustedDeviceSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TrustedDeviceSummaryBuilder toBuilder() =>
      TrustedDeviceSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TrustedDeviceSummary &&
        id == other.id &&
        label == other.label &&
        userAgent == other.userAgent &&
        ipAddress == other.ipAddress &&
        createdAt == other.createdAt &&
        lastUsedAt == other.lastUsedAt &&
        expiresAt == other.expiresAt &&
        isCurrent == other.isCurrent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, userAgent.hashCode);
    _$hash = $jc(_$hash, ipAddress.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastUsedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, isCurrent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TrustedDeviceSummary')
          ..add('id', id)
          ..add('label', label)
          ..add('userAgent', userAgent)
          ..add('ipAddress', ipAddress)
          ..add('createdAt', createdAt)
          ..add('lastUsedAt', lastUsedAt)
          ..add('expiresAt', expiresAt)
          ..add('isCurrent', isCurrent))
        .toString();
  }
}

class TrustedDeviceSummaryBuilder
    implements Builder<TrustedDeviceSummary, TrustedDeviceSummaryBuilder> {
  _$TrustedDeviceSummary? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

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

  bool? _isCurrent;
  bool? get isCurrent => _$this._isCurrent;
  set isCurrent(bool? isCurrent) => _$this._isCurrent = isCurrent;

  TrustedDeviceSummaryBuilder() {
    TrustedDeviceSummary._defaults(this);
  }

  TrustedDeviceSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _userAgent = $v.userAgent;
      _ipAddress = $v.ipAddress;
      _createdAt = $v.createdAt;
      _lastUsedAt = $v.lastUsedAt;
      _expiresAt = $v.expiresAt;
      _isCurrent = $v.isCurrent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TrustedDeviceSummary other) {
    _$v = other as _$TrustedDeviceSummary;
  }

  @override
  void update(void Function(TrustedDeviceSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TrustedDeviceSummary build() => _build();

  _$TrustedDeviceSummary _build() {
    final _$result =
        _$v ??
        _$TrustedDeviceSummary._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'TrustedDeviceSummary',
            'id',
          ),
          label: label,
          userAgent: userAgent,
          ipAddress: ipAddress,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'TrustedDeviceSummary',
            'createdAt',
          ),
          lastUsedAt: BuiltValueNullFieldError.checkNotNull(
            lastUsedAt,
            r'TrustedDeviceSummary',
            'lastUsedAt',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'TrustedDeviceSummary',
            'expiresAt',
          ),
          isCurrent: BuiltValueNullFieldError.checkNotNull(
            isCurrent,
            r'TrustedDeviceSummary',
            'isCurrent',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
