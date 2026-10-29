// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_step_kind_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LinkStepKindDto _$form = const LinkStepKindDto._('form');
const LinkStepKindDto _$otp = const LinkStepKindDto._('otp');
const LinkStepKindDto _$pushCode = const LinkStepKindDto._('pushCode');
const LinkStepKindDto _$deviceCode = const LinkStepKindDto._('deviceCode');
const LinkStepKindDto _$redirect = const LinkStepKindDto._('redirect');
const LinkStepKindDto _$select = const LinkStepKindDto._('select');
const LinkStepKindDto _$done = const LinkStepKindDto._('done');
const LinkStepKindDto _$error = const LinkStepKindDto._('error');

LinkStepKindDto _$valueOf(String name) {
  switch (name) {
    case 'form':
      return _$form;
    case 'otp':
      return _$otp;
    case 'pushCode':
      return _$pushCode;
    case 'deviceCode':
      return _$deviceCode;
    case 'redirect':
      return _$redirect;
    case 'select':
      return _$select;
    case 'done':
      return _$done;
    case 'error':
      return _$error;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LinkStepKindDto> _$values = BuiltSet<LinkStepKindDto>(
  const <LinkStepKindDto>[
    _$form,
    _$otp,
    _$pushCode,
    _$deviceCode,
    _$redirect,
    _$select,
    _$done,
    _$error,
  ],
);

class _$LinkStepKindDtoMeta {
  const _$LinkStepKindDtoMeta();
  LinkStepKindDto get form => _$form;
  LinkStepKindDto get otp => _$otp;
  LinkStepKindDto get pushCode => _$pushCode;
  LinkStepKindDto get deviceCode => _$deviceCode;
  LinkStepKindDto get redirect => _$redirect;
  LinkStepKindDto get select => _$select;
  LinkStepKindDto get done => _$done;
  LinkStepKindDto get error => _$error;
  LinkStepKindDto valueOf(String name) => _$valueOf(name);
  BuiltSet<LinkStepKindDto> get values => _$values;
}

mixin _$LinkStepKindDtoMixin {
  // ignore: non_constant_identifier_names
  _$LinkStepKindDtoMeta get LinkStepKindDto => const _$LinkStepKindDtoMeta();
}

Serializer<LinkStepKindDto> _$linkStepKindDtoSerializer =
    _$LinkStepKindDtoSerializer();

class _$LinkStepKindDtoSerializer
    implements PrimitiveSerializer<LinkStepKindDto> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'form': 'form',
    'otp': 'otp',
    'pushCode': 'pushCode',
    'deviceCode': 'deviceCode',
    'redirect': 'redirect',
    'select': 'select',
    'done': 'done',
    'error': 'error',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'form': 'form',
    'otp': 'otp',
    'pushCode': 'pushCode',
    'deviceCode': 'deviceCode',
    'redirect': 'redirect',
    'select': 'select',
    'done': 'done',
    'error': 'error',
  };

  @override
  final Iterable<Type> types = const <Type>[LinkStepKindDto];
  @override
  final String wireName = 'LinkStepKindDto';

  @override
  Object serialize(
    Serializers serializers,
    LinkStepKindDto object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LinkStepKindDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LinkStepKindDto.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
