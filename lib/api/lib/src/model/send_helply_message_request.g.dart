// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_helply_message_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendHelplyMessageRequest extends SendHelplyMessageRequest {
  @override
  final String? text;
  @override
  final BuiltList<String>? attachmentIds;

  factory _$SendHelplyMessageRequest([
    void Function(SendHelplyMessageRequestBuilder)? updates,
  ]) => (SendHelplyMessageRequestBuilder()..update(updates))._build();

  _$SendHelplyMessageRequest._({this.text, this.attachmentIds}) : super._();
  @override
  SendHelplyMessageRequest rebuild(
    void Function(SendHelplyMessageRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendHelplyMessageRequestBuilder toBuilder() =>
      SendHelplyMessageRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendHelplyMessageRequest &&
        text == other.text &&
        attachmentIds == other.attachmentIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, attachmentIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendHelplyMessageRequest')
          ..add('text', text)
          ..add('attachmentIds', attachmentIds))
        .toString();
  }
}

class SendHelplyMessageRequestBuilder
    implements
        Builder<SendHelplyMessageRequest, SendHelplyMessageRequestBuilder> {
  _$SendHelplyMessageRequest? _$v;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  ListBuilder<String>? _attachmentIds;
  ListBuilder<String> get attachmentIds =>
      _$this._attachmentIds ??= ListBuilder<String>();
  set attachmentIds(ListBuilder<String>? attachmentIds) =>
      _$this._attachmentIds = attachmentIds;

  SendHelplyMessageRequestBuilder() {
    SendHelplyMessageRequest._defaults(this);
  }

  SendHelplyMessageRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _text = $v.text;
      _attachmentIds = $v.attachmentIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendHelplyMessageRequest other) {
    _$v = other as _$SendHelplyMessageRequest;
  }

  @override
  void update(void Function(SendHelplyMessageRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendHelplyMessageRequest build() => _build();

  _$SendHelplyMessageRequest _build() {
    _$SendHelplyMessageRequest _$result;
    try {
      _$result =
          _$v ??
          _$SendHelplyMessageRequest._(
            text: text,
            attachmentIds: _attachmentIds?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachmentIds';
        _attachmentIds?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SendHelplyMessageRequest',
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
