// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_message_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyMessageDto extends HelplyMessageDto {
  @override
  final String id;
  @override
  final String role;
  @override
  final String text;
  @override
  final DateTime createdAt;
  @override
  final BuiltList<HelplyToolActivityDto> tools;
  @override
  final bool failed;
  @override
  final BuiltList<HelplyAttachmentDto> attachments;

  factory _$HelplyMessageDto([
    void Function(HelplyMessageDtoBuilder)? updates,
  ]) => (HelplyMessageDtoBuilder()..update(updates))._build();

  _$HelplyMessageDto._({
    required this.id,
    required this.role,
    required this.text,
    required this.createdAt,
    required this.tools,
    required this.failed,
    required this.attachments,
  }) : super._();
  @override
  HelplyMessageDto rebuild(void Function(HelplyMessageDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HelplyMessageDtoBuilder toBuilder() =>
      HelplyMessageDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyMessageDto &&
        id == other.id &&
        role == other.role &&
        text == other.text &&
        createdAt == other.createdAt &&
        tools == other.tools &&
        failed == other.failed &&
        attachments == other.attachments;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, tools.hashCode);
    _$hash = $jc(_$hash, failed.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyMessageDto')
          ..add('id', id)
          ..add('role', role)
          ..add('text', text)
          ..add('createdAt', createdAt)
          ..add('tools', tools)
          ..add('failed', failed)
          ..add('attachments', attachments))
        .toString();
  }
}

class HelplyMessageDtoBuilder
    implements Builder<HelplyMessageDto, HelplyMessageDtoBuilder> {
  _$HelplyMessageDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<HelplyToolActivityDto>? _tools;
  ListBuilder<HelplyToolActivityDto> get tools =>
      _$this._tools ??= ListBuilder<HelplyToolActivityDto>();
  set tools(ListBuilder<HelplyToolActivityDto>? tools) => _$this._tools = tools;

  bool? _failed;
  bool? get failed => _$this._failed;
  set failed(bool? failed) => _$this._failed = failed;

  ListBuilder<HelplyAttachmentDto>? _attachments;
  ListBuilder<HelplyAttachmentDto> get attachments =>
      _$this._attachments ??= ListBuilder<HelplyAttachmentDto>();
  set attachments(ListBuilder<HelplyAttachmentDto>? attachments) =>
      _$this._attachments = attachments;

  HelplyMessageDtoBuilder() {
    HelplyMessageDto._defaults(this);
  }

  HelplyMessageDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _role = $v.role;
      _text = $v.text;
      _createdAt = $v.createdAt;
      _tools = $v.tools.toBuilder();
      _failed = $v.failed;
      _attachments = $v.attachments.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyMessageDto other) {
    _$v = other as _$HelplyMessageDto;
  }

  @override
  void update(void Function(HelplyMessageDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyMessageDto build() => _build();

  _$HelplyMessageDto _build() {
    _$HelplyMessageDto _$result;
    try {
      _$result =
          _$v ??
          _$HelplyMessageDto._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'HelplyMessageDto',
              'id',
            ),
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'HelplyMessageDto',
              'role',
            ),
            text: BuiltValueNullFieldError.checkNotNull(
              text,
              r'HelplyMessageDto',
              'text',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'HelplyMessageDto',
              'createdAt',
            ),
            tools: tools.build(),
            failed: BuiltValueNullFieldError.checkNotNull(
              failed,
              r'HelplyMessageDto',
              'failed',
            ),
            attachments: attachments.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tools';
        tools.build();

        _$failedField = 'attachments';
        attachments.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HelplyMessageDto',
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
