// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_helply_conversation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportHelplyConversationDto extends ExportHelplyConversationDto {
  @override
  final String id;
  @override
  final String title;
  @override
  final JsonObject? messages;
  @override
  final String? modelHistory;
  @override
  final DateTime lastActivityAt;
  @override
  final DateTime expiresAt;
  @override
  final BuiltList<ExportHelplyAttachmentDto> attachments;

  factory _$ExportHelplyConversationDto([
    void Function(ExportHelplyConversationDtoBuilder)? updates,
  ]) => (ExportHelplyConversationDtoBuilder()..update(updates))._build();

  _$ExportHelplyConversationDto._({
    required this.id,
    required this.title,
    this.messages,
    this.modelHistory,
    required this.lastActivityAt,
    required this.expiresAt,
    required this.attachments,
  }) : super._();
  @override
  ExportHelplyConversationDto rebuild(
    void Function(ExportHelplyConversationDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ExportHelplyConversationDtoBuilder toBuilder() =>
      ExportHelplyConversationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportHelplyConversationDto &&
        id == other.id &&
        title == other.title &&
        messages == other.messages &&
        modelHistory == other.modelHistory &&
        lastActivityAt == other.lastActivityAt &&
        expiresAt == other.expiresAt &&
        attachments == other.attachments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, modelHistory.hashCode);
    _$hash = $jc(_$hash, lastActivityAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportHelplyConversationDto')
          ..add('id', id)
          ..add('title', title)
          ..add('messages', messages)
          ..add('modelHistory', modelHistory)
          ..add('lastActivityAt', lastActivityAt)
          ..add('expiresAt', expiresAt)
          ..add('attachments', attachments))
        .toString();
  }
}

class ExportHelplyConversationDtoBuilder
    implements
        Builder<
          ExportHelplyConversationDto,
          ExportHelplyConversationDtoBuilder
        > {
  _$ExportHelplyConversationDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  JsonObject? _messages;
  JsonObject? get messages => _$this._messages;
  set messages(JsonObject? messages) => _$this._messages = messages;

  String? _modelHistory;
  String? get modelHistory => _$this._modelHistory;
  set modelHistory(String? modelHistory) => _$this._modelHistory = modelHistory;

  DateTime? _lastActivityAt;
  DateTime? get lastActivityAt => _$this._lastActivityAt;
  set lastActivityAt(DateTime? lastActivityAt) =>
      _$this._lastActivityAt = lastActivityAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  ListBuilder<ExportHelplyAttachmentDto>? _attachments;
  ListBuilder<ExportHelplyAttachmentDto> get attachments =>
      _$this._attachments ??= ListBuilder<ExportHelplyAttachmentDto>();
  set attachments(ListBuilder<ExportHelplyAttachmentDto>? attachments) =>
      _$this._attachments = attachments;

  ExportHelplyConversationDtoBuilder() {
    ExportHelplyConversationDto._defaults(this);
  }

  ExportHelplyConversationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _messages = $v.messages;
      _modelHistory = $v.modelHistory;
      _lastActivityAt = $v.lastActivityAt;
      _expiresAt = $v.expiresAt;
      _attachments = $v.attachments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportHelplyConversationDto other) {
    _$v = other as _$ExportHelplyConversationDto;
  }

  @override
  void update(void Function(ExportHelplyConversationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportHelplyConversationDto build() => _build();

  _$ExportHelplyConversationDto _build() {
    _$ExportHelplyConversationDto _$result;
    try {
      _$result =
          _$v ??
          _$ExportHelplyConversationDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'ExportHelplyConversationDto',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'ExportHelplyConversationDto',
              'title',
            ),
            messages: messages,
            modelHistory: modelHistory,
            lastActivityAt: BuiltValueNullFieldError.checkNotNull(
              lastActivityAt,
              r'ExportHelplyConversationDto',
              'lastActivityAt',
            ),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt,
              r'ExportHelplyConversationDto',
              'expiresAt',
            ),
            attachments: attachments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        attachments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ExportHelplyConversationDto',
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
