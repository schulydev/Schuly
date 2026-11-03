// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_conversation_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyConversationDto extends HelplyConversationDto {
  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime expiresAt;
  @override
  final BuiltList<HelplyMessageDto> messages;
  @override
  final BuiltList<HelplyApprovalRequestDto> pendingApprovals;

  factory _$HelplyConversationDto([
    void Function(HelplyConversationDtoBuilder)? updates,
  ]) => (HelplyConversationDtoBuilder()..update(updates))._build();

  _$HelplyConversationDto._({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
    required this.messages,
    required this.pendingApprovals,
  }) : super._();
  @override
  HelplyConversationDto rebuild(
    void Function(HelplyConversationDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyConversationDtoBuilder toBuilder() =>
      HelplyConversationDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyConversationDto &&
        id == other.id &&
        title == other.title &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        expiresAt == other.expiresAt &&
        messages == other.messages &&
        pendingApprovals == other.pendingApprovals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, pendingApprovals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyConversationDto')
          ..add('id', id)
          ..add('title', title)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('expiresAt', expiresAt)
          ..add('messages', messages)
          ..add('pendingApprovals', pendingApprovals))
        .toString();
  }
}

class HelplyConversationDtoBuilder
    implements Builder<HelplyConversationDto, HelplyConversationDtoBuilder> {
  _$HelplyConversationDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  ListBuilder<HelplyMessageDto>? _messages;
  ListBuilder<HelplyMessageDto> get messages =>
      _$this._messages ??= ListBuilder<HelplyMessageDto>();
  set messages(ListBuilder<HelplyMessageDto>? messages) =>
      _$this._messages = messages;

  ListBuilder<HelplyApprovalRequestDto>? _pendingApprovals;
  ListBuilder<HelplyApprovalRequestDto> get pendingApprovals =>
      _$this._pendingApprovals ??= ListBuilder<HelplyApprovalRequestDto>();
  set pendingApprovals(
    ListBuilder<HelplyApprovalRequestDto>? pendingApprovals,
  ) => _$this._pendingApprovals = pendingApprovals;

  HelplyConversationDtoBuilder() {
    HelplyConversationDto._defaults(this);
  }

  HelplyConversationDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _expiresAt = $v.expiresAt;
      _messages = $v.messages.toBuilder();
      _pendingApprovals = $v.pendingApprovals.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyConversationDto other) {
    _$v = other as _$HelplyConversationDto;
  }

  @override
  void update(void Function(HelplyConversationDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyConversationDto build() => _build();

  _$HelplyConversationDto _build() {
    _$HelplyConversationDto _$result;
    try {
      _$result =
          _$v ??
          _$HelplyConversationDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'HelplyConversationDto',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'HelplyConversationDto',
              'title',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'HelplyConversationDto',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'HelplyConversationDto',
              'updatedAt',
            ),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
              expiresAt,
              r'HelplyConversationDto',
              'expiresAt',
            ),
            messages: messages.build(),
            pendingApprovals: pendingApprovals.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'messages';
        messages.build();
        _$failedField = 'pendingApprovals';
        pendingApprovals.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HelplyConversationDto',
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
