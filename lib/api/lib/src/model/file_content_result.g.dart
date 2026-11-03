// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_content_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileContentResult extends FileContentResult {
  @override
  final String? fileContents;
  @override
  final String? contentType;
  @override
  final String? fileDownloadName;
  @override
  final DateTime? lastModified;
  @override
  final EntityTagHeaderValue? entityTag;
  @override
  final bool? enableRangeProcessing;

  factory _$FileContentResult([
    void Function(FileContentResultBuilder)? updates,
  ]) => (FileContentResultBuilder()..update(updates))._build();

  _$FileContentResult._({
    this.fileContents,
    this.contentType,
    this.fileDownloadName,
    this.lastModified,
    this.entityTag,
    this.enableRangeProcessing,
  }) : super._();
  @override
  FileContentResult rebuild(void Function(FileContentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileContentResultBuilder toBuilder() =>
      FileContentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileContentResult &&
        fileContents == other.fileContents &&
        contentType == other.contentType &&
        fileDownloadName == other.fileDownloadName &&
        lastModified == other.lastModified &&
        entityTag == other.entityTag &&
        enableRangeProcessing == other.enableRangeProcessing;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fileContents.hashCode);
    _$hash = $jc(_$hash, contentType.hashCode);
    _$hash = $jc(_$hash, fileDownloadName.hashCode);
    _$hash = $jc(_$hash, lastModified.hashCode);
    _$hash = $jc(_$hash, entityTag.hashCode);
    _$hash = $jc(_$hash, enableRangeProcessing.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileContentResult')
          ..add('fileContents', fileContents)
          ..add('contentType', contentType)
          ..add('fileDownloadName', fileDownloadName)
          ..add('lastModified', lastModified)
          ..add('entityTag', entityTag)
          ..add('enableRangeProcessing', enableRangeProcessing))
        .toString();
  }
}

class FileContentResultBuilder
    implements Builder<FileContentResult, FileContentResultBuilder> {
  _$FileContentResult? _$v;

  String? _fileContents;
  String? get fileContents => _$this._fileContents;
  set fileContents(String? fileContents) => _$this._fileContents = fileContents;

  String? _contentType;
  String? get contentType => _$this._contentType;
  set contentType(String? contentType) => _$this._contentType = contentType;

  String? _fileDownloadName;
  String? get fileDownloadName => _$this._fileDownloadName;
  set fileDownloadName(String? fileDownloadName) =>
      _$this._fileDownloadName = fileDownloadName;

  DateTime? _lastModified;
  DateTime? get lastModified => _$this._lastModified;
  set lastModified(DateTime? lastModified) =>
      _$this._lastModified = lastModified;

  EntityTagHeaderValueBuilder? _entityTag;
  EntityTagHeaderValueBuilder get entityTag =>
      _$this._entityTag ??= EntityTagHeaderValueBuilder();
  set entityTag(EntityTagHeaderValueBuilder? entityTag) =>
      _$this._entityTag = entityTag;

  bool? _enableRangeProcessing;
  bool? get enableRangeProcessing => _$this._enableRangeProcessing;
  set enableRangeProcessing(bool? enableRangeProcessing) =>
      _$this._enableRangeProcessing = enableRangeProcessing;

  FileContentResultBuilder() {
    FileContentResult._defaults(this);
  }

  FileContentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileContents = $v.fileContents;
      _contentType = $v.contentType;
      _fileDownloadName = $v.fileDownloadName;
      _lastModified = $v.lastModified;
      _entityTag = $v.entityTag?.toBuilder();
      _enableRangeProcessing = $v.enableRangeProcessing;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileContentResult other) {
    _$v = other as _$FileContentResult;
  }

  @override
  void update(void Function(FileContentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileContentResult build() => _build();

  _$FileContentResult _build() {
    _$FileContentResult _$result;
    try {
      _$result =
          _$v ??
          _$FileContentResult._(
            fileContents: fileContents,
            contentType: contentType,
            fileDownloadName: fileDownloadName,
            lastModified: lastModified,
            entityTag: _entityTag?.build(),
            enableRangeProcessing: enableRangeProcessing,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entityTag';
        _entityTag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FileContentResult',
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
