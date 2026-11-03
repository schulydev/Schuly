// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helply_conversation_summary_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HelplyConversationSummaryDto extends HelplyConversationSummaryDto {
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

  factory _$HelplyConversationSummaryDto([
    void Function(HelplyConversationSummaryDtoBuilder)? updates,
  ]) => (HelplyConversationSummaryDtoBuilder()..update(updates))._build();

  _$HelplyConversationSummaryDto._({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.expiresAt,
  }) : super._();
  @override
  HelplyConversationSummaryDto rebuild(
    void Function(HelplyConversationSummaryDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  HelplyConversationSummaryDtoBuilder toBuilder() =>
      HelplyConversationSummaryDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HelplyConversationSummaryDto &&
        id == other.id &&
        title == other.title &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HelplyConversationSummaryDto')
          ..add('id', id)
          ..add('title', title)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class HelplyConversationSummaryDtoBuilder
    implements
        Builder<
          HelplyConversationSummaryDto,
          HelplyConversationSummaryDtoBuilder
        > {
  _$HelplyConversationSummaryDto? _$v;

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

  HelplyConversationSummaryDtoBuilder() {
    HelplyConversationSummaryDto._defaults(this);
  }

  HelplyConversationSummaryDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HelplyConversationSummaryDto other) {
    _$v = other as _$HelplyConversationSummaryDto;
  }

  @override
  void update(void Function(HelplyConversationSummaryDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HelplyConversationSummaryDto build() => _build();

  _$HelplyConversationSummaryDto _build() {
    final _$result =
        _$v ??
        _$HelplyConversationSummaryDto._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'HelplyConversationSummaryDto',
            'id',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'HelplyConversationSummaryDto',
            'title',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'HelplyConversationSummaryDto',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'HelplyConversationSummaryDto',
            'updatedAt',
          ),
          expiresAt: BuiltValueNullFieldError.checkNotNull(
            expiresAt,
            r'HelplyConversationSummaryDto',
            'expiresAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
