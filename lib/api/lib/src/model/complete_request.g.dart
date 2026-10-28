// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CompleteRequest extends CompleteRequest {
  @override
  final String code;
  @override
  final BuiltList<Cookie>? sessionCookies;

  factory _$CompleteRequest([void Function(CompleteRequestBuilder)? updates]) =>
      (CompleteRequestBuilder()..update(updates))._build();

  _$CompleteRequest._({required this.code, this.sessionCookies}) : super._();
  @override
  CompleteRequest rebuild(void Function(CompleteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompleteRequestBuilder toBuilder() => CompleteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompleteRequest &&
        code == other.code &&
        sessionCookies == other.sessionCookies;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, sessionCookies.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompleteRequest')
          ..add('code', code)
          ..add('sessionCookies', sessionCookies))
        .toString();
  }
}

class CompleteRequestBuilder
    implements Builder<CompleteRequest, CompleteRequestBuilder> {
  _$CompleteRequest? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  ListBuilder<Cookie>? _sessionCookies;
  ListBuilder<Cookie> get sessionCookies =>
      _$this._sessionCookies ??= ListBuilder<Cookie>();
  set sessionCookies(ListBuilder<Cookie>? sessionCookies) =>
      _$this._sessionCookies = sessionCookies;

  CompleteRequestBuilder() {
    CompleteRequest._defaults(this);
  }

  CompleteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _sessionCookies = $v.sessionCookies?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompleteRequest other) {
    _$v = other as _$CompleteRequest;
  }

  @override
  void update(void Function(CompleteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompleteRequest build() => _build();

  _$CompleteRequest _build() {
    _$CompleteRequest _$result;
    try {
      _$result =
          _$v ??
          _$CompleteRequest._(
            code: BuiltValueNullFieldError.checkNotNull(
              code,
              r'CompleteRequest',
              'code',
            ),
            sessionCookies: _sessionCookies?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sessionCookies';
        _sessionCookies?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CompleteRequest',
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
