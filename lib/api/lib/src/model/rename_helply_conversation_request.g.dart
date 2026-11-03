// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rename_helply_conversation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RenameHelplyConversationRequest
    extends RenameHelplyConversationRequest {
  @override
  final String? title;

  factory _$RenameHelplyConversationRequest([
    void Function(RenameHelplyConversationRequestBuilder)? updates,
  ]) => (RenameHelplyConversationRequestBuilder()..update(updates))._build();

  _$RenameHelplyConversationRequest._({this.title}) : super._();
  @override
  RenameHelplyConversationRequest rebuild(
    void Function(RenameHelplyConversationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  RenameHelplyConversationRequestBuilder toBuilder() =>
      RenameHelplyConversationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RenameHelplyConversationRequest && title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'RenameHelplyConversationRequest',
    )..add('title', title)).toString();
  }
}

class RenameHelplyConversationRequestBuilder
    implements
        Builder<
          RenameHelplyConversationRequest,
          RenameHelplyConversationRequestBuilder
        > {
  _$RenameHelplyConversationRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  RenameHelplyConversationRequestBuilder() {
    RenameHelplyConversationRequest._defaults(this);
  }

  RenameHelplyConversationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RenameHelplyConversationRequest other) {
    _$v = other as _$RenameHelplyConversationRequest;
  }

  @override
  void update(void Function(RenameHelplyConversationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RenameHelplyConversationRequest build() => _build();

  _$RenameHelplyConversationRequest _build() {
    final _$result = _$v ?? _$RenameHelplyConversationRequest._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
