// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reencrypt_student_documents_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReencryptStudentDocumentsResult
    extends ReencryptStudentDocumentsResult {
  @override
  final int total;
  @override
  final int reencrypted;
  @override
  final int alreadyEncrypted;
  @override
  final int failed;

  factory _$ReencryptStudentDocumentsResult([
    void Function(ReencryptStudentDocumentsResultBuilder)? updates,
  ]) => (ReencryptStudentDocumentsResultBuilder()..update(updates))._build();

  _$ReencryptStudentDocumentsResult._({
    required this.total,
    required this.reencrypted,
    required this.alreadyEncrypted,
    required this.failed,
  }) : super._();
  @override
  ReencryptStudentDocumentsResult rebuild(
    void Function(ReencryptStudentDocumentsResultBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReencryptStudentDocumentsResultBuilder toBuilder() =>
      ReencryptStudentDocumentsResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReencryptStudentDocumentsResult &&
        total == other.total &&
        reencrypted == other.reencrypted &&
        alreadyEncrypted == other.alreadyEncrypted &&
        failed == other.failed;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, reencrypted.hashCode);
    _$hash = $jc(_$hash, alreadyEncrypted.hashCode);
    _$hash = $jc(_$hash, failed.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReencryptStudentDocumentsResult')
          ..add('total', total)
          ..add('reencrypted', reencrypted)
          ..add('alreadyEncrypted', alreadyEncrypted)
          ..add('failed', failed))
        .toString();
  }
}

class ReencryptStudentDocumentsResultBuilder
    implements
        Builder<
          ReencryptStudentDocumentsResult,
          ReencryptStudentDocumentsResultBuilder
        > {
  _$ReencryptStudentDocumentsResult? _$v;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _reencrypted;
  int? get reencrypted => _$this._reencrypted;
  set reencrypted(int? reencrypted) => _$this._reencrypted = reencrypted;

  int? _alreadyEncrypted;
  int? get alreadyEncrypted => _$this._alreadyEncrypted;
  set alreadyEncrypted(int? alreadyEncrypted) =>
      _$this._alreadyEncrypted = alreadyEncrypted;

  int? _failed;
  int? get failed => _$this._failed;
  set failed(int? failed) => _$this._failed = failed;

  ReencryptStudentDocumentsResultBuilder() {
    ReencryptStudentDocumentsResult._defaults(this);
  }

  ReencryptStudentDocumentsResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _total = $v.total;
      _reencrypted = $v.reencrypted;
      _alreadyEncrypted = $v.alreadyEncrypted;
      _failed = $v.failed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReencryptStudentDocumentsResult other) {
    _$v = other as _$ReencryptStudentDocumentsResult;
  }

  @override
  void update(void Function(ReencryptStudentDocumentsResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReencryptStudentDocumentsResult build() => _build();

  _$ReencryptStudentDocumentsResult _build() {
    final _$result =
        _$v ??
        _$ReencryptStudentDocumentsResult._(
          total: BuiltValueNullFieldError.checkNotNull(
            total,
            r'ReencryptStudentDocumentsResult',
            'total',
          ),
          reencrypted: BuiltValueNullFieldError.checkNotNull(
            reencrypted,
            r'ReencryptStudentDocumentsResult',
            'reencrypted',
          ),
          alreadyEncrypted: BuiltValueNullFieldError.checkNotNull(
            alreadyEncrypted,
            r'ReencryptStudentDocumentsResult',
            'alreadyEncrypted',
          ),
          failed: BuiltValueNullFieldError.checkNotNull(
            failed,
            r'ReencryptStudentDocumentsResult',
            'failed',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
