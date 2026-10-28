// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_login_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExternalLoginResponse extends ExternalLoginResponse {
  @override
  final String provider;
  @override
  final String? displayName;
  @override
  final DateTime createdAt;
  @override
  final DateTime? lastSignInAt;

  factory _$ExternalLoginResponse([
    void Function(ExternalLoginResponseBuilder)? updates,
  ]) => (ExternalLoginResponseBuilder()..update(updates))._build();

  _$ExternalLoginResponse._({
    required this.provider,
    this.displayName,
    required this.createdAt,
    this.lastSignInAt,
  }) : super._();
  @override
  ExternalLoginResponse rebuild(
    void Function(ExternalLoginResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExternalLoginResponseBuilder toBuilder() =>
      ExternalLoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExternalLoginResponse &&
        provider == other.provider &&
        displayName == other.displayName &&
        createdAt == other.createdAt &&
        lastSignInAt == other.lastSignInAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastSignInAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExternalLoginResponse')
          ..add('provider', provider)
          ..add('displayName', displayName)
          ..add('createdAt', createdAt)
          ..add('lastSignInAt', lastSignInAt))
        .toString();
  }
}

class ExternalLoginResponseBuilder
    implements Builder<ExternalLoginResponse, ExternalLoginResponseBuilder> {
  _$ExternalLoginResponse? _$v;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastSignInAt;
  DateTime? get lastSignInAt => _$this._lastSignInAt;
  set lastSignInAt(DateTime? lastSignInAt) =>
      _$this._lastSignInAt = lastSignInAt;

  ExternalLoginResponseBuilder() {
    ExternalLoginResponse._defaults(this);
  }

  ExternalLoginResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _provider = $v.provider;
      _displayName = $v.displayName;
      _createdAt = $v.createdAt;
      _lastSignInAt = $v.lastSignInAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExternalLoginResponse other) {
    _$v = other as _$ExternalLoginResponse;
  }

  @override
  void update(void Function(ExternalLoginResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExternalLoginResponse build() => _build();

  _$ExternalLoginResponse _build() {
    final _$result =
        _$v ??
        _$ExternalLoginResponse._(
          provider: BuiltValueNullFieldError.checkNotNull(
            provider,
            r'ExternalLoginResponse',
            'provider',
          ),
          displayName: displayName,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExternalLoginResponse',
            'createdAt',
          ),
          lastSignInAt: lastSignInAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
