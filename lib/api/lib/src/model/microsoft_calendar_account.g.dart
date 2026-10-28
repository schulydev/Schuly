// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microsoft_calendar_account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MicrosoftCalendarAccount extends MicrosoftCalendarAccount {
  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String status;
  @override
  final String? message;

  factory _$MicrosoftCalendarAccount([
    void Function(MicrosoftCalendarAccountBuilder)? updates,
  ]) => (MicrosoftCalendarAccountBuilder()..update(updates))._build();

  _$MicrosoftCalendarAccount._({
    required this.id,
    required this.email,
    this.displayName,
    required this.status,
    this.message,
  }) : super._();
  @override
  MicrosoftCalendarAccount rebuild(
    void Function(MicrosoftCalendarAccountBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MicrosoftCalendarAccountBuilder toBuilder() =>
      MicrosoftCalendarAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MicrosoftCalendarAccount &&
        id == other.id &&
        email == other.email &&
        displayName == other.displayName &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MicrosoftCalendarAccount')
          ..add('id', id)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class MicrosoftCalendarAccountBuilder
    implements
        Builder<MicrosoftCalendarAccount, MicrosoftCalendarAccountBuilder> {
  _$MicrosoftCalendarAccount? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MicrosoftCalendarAccountBuilder() {
    MicrosoftCalendarAccount._defaults(this);
  }

  MicrosoftCalendarAccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _displayName = $v.displayName;
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MicrosoftCalendarAccount other) {
    _$v = other as _$MicrosoftCalendarAccount;
  }

  @override
  void update(void Function(MicrosoftCalendarAccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MicrosoftCalendarAccount build() => _build();

  _$MicrosoftCalendarAccount _build() {
    final _$result =
        _$v ??
        _$MicrosoftCalendarAccount._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'MicrosoftCalendarAccount',
            'id',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'MicrosoftCalendarAccount',
            'email',
          ),
          displayName: displayName,
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'MicrosoftCalendarAccount',
            'status',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
