// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_done_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkDoneDto extends LinkDoneDto {
  @override
  final String accountId;
  @override
  final String? title;

  factory _$LinkDoneDto([void Function(LinkDoneDtoBuilder)? updates]) =>
      (LinkDoneDtoBuilder()..update(updates))._build();

  _$LinkDoneDto._({required this.accountId, this.title}) : super._();
  @override
  LinkDoneDto rebuild(void Function(LinkDoneDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkDoneDtoBuilder toBuilder() => LinkDoneDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkDoneDto &&
        accountId == other.accountId &&
        title == other.title;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkDoneDto')
          ..add('accountId', accountId)
          ..add('title', title))
        .toString();
  }
}

class LinkDoneDtoBuilder implements Builder<LinkDoneDto, LinkDoneDtoBuilder> {
  _$LinkDoneDto? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  LinkDoneDtoBuilder() {
    LinkDoneDto._defaults(this);
  }

  LinkDoneDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _title = $v.title;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkDoneDto other) {
    _$v = other as _$LinkDoneDto;
  }

  @override
  void update(void Function(LinkDoneDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkDoneDto build() => _build();

  _$LinkDoneDto _build() {
    final _$result =
        _$v ??
        _$LinkDoneDto._(
          accountId: BuiltValueNullFieldError.checkNotNull(
            accountId,
            r'LinkDoneDto',
            'accountId',
          ),
          title: title,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
