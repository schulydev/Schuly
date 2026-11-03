// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_tag_header_value.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EntityTagHeaderValue extends EntityTagHeaderValue {
  @override
  final StringSegment? tag;
  @override
  final bool? isWeak;

  factory _$EntityTagHeaderValue([
    void Function(EntityTagHeaderValueBuilder)? updates,
  ]) => (EntityTagHeaderValueBuilder()..update(updates))._build();

  _$EntityTagHeaderValue._({this.tag, this.isWeak}) : super._();
  @override
  EntityTagHeaderValue rebuild(
    void Function(EntityTagHeaderValueBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  EntityTagHeaderValueBuilder toBuilder() =>
      EntityTagHeaderValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EntityTagHeaderValue &&
        tag == other.tag &&
        isWeak == other.isWeak;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tag.hashCode);
    _$hash = $jc(_$hash, isWeak.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EntityTagHeaderValue')
          ..add('tag', tag)
          ..add('isWeak', isWeak))
        .toString();
  }
}

class EntityTagHeaderValueBuilder
    implements Builder<EntityTagHeaderValue, EntityTagHeaderValueBuilder> {
  _$EntityTagHeaderValue? _$v;

  StringSegmentBuilder? _tag;
  StringSegmentBuilder get tag => _$this._tag ??= StringSegmentBuilder();
  set tag(StringSegmentBuilder? tag) => _$this._tag = tag;

  bool? _isWeak;
  bool? get isWeak => _$this._isWeak;
  set isWeak(bool? isWeak) => _$this._isWeak = isWeak;

  EntityTagHeaderValueBuilder() {
    EntityTagHeaderValue._defaults(this);
  }

  EntityTagHeaderValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tag = $v.tag?.toBuilder();
      _isWeak = $v.isWeak;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EntityTagHeaderValue other) {
    _$v = other as _$EntityTagHeaderValue;
  }

  @override
  void update(void Function(EntityTagHeaderValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EntityTagHeaderValue build() => _build();

  _$EntityTagHeaderValue _build() {
    _$EntityTagHeaderValue _$result;
    try {
      _$result =
          _$v ?? _$EntityTagHeaderValue._(tag: _tag?.build(), isWeak: isWeak);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tag';
        _tag?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EntityTagHeaderValue',
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
