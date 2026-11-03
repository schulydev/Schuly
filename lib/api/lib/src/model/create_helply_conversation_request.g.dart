// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_helply_conversation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateHelplyConversationRequest
    extends CreateHelplyConversationRequest {
  @override
  final String? title;

  factory _$CreateHelplyConversationRequest([
    void Function(CreateHelplyConversationRequestBuilder)? updates,
  ]) => (CreateHelplyConversationRequestBuilder()..update(updates))._build();

  _$CreateHelplyConversationRequest._({this.title}) : super._();
  @override
  CreateHelplyConversationRequest rebuild(
    void Function(CreateHelplyConversationRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateHelplyConversationRequestBuilder toBuilder() =>
      CreateHelplyConversationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateHelplyConversationRequest && title == other.title;
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
      r'CreateHelplyConversationRequest',
    )..add('title', title)).toString();
  }
}

class CreateHelplyConversationRequestBuilder
    implements
        Builder<
          CreateHelplyConversationRequest,
          CreateHelplyConversationRequestBuilder
        > {
  _$CreateHelplyConversationRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateHelplyConversationRequestBuilder() {
    CreateHelplyConversationRequest._defaults(this);
  }

  CreateHelplyConversationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateHelplyConversationRequest other) {
    _$v = other as _$CreateHelplyConversationRequest;
  }

  @override
  void update(void Function(CreateHelplyConversationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateHelplyConversationRequest build() => _build();

  _$CreateHelplyConversationRequest _build() {
    final _$result = _$v ?? _$CreateHelplyConversationRequest._(title: title);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
