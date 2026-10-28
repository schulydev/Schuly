// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microsoft_calendar_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MicrosoftCalendarEvent extends MicrosoftCalendarEvent {
  @override
  final String id;
  @override
  final String accountId;
  @override
  final String title;
  @override
  final String start;
  @override
  final String end;
  @override
  final bool isAllDay;
  @override
  final String? location;
  @override
  final String? organizer;
  @override
  final String? preview;
  @override
  final String? webLink;
  @override
  final String? joinUrl;
  @override
  final String? showAs;
  @override
  final bool isCancelled;

  factory _$MicrosoftCalendarEvent([
    void Function(MicrosoftCalendarEventBuilder)? updates,
  ]) => (MicrosoftCalendarEventBuilder()..update(updates))._build();

  _$MicrosoftCalendarEvent._({
    required this.id,
    required this.accountId,
    required this.title,
    required this.start,
    required this.end,
    required this.isAllDay,
    this.location,
    this.organizer,
    this.preview,
    this.webLink,
    this.joinUrl,
    this.showAs,
    required this.isCancelled,
  }) : super._();
  @override
  MicrosoftCalendarEvent rebuild(
    void Function(MicrosoftCalendarEventBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MicrosoftCalendarEventBuilder toBuilder() =>
      MicrosoftCalendarEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MicrosoftCalendarEvent &&
        id == other.id &&
        accountId == other.accountId &&
        title == other.title &&
        start == other.start &&
        end == other.end &&
        isAllDay == other.isAllDay &&
        location == other.location &&
        organizer == other.organizer &&
        preview == other.preview &&
        webLink == other.webLink &&
        joinUrl == other.joinUrl &&
        showAs == other.showAs &&
        isCancelled == other.isCancelled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, start.hashCode);
    _$hash = $jc(_$hash, end.hashCode);
    _$hash = $jc(_$hash, isAllDay.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, organizer.hashCode);
    _$hash = $jc(_$hash, preview.hashCode);
    _$hash = $jc(_$hash, webLink.hashCode);
    _$hash = $jc(_$hash, joinUrl.hashCode);
    _$hash = $jc(_$hash, showAs.hashCode);
    _$hash = $jc(_$hash, isCancelled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MicrosoftCalendarEvent')
          ..add('id', id)
          ..add('accountId', accountId)
          ..add('title', title)
          ..add('start', start)
          ..add('end', end)
          ..add('isAllDay', isAllDay)
          ..add('location', location)
          ..add('organizer', organizer)
          ..add('preview', preview)
          ..add('webLink', webLink)
          ..add('joinUrl', joinUrl)
          ..add('showAs', showAs)
          ..add('isCancelled', isCancelled))
        .toString();
  }
}

class MicrosoftCalendarEventBuilder
    implements Builder<MicrosoftCalendarEvent, MicrosoftCalendarEventBuilder> {
  _$MicrosoftCalendarEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _start;
  String? get start => _$this._start;
  set start(String? start) => _$this._start = start;

  String? _end;
  String? get end => _$this._end;
  set end(String? end) => _$this._end = end;

  bool? _isAllDay;
  bool? get isAllDay => _$this._isAllDay;
  set isAllDay(bool? isAllDay) => _$this._isAllDay = isAllDay;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _organizer;
  String? get organizer => _$this._organizer;
  set organizer(String? organizer) => _$this._organizer = organizer;

  String? _preview;
  String? get preview => _$this._preview;
  set preview(String? preview) => _$this._preview = preview;

  String? _webLink;
  String? get webLink => _$this._webLink;
  set webLink(String? webLink) => _$this._webLink = webLink;

  String? _joinUrl;
  String? get joinUrl => _$this._joinUrl;
  set joinUrl(String? joinUrl) => _$this._joinUrl = joinUrl;

  String? _showAs;
  String? get showAs => _$this._showAs;
  set showAs(String? showAs) => _$this._showAs = showAs;

  bool? _isCancelled;
  bool? get isCancelled => _$this._isCancelled;
  set isCancelled(bool? isCancelled) => _$this._isCancelled = isCancelled;

  MicrosoftCalendarEventBuilder() {
    MicrosoftCalendarEvent._defaults(this);
  }

  MicrosoftCalendarEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountId = $v.accountId;
      _title = $v.title;
      _start = $v.start;
      _end = $v.end;
      _isAllDay = $v.isAllDay;
      _location = $v.location;
      _organizer = $v.organizer;
      _preview = $v.preview;
      _webLink = $v.webLink;
      _joinUrl = $v.joinUrl;
      _showAs = $v.showAs;
      _isCancelled = $v.isCancelled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MicrosoftCalendarEvent other) {
    _$v = other as _$MicrosoftCalendarEvent;
  }

  @override
  void update(void Function(MicrosoftCalendarEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MicrosoftCalendarEvent build() => _build();

  _$MicrosoftCalendarEvent _build() {
    final _$result =
        _$v ??
        _$MicrosoftCalendarEvent._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'MicrosoftCalendarEvent',
            'id',
          ),
          accountId: BuiltValueNullFieldError.checkNotNull(
            accountId,
            r'MicrosoftCalendarEvent',
            'accountId',
          ),
          title: BuiltValueNullFieldError.checkNotNull(
            title,
            r'MicrosoftCalendarEvent',
            'title',
          ),
          start: BuiltValueNullFieldError.checkNotNull(
            start,
            r'MicrosoftCalendarEvent',
            'start',
          ),
          end: BuiltValueNullFieldError.checkNotNull(
            end,
            r'MicrosoftCalendarEvent',
            'end',
          ),
          isAllDay: BuiltValueNullFieldError.checkNotNull(
            isAllDay,
            r'MicrosoftCalendarEvent',
            'isAllDay',
          ),
          location: location,
          organizer: organizer,
          preview: preview,
          webLink: webLink,
          joinUrl: joinUrl,
          showAs: showAs,
          isCancelled: BuiltValueNullFieldError.checkNotNull(
            isCancelled,
            r'MicrosoftCalendarEvent',
            'isCancelled',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
