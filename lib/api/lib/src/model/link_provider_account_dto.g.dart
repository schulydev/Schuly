// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_provider_account_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkProviderAccountDto extends LinkProviderAccountDto {
  @override
  final String providerId;
  @override
  final String providerName;
  @override
  final String id;
  @override
  final String title;
  @override
  final String? detail;
  @override
  final LinkedAccountStatusDto status;
  @override
  final String? message;
  @override
  final DateTime? linkedAt;
  @override
  final DateTime? lastSyncedAt;
  @override
  final BuiltList<LinkCapabilityDto> capabilities;
  @override
  final bool canReauth;

  factory _$LinkProviderAccountDto([
    void Function(LinkProviderAccountDtoBuilder)? updates,
  ]) => (LinkProviderAccountDtoBuilder()..update(updates))._build();

  _$LinkProviderAccountDto._({
    required this.providerId,
    required this.providerName,
    required this.id,
    required this.title,
    this.detail,
    required this.status,
    this.message,
    this.linkedAt,
    this.lastSyncedAt,
    required this.capabilities,
    required this.canReauth,
  }) : super._();
  @override
  LinkProviderAccountDto rebuild(
    void Function(LinkProviderAccountDtoBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LinkProviderAccountDtoBuilder toBuilder() =>
      LinkProviderAccountDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkProviderAccountDto &&
        providerId == other.providerId &&
        providerName == other.providerName &&
        id == other.id &&
        title == other.title &&
        detail == other.detail &&
        status == other.status &&
        message == other.message &&
        linkedAt == other.linkedAt &&
        lastSyncedAt == other.lastSyncedAt &&
        capabilities == other.capabilities &&
        canReauth == other.canReauth;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, providerName.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, detail.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, linkedAt.hashCode);
    _$hash = $jc(_$hash, lastSyncedAt.hashCode);
    _$hash = $jc(_$hash, capabilities.hashCode);
    _$hash = $jc(_$hash, canReauth.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkProviderAccountDto')
          ..add('providerId', providerId)
          ..add('providerName', providerName)
          ..add('id', id)
          ..add('title', title)
          ..add('detail', detail)
          ..add('status', status)
          ..add('message', message)
          ..add('linkedAt', linkedAt)
          ..add('lastSyncedAt', lastSyncedAt)
          ..add('capabilities', capabilities)
          ..add('canReauth', canReauth))
        .toString();
  }
}

class LinkProviderAccountDtoBuilder
    implements Builder<LinkProviderAccountDto, LinkProviderAccountDtoBuilder> {
  _$LinkProviderAccountDto? _$v;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  String? _providerName;
  String? get providerName => _$this._providerName;
  set providerName(String? providerName) => _$this._providerName = providerName;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _detail;
  String? get detail => _$this._detail;
  set detail(String? detail) => _$this._detail = detail;

  LinkedAccountStatusDto? _status;
  LinkedAccountStatusDto? get status => _$this._status;
  set status(LinkedAccountStatusDto? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _linkedAt;
  DateTime? get linkedAt => _$this._linkedAt;
  set linkedAt(DateTime? linkedAt) => _$this._linkedAt = linkedAt;

  DateTime? _lastSyncedAt;
  DateTime? get lastSyncedAt => _$this._lastSyncedAt;
  set lastSyncedAt(DateTime? lastSyncedAt) =>
      _$this._lastSyncedAt = lastSyncedAt;

  ListBuilder<LinkCapabilityDto>? _capabilities;
  ListBuilder<LinkCapabilityDto> get capabilities =>
      _$this._capabilities ??= ListBuilder<LinkCapabilityDto>();
  set capabilities(ListBuilder<LinkCapabilityDto>? capabilities) =>
      _$this._capabilities = capabilities;

  bool? _canReauth;
  bool? get canReauth => _$this._canReauth;
  set canReauth(bool? canReauth) => _$this._canReauth = canReauth;

  LinkProviderAccountDtoBuilder() {
    LinkProviderAccountDto._defaults(this);
  }

  LinkProviderAccountDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _providerId = $v.providerId;
      _providerName = $v.providerName;
      _id = $v.id;
      _title = $v.title;
      _detail = $v.detail;
      _status = $v.status;
      _message = $v.message;
      _linkedAt = $v.linkedAt;
      _lastSyncedAt = $v.lastSyncedAt;
      _capabilities = $v.capabilities.toBuilder();
      _canReauth = $v.canReauth;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkProviderAccountDto other) {
    _$v = other as _$LinkProviderAccountDto;
  }

  @override
  void update(void Function(LinkProviderAccountDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkProviderAccountDto build() => _build();

  _$LinkProviderAccountDto _build() {
    _$LinkProviderAccountDto _$result;
    try {
      _$result =
          _$v ??
          _$LinkProviderAccountDto._(
            providerId: BuiltValueNullFieldError.checkNotNull(
              providerId,
              r'LinkProviderAccountDto',
              'providerId',
            ),
            providerName: BuiltValueNullFieldError.checkNotNull(
              providerName,
              r'LinkProviderAccountDto',
              'providerName',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'LinkProviderAccountDto',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'LinkProviderAccountDto',
              'title',
            ),
            detail: detail,
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'LinkProviderAccountDto',
              'status',
            ),
            message: message,
            linkedAt: linkedAt,
            lastSyncedAt: lastSyncedAt,
            capabilities: capabilities.build(),
            canReauth: BuiltValueNullFieldError.checkNotNull(
              canReauth,
              r'LinkProviderAccountDto',
              'canReauth',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'capabilities';
        capabilities.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'LinkProviderAccountDto',
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
