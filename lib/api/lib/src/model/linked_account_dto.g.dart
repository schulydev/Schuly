// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_account_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkedAccountDto extends LinkedAccountDto {
  @override
  final String? id;
  @override
  final String provider;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final DateTime? createdAt;

  factory _$LinkedAccountDto([
    void Function(LinkedAccountDtoBuilder)? updates,
  ]) => (LinkedAccountDtoBuilder()..update(updates))._build();

  _$LinkedAccountDto._({
    this.id,
    required this.provider,
    required this.email,
    this.displayName,
    this.createdAt,
  }) : super._();
  @override
  LinkedAccountDto rebuild(void Function(LinkedAccountDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkedAccountDtoBuilder toBuilder() =>
      LinkedAccountDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkedAccountDto &&
        id == other.id &&
        provider == other.provider &&
        email == other.email &&
        displayName == other.displayName &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkedAccountDto')
          ..add('id', id)
          ..add('provider', provider)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class LinkedAccountDtoBuilder
    implements Builder<LinkedAccountDto, LinkedAccountDtoBuilder> {
  _$LinkedAccountDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  LinkedAccountDtoBuilder() {
    LinkedAccountDto._defaults(this);
  }

  LinkedAccountDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _provider = $v.provider;
      _email = $v.email;
      _displayName = $v.displayName;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkedAccountDto other) {
    _$v = other as _$LinkedAccountDto;
  }

  @override
  void update(void Function(LinkedAccountDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkedAccountDto build() => _build();

  _$LinkedAccountDto _build() {
    final _$result =
        _$v ??
        _$LinkedAccountDto._(
          id: id,
          provider: BuiltValueNullFieldError.checkNotNull(
            provider,
            r'LinkedAccountDto',
            'provider',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'LinkedAccountDto',
            'email',
          ),
          displayName: displayName,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
