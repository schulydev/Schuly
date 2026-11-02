// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_redirect_mode_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LinkRedirectModeDto _$hostCallback = const LinkRedirectModeDto._(
  'hostCallback',
);
const LinkRedirectModeDto _$capture = const LinkRedirectModeDto._('capture');

LinkRedirectModeDto _$valueOf(String name) {
  switch (name) {
    case 'hostCallback':
      return _$hostCallback;
    case 'capture':
      return _$capture;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LinkRedirectModeDto> _$values = BuiltSet<LinkRedirectModeDto>(
  const <LinkRedirectModeDto>[_$hostCallback, _$capture],
);

class _$LinkRedirectModeDtoMeta {
  const _$LinkRedirectModeDtoMeta();
  LinkRedirectModeDto get hostCallback => _$hostCallback;
  LinkRedirectModeDto get capture => _$capture;
  LinkRedirectModeDto valueOf(String name) => _$valueOf(name);
  BuiltSet<LinkRedirectModeDto> get values => _$values;
}

mixin _$LinkRedirectModeDtoMixin {
  // ignore: non_constant_identifier_names
  _$LinkRedirectModeDtoMeta get LinkRedirectModeDto =>
      const _$LinkRedirectModeDtoMeta();
}

Serializer<LinkRedirectModeDto> _$linkRedirectModeDtoSerializer =
    _$LinkRedirectModeDtoSerializer();

class _$LinkRedirectModeDtoSerializer
    implements PrimitiveSerializer<LinkRedirectModeDto> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'hostCallback': 'hostCallback',
    'capture': 'capture',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'hostCallback': 'hostCallback',
    'capture': 'capture',
  };

  @override
  final Iterable<Type> types = const <Type>[LinkRedirectModeDto];
  @override
  final String wireName = 'LinkRedirectModeDto';

  @override
  Object serialize(
    Serializers serializers,
    LinkRedirectModeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LinkRedirectModeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LinkRedirectModeDto.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
