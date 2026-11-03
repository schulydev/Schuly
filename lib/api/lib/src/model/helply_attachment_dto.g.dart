// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_attachment_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyAttachmentDto extends HelplyAttachmentDto {
  @override
  final String id;
  @override
  final String fileName;
  @override
  final String mediaType;
  @override
  final int sizeBytes;

  factory _$HelplyAttachmentDto([
    void Function(HelplyAttachmentDtoBuilder)? updates,
  ]) => (HelplyAttachmentDtoBuilder()..update(updates))._build();

  _$HelplyAttachmentDto._({
    required this.id,
    required this.fileName,
    required this.mediaType,
    required this.sizeBytes,
  }) : super._();
  @override
  HelplyAttachmentDto rebuild(
    void Function(HelplyAttachmentDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyAttachmentDtoBuilder toBuilder() =>
      HelplyAttachmentDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyAttachmentDto &&
        id == other.id &&
        fileName == other.fileName &&
        mediaType == other.mediaType &&
        sizeBytes == other.sizeBytes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, mediaType.hashCode);
    _$hash = $jc(_$hash, sizeBytes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyAttachmentDto')
          ..add('id', id)
          ..add('fileName', fileName)
          ..add('mediaType', mediaType)
          ..add('sizeBytes', sizeBytes))
        .toString();
  }
}

class HelplyAttachmentDtoBuilder
    implements Builder<HelplyAttachmentDto, HelplyAttachmentDtoBuilder> {
  _$HelplyAttachmentDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  String? _mediaType;
  String? get mediaType => _$this._mediaType;
  set mediaType(String? mediaType) => _$this._mediaType = mediaType;

  int? _sizeBytes;
  int? get sizeBytes => _$this._sizeBytes;
  set sizeBytes(int? sizeBytes) => _$this._sizeBytes = sizeBytes;

  HelplyAttachmentDtoBuilder() {
    HelplyAttachmentDto._defaults(this);
  }

  HelplyAttachmentDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _fileName = $v.fileName;
      _mediaType = $v.mediaType;
      _sizeBytes = $v.sizeBytes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyAttachmentDto other) {
    _$v = other as _$HelplyAttachmentDto;
  }

  @override
  void update(void Function(HelplyAttachmentDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyAttachmentDto build() => _build();

  _$HelplyAttachmentDto _build() {
    final _$result =
        _$v ??
        _$HelplyAttachmentDto._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'HelplyAttachmentDto',
            'id',
          ),
          fileName: BuiltValueNullFieldError.checkNotNull(
            fileName,
            r'HelplyAttachmentDto',
            'fileName',
          ),
          mediaType: BuiltValueNullFieldError.checkNotNull(
            mediaType,
            r'HelplyAttachmentDto',
            'mediaType',
          ),
          sizeBytes: BuiltValueNullFieldError.checkNotNull(
            sizeBytes,
            r'HelplyAttachmentDto',
            'sizeBytes',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
