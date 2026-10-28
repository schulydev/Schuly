// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microsoft_calendar_feed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MicrosoftCalendarFeed extends MicrosoftCalendarFeed {
  @override
  final BuiltList<MicrosoftCalendarAccount> accounts;
  @override
  final BuiltList<MicrosoftCalendarEvent> events;

  factory _$MicrosoftCalendarFeed([
    void Function(MicrosoftCalendarFeedBuilder)? updates,
  ]) => (MicrosoftCalendarFeedBuilder()..update(updates))._build();

  _$MicrosoftCalendarFeed._({required this.accounts, required this.events})
    : super._();
  @override
  MicrosoftCalendarFeed rebuild(
    void Function(MicrosoftCalendarFeedBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MicrosoftCalendarFeedBuilder toBuilder() =>
      MicrosoftCalendarFeedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MicrosoftCalendarFeed &&
        accounts == other.accounts &&
        events == other.events;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accounts.hashCode);
    _$hash = $jc(_$hash, events.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MicrosoftCalendarFeed')
          ..add('accounts', accounts)
          ..add('events', events))
        .toString();
  }
}

class MicrosoftCalendarFeedBuilder
    implements Builder<MicrosoftCalendarFeed, MicrosoftCalendarFeedBuilder> {
  _$MicrosoftCalendarFeed? _$v;

  ListBuilder<MicrosoftCalendarAccount>? _accounts;
  ListBuilder<MicrosoftCalendarAccount> get accounts =>
      _$this._accounts ??= ListBuilder<MicrosoftCalendarAccount>();
  set accounts(ListBuilder<MicrosoftCalendarAccount>? accounts) =>
      _$this._accounts = accounts;

  ListBuilder<MicrosoftCalendarEvent>? _events;
  ListBuilder<MicrosoftCalendarEvent> get events =>
      _$this._events ??= ListBuilder<MicrosoftCalendarEvent>();
  set events(ListBuilder<MicrosoftCalendarEvent>? events) =>
      _$this._events = events;

  MicrosoftCalendarFeedBuilder() {
    MicrosoftCalendarFeed._defaults(this);
  }

  MicrosoftCalendarFeedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accounts = $v.accounts.toBuilder();
      _events = $v.events.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MicrosoftCalendarFeed other) {
    _$v = other as _$MicrosoftCalendarFeed;
  }

  @override
  void update(void Function(MicrosoftCalendarFeedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MicrosoftCalendarFeed build() => _build();

  _$MicrosoftCalendarFeed _build() {
    _$MicrosoftCalendarFeed _$result;
    try {
      _$result =
          _$v ??
          _$MicrosoftCalendarFeed._(
            accounts: accounts.build(),
            events: events.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accounts';
        accounts.build();
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MicrosoftCalendarFeed',
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
