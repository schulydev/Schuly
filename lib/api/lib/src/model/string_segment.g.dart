// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_segment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StringSegment extends StringSegment {
  @override
  final String? buffer;
  @override
  final int? offset;
  @override
  final int? length;
  @override
  final String? value;
  @override
  final bool? hasValue;

  factory _$StringSegment([void Function(StringSegmentBuilder)? updates]) =>
      (StringSegmentBuilder()..update(updates))._build();

  _$StringSegment._({
    this.buffer,
    this.offset,
    this.length,
    this.value,
    this.hasValue,
  }) : super._();
  @override
  StringSegment rebuild(void Function(StringSegmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StringSegmentBuilder toBuilder() => StringSegmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StringSegment &&
        buffer == other.buffer &&
        offset == other.offset &&
        length == other.length &&
        value == other.value &&
        hasValue == other.hasValue;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, buffer.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jc(_$hash, length.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, hasValue.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StringSegment')
          ..add('buffer', buffer)
          ..add('offset', offset)
          ..add('length', length)
          ..add('value', value)
          ..add('hasValue', hasValue))
        .toString();
  }
}

class StringSegmentBuilder
    implements Builder<StringSegment, StringSegmentBuilder> {
  _$StringSegment? _$v;

  String? _buffer;
  String? get buffer => _$this._buffer;
  set buffer(String? buffer) => _$this._buffer = buffer;

  int? _offset;
  int? get offset => _$this._offset;
  set offset(int? offset) => _$this._offset = offset;

  int? _length;
  int? get length => _$this._length;
  set length(int? length) => _$this._length = length;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  bool? _hasValue;
  bool? get hasValue => _$this._hasValue;
  set hasValue(bool? hasValue) => _$this._hasValue = hasValue;

  StringSegmentBuilder() {
    StringSegment._defaults(this);
  }

  StringSegmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _buffer = $v.buffer;
      _offset = $v.offset;
      _length = $v.length;
      _value = $v.value;
      _hasValue = $v.hasValue;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StringSegment other) {
    _$v = other as _$StringSegment;
  }

  @override
  void update(void Function(StringSegmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StringSegment build() => _build();

  _$StringSegment _build() {
    final _$result =
        _$v ??
        _$StringSegment._(
          buffer: buffer,
          offset: offset,
          length: length,
          value: value,
          hasValue: hasValue,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
