// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odaorg_stateless_agenda_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OdaorgStatelessAgendaEvent extends OdaorgStatelessAgendaEvent {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? room;
  @override
  final String? comment;

  factory _$OdaorgStatelessAgendaEvent([
    void Function(OdaorgStatelessAgendaEventBuilder)? updates,
  ]) => (OdaorgStatelessAgendaEventBuilder()..update(updates))._build();

  _$OdaorgStatelessAgendaEvent._({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.room,
    this.comment,
  }) : super._();
  @override
  OdaorgStatelessAgendaEvent rebuild(
    void Function(OdaorgStatelessAgendaEventBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  OdaorgStatelessAgendaEventBuilder toBuilder() =>
      OdaorgStatelessAgendaEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OdaorgStatelessAgendaEvent &&
        id == other.id &&
        title == other.title &&
        startDate == other.startDate &&
        endDate == other.endDate &&
        room == other.room &&
        comment == other.comment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, endDate.hashCode);
    _$hash = $jc(_$hash, room.hashCode);
    _$hash = $jc(_$hash, comment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OdaorgStatelessAgendaEvent')
          ..add('id', id)
          ..add('title', title)
          ..add('startDate', startDate)
          ..add('endDate', endDate)
          ..add('room', room)
          ..add('comment', comment))
        .toString();
  }
}

class OdaorgStatelessAgendaEventBuilder
    implements
        Builder<OdaorgStatelessAgendaEvent, OdaorgStatelessAgendaEventBuilder> {
  _$OdaorgStatelessAgendaEvent? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _startDate;
  String? get startDate => _$this._startDate;
  set startDate(String? startDate) => _$this._startDate = startDate;

  String? _endDate;
  String? get endDate => _$this._endDate;
  set endDate(String? endDate) => _$this._endDate = endDate;

  String? _room;
  String? get room => _$this._room;
  set room(String? room) => _$this._room = room;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  OdaorgStatelessAgendaEventBuilder() {
    OdaorgStatelessAgendaEvent._defaults(this);
  }

  OdaorgStatelessAgendaEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _startDate = $v.startDate;
      _endDate = $v.endDate;
      _room = $v.room;
      _comment = $v.comment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OdaorgStatelessAgendaEvent other) {
    _$v = other as _$OdaorgStatelessAgendaEvent;
  }

  @override
  void update(void Function(OdaorgStatelessAgendaEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OdaorgStatelessAgendaEvent build() => _build();

  _$OdaorgStatelessAgendaEvent _build() {
    final _$result =
        _$v ??
        _$OdaorgStatelessAgendaEvent._(
          id: id,
          title: title,
          startDate: startDate,
          endDate: endDate,
          room: room,
          comment: comment,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
