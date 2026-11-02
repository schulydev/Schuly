// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_field_type_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LinkFieldTypeDto _$text = const LinkFieldTypeDto._('text');
const LinkFieldTypeDto _$email = const LinkFieldTypeDto._('email');
const LinkFieldTypeDto _$password = const LinkFieldTypeDto._('password');
const LinkFieldTypeDto _$select = const LinkFieldTypeDto._('select');
const LinkFieldTypeDto _$url = const LinkFieldTypeDto._('url');
const LinkFieldTypeDto _$totpSecret = const LinkFieldTypeDto._('totpSecret');

LinkFieldTypeDto _$valueOf(String name) {
  switch (name) {
    case 'text':
      return _$text;
    case 'email':
      return _$email;
    case 'password':
      return _$password;
    case 'select':
      return _$select;
    case 'url':
      return _$url;
    case 'totpSecret':
      return _$totpSecret;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LinkFieldTypeDto> _$values = BuiltSet<LinkFieldTypeDto>(
  const <LinkFieldTypeDto>[
    _$text,
    _$email,
    _$password,
    _$select,
    _$url,
    _$totpSecret,
  ],
);

class _$LinkFieldTypeDtoMeta {
  const _$LinkFieldTypeDtoMeta();
  LinkFieldTypeDto get text => _$text;
  LinkFieldTypeDto get email => _$email;
  LinkFieldTypeDto get password => _$password;
  LinkFieldTypeDto get select => _$select;
  LinkFieldTypeDto get url => _$url;
  LinkFieldTypeDto get totpSecret => _$totpSecret;
  LinkFieldTypeDto valueOf(String name) => _$valueOf(name);
  BuiltSet<LinkFieldTypeDto> get values => _$values;
}

mixin _$LinkFieldTypeDtoMixin {
  // ignore: non_constant_identifier_names
  _$LinkFieldTypeDtoMeta get LinkFieldTypeDto => const _$LinkFieldTypeDtoMeta();
}

Serializer<LinkFieldTypeDto> _$linkFieldTypeDtoSerializer =
    _$LinkFieldTypeDtoSerializer();

class _$LinkFieldTypeDtoSerializer
    implements PrimitiveSerializer<LinkFieldTypeDto> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'text': 'text',
    'email': 'email',
    'password': 'password',
    'select': 'select',
    'url': 'url',
    'totpSecret': 'totpSecret',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'text': 'text',
    'email': 'email',
    'password': 'password',
    'select': 'select',
    'url': 'url',
    'totpSecret': 'totpSecret',
  };

  @override
  final Iterable<Type> types = const <Type>[LinkFieldTypeDto];
  @override
  final String wireName = 'LinkFieldTypeDto';

  @override
  Object serialize(
    Serializers serializers,
    LinkFieldTypeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LinkFieldTypeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LinkFieldTypeDto.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
