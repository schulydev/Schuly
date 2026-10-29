// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_icon_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkIconDto extends LinkIconDto {
  @override
  final String? lucide;
  @override
  final String? svgUrl;

  factory _$LinkIconDto([void Function(LinkIconDtoBuilder)? updates]) =>
      (LinkIconDtoBuilder()..update(updates))._build();

  _$LinkIconDto._({this.lucide, this.svgUrl}) : super._();
  @override
  LinkIconDto rebuild(void Function(LinkIconDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkIconDtoBuilder toBuilder() => LinkIconDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkIconDto &&
        lucide == other.lucide &&
        svgUrl == other.svgUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, lucide.hashCode);
    _$hash = $jc(_$hash, svgUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkIconDto')
          ..add('lucide', lucide)
          ..add('svgUrl', svgUrl))
        .toString();
  }
}

class LinkIconDtoBuilder implements Builder<LinkIconDto, LinkIconDtoBuilder> {
  _$LinkIconDto? _$v;

  String? _lucide;
  String? get lucide => _$this._lucide;
  set lucide(String? lucide) => _$this._lucide = lucide;

  String? _svgUrl;
  String? get svgUrl => _$this._svgUrl;
  set svgUrl(String? svgUrl) => _$this._svgUrl = svgUrl;

  LinkIconDtoBuilder() {
    LinkIconDto._defaults(this);
  }

  LinkIconDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lucide = $v.lucide;
      _svgUrl = $v.svgUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkIconDto other) {
    _$v = other as _$LinkIconDto;
  }

  @override
  void update(void Function(LinkIconDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkIconDto build() => _build();

  _$LinkIconDto _build() {
    final _$result = _$v ?? _$LinkIconDto._(lucide: lucide, svgUrl: svgUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
