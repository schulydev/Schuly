// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_enrolment_started.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TwoFactorEnrolmentStarted extends TwoFactorEnrolmentStarted {
  @override
  final String secret;
  @override
  final String uri;

  factory _$TwoFactorEnrolmentStarted([
    void Function(TwoFactorEnrolmentStartedBuilder)? updates,
  ]) => (TwoFactorEnrolmentStartedBuilder()..update(updates))._build();

  _$TwoFactorEnrolmentStarted._({required this.secret, required this.uri})
    : super._();
  @override
  TwoFactorEnrolmentStarted rebuild(
    void Function(TwoFactorEnrolmentStartedBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TwoFactorEnrolmentStartedBuilder toBuilder() =>
      TwoFactorEnrolmentStartedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TwoFactorEnrolmentStarted &&
        secret == other.secret &&
        uri == other.uri;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, secret.hashCode);
    _$hash = $jc(_$hash, uri.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TwoFactorEnrolmentStarted')
          ..add('secret', secret)
          ..add('uri', uri))
        .toString();
  }
}

class TwoFactorEnrolmentStartedBuilder
    implements
        Builder<TwoFactorEnrolmentStarted, TwoFactorEnrolmentStartedBuilder> {
  _$TwoFactorEnrolmentStarted? _$v;

  String? _secret;
  String? get secret => _$this._secret;
  set secret(String? secret) => _$this._secret = secret;

  String? _uri;
  String? get uri => _$this._uri;
  set uri(String? uri) => _$this._uri = uri;

  TwoFactorEnrolmentStartedBuilder() {
    TwoFactorEnrolmentStarted._defaults(this);
  }

  TwoFactorEnrolmentStartedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _secret = $v.secret;
      _uri = $v.uri;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TwoFactorEnrolmentStarted other) {
    _$v = other as _$TwoFactorEnrolmentStarted;
  }

  @override
  void update(void Function(TwoFactorEnrolmentStartedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TwoFactorEnrolmentStarted build() => _build();

  _$TwoFactorEnrolmentStarted _build() {
    final _$result =
        _$v ??
        _$TwoFactorEnrolmentStarted._(
          secret: BuiltValueNullFieldError.checkNotNull(
            secret,
            r'TwoFactorEnrolmentStarted',
            'secret',
          ),
          uri: BuiltValueNullFieldError.checkNotNull(
            uri,
            r'TwoFactorEnrolmentStarted',
            'uri',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
