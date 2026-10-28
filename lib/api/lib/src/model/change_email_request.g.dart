// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangeEmailRequest extends ChangeEmailRequest {
  @override
  final String newEmail;
  @override
  final String currentPassword;

  factory _$ChangeEmailRequest([
    void Function(ChangeEmailRequestBuilder)? updates,
  ]) => (ChangeEmailRequestBuilder()..update(updates))._build();

  _$ChangeEmailRequest._({
    required this.newEmail,
    required this.currentPassword,
  }) : super._();
  @override
  ChangeEmailRequest rebuild(
    void Function(ChangeEmailRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangeEmailRequestBuilder toBuilder() =>
      ChangeEmailRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeEmailRequest &&
        newEmail == other.newEmail &&
        currentPassword == other.currentPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newEmail.hashCode);
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeEmailRequest')
          ..add('newEmail', newEmail)
          ..add('currentPassword', currentPassword))
        .toString();
  }
}

class ChangeEmailRequestBuilder
    implements Builder<ChangeEmailRequest, ChangeEmailRequestBuilder> {
  _$ChangeEmailRequest? _$v;

  String? _newEmail;
  String? get newEmail => _$this._newEmail;
  set newEmail(String? newEmail) => _$this._newEmail = newEmail;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  ChangeEmailRequestBuilder() {
    ChangeEmailRequest._defaults(this);
  }

  ChangeEmailRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newEmail = $v.newEmail;
      _currentPassword = $v.currentPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeEmailRequest other) {
    _$v = other as _$ChangeEmailRequest;
  }

  @override
  void update(void Function(ChangeEmailRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeEmailRequest build() => _build();

  _$ChangeEmailRequest _build() {
    final _$result =
        _$v ??
        _$ChangeEmailRequest._(
          newEmail: BuiltValueNullFieldError.checkNotNull(
            newEmail,
            r'ChangeEmailRequest',
            'newEmail',
          ),
          currentPassword: BuiltValueNullFieldError.checkNotNull(
            currentPassword,
            r'ChangeEmailRequest',
            'currentPassword',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
