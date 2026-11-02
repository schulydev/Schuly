// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_error_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkErrorDto extends LinkErrorDto {
  @override
  final String message;
  @override
  final BuiltList<String>? errors;

  factory _$LinkErrorDto([void Function(LinkErrorDtoBuilder)? updates]) =>
      (LinkErrorDtoBuilder()..update(updates))._build();

  _$LinkErrorDto._({required this.message, this.errors}) : super._();
  @override
  LinkErrorDto rebuild(void Function(LinkErrorDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkErrorDtoBuilder toBuilder() => LinkErrorDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkErrorDto &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkErrorDto')
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class LinkErrorDtoBuilder
    implements Builder<LinkErrorDto, LinkErrorDtoBuilder> {
  _$LinkErrorDto? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors => _$this._errors ??= ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  LinkErrorDtoBuilder() {
    LinkErrorDto._defaults(this);
  }

  LinkErrorDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _errors = $v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkErrorDto other) {
    _$v = other as _$LinkErrorDto;
  }

  @override
  void update(void Function(LinkErrorDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkErrorDto build() => _build();

  _$LinkErrorDto _build() {
    _$LinkErrorDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkErrorDto._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'LinkErrorDto',
              'message',
            ),
            errors: _errors?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkErrorDto',
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
