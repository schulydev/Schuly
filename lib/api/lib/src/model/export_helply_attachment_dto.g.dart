// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_helply_attachment_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportHelplyAttachmentDto extends ExportHelplyAttachmentDto {
  @override
  final String fileName;
  @override
  final int sizeBytes;
  @override
  final DateTime createdAt;

  factory _$ExportHelplyAttachmentDto([
    void Function(ExportHelplyAttachmentDtoBuilder)? updates,
  ]) => (ExportHelplyAttachmentDtoBuilder()..update(updates))._build();

  _$ExportHelplyAttachmentDto._({
    required this.fileName,
    required this.sizeBytes,
    required this.createdAt,
  }) : super._();
  @override
  ExportHelplyAttachmentDto rebuild(
    void Function(ExportHelplyAttachmentDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportHelplyAttachmentDtoBuilder toBuilder() =>
      ExportHelplyAttachmentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportHelplyAttachmentDto &&
        fileName == other.fileName &&
        sizeBytes == other.sizeBytes &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, sizeBytes.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportHelplyAttachmentDto')
          ..add('fileName', fileName)
          ..add('sizeBytes', sizeBytes)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ExportHelplyAttachmentDtoBuilder
    implements
        Builder<ExportHelplyAttachmentDto, ExportHelplyAttachmentDtoBuilder> {
  _$ExportHelplyAttachmentDto? _$v;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  int? _sizeBytes;
  int? get sizeBytes => _$this._sizeBytes;
  set sizeBytes(int? sizeBytes) => _$this._sizeBytes = sizeBytes;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ExportHelplyAttachmentDtoBuilder() {
    ExportHelplyAttachmentDto._defaults(this);
  }

  ExportHelplyAttachmentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fileName = $v.fileName;
      _sizeBytes = $v.sizeBytes;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportHelplyAttachmentDto other) {
    _$v = other as _$ExportHelplyAttachmentDto;
  }

  @override
  void update(void Function(ExportHelplyAttachmentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportHelplyAttachmentDto build() => _build();

  _$ExportHelplyAttachmentDto _build() {
    final _$result =
        _$v ??
        _$ExportHelplyAttachmentDto._(
          fileName: BuiltValueNullFieldError.checkNotNull(
            fileName,
            r'ExportHelplyAttachmentDto',
            'fileName',
          ),
          sizeBytes: BuiltValueNullFieldError.checkNotNull(
            sizeBytes,
            r'ExportHelplyAttachmentDto',
            'sizeBytes',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'ExportHelplyAttachmentDto',
            'createdAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
