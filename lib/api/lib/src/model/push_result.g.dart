// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PushResult extends PushResult {
  @override
  final int successCount;
  @override
  final int failureCount;
  @override
  final BuiltList<String> unregisteredTokens;

  factory _$PushResult([void Function(PushResultBuilder)? updates]) =>
      (PushResultBuilder()..update(updates))._build();

  _$PushResult._({
    required this.successCount,
    required this.failureCount,
    required this.unregisteredTokens,
  }) : super._();
  @override
  PushResult rebuild(void Function(PushResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PushResultBuilder toBuilder() => PushResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PushResult &&
        successCount == other.successCount &&
        failureCount == other.failureCount &&
        unregisteredTokens == other.unregisteredTokens;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, successCount.hashCode);
    _$hash = $jc(_$hash, failureCount.hashCode);
    _$hash = $jc(_$hash, unregisteredTokens.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PushResult')
          ..add('successCount', successCount)
          ..add('failureCount', failureCount)
          ..add('unregisteredTokens', unregisteredTokens))
        .toString();
  }
}

class PushResultBuilder implements Builder<PushResult, PushResultBuilder> {
  _$PushResult? _$v;

  int? _successCount;
  int? get successCount => _$this._successCount;
  set successCount(int? successCount) => _$this._successCount = successCount;

  int? _failureCount;
  int? get failureCount => _$this._failureCount;
  set failureCount(int? failureCount) => _$this._failureCount = failureCount;

  ListBuilder<String>? _unregisteredTokens;
  ListBuilder<String> get unregisteredTokens =>
      _$this._unregisteredTokens ??= ListBuilder<String>();
  set unregisteredTokens(ListBuilder<String>? unregisteredTokens) =>
      _$this._unregisteredTokens = unregisteredTokens;

  PushResultBuilder() {
    PushResult._defaults(this);
  }

  PushResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _successCount = $v.successCount;
      _failureCount = $v.failureCount;
      _unregisteredTokens = $v.unregisteredTokens.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PushResult other) {
    _$v = other as _$PushResult;
  }

  @override
  void update(void Function(PushResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PushResult build() => _build();

  _$PushResult _build() {
    _$PushResult _$result;
    try {
      _$result =
          _$v ??
          _$PushResult._(
            successCount: BuiltValueNullFieldError.checkNotNull(
              successCount,
              r'PushResult',
              'successCount',
            ),
            failureCount: BuiltValueNullFieldError.checkNotNull(
              failureCount,
              r'PushResult',
              'failureCount',
            ),
            unregisteredTokens: unregisteredTokens.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'unregisteredTokens';
        unregisteredTokens.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PushResult',
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
