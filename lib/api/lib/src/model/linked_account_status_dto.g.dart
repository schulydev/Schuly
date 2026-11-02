// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_account_status_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LinkedAccountStatusDto _$ok = const LinkedAccountStatusDto._('ok');
const LinkedAccountStatusDto _$syncing = const LinkedAccountStatusDto._(
  'syncing',
);
const LinkedAccountStatusDto _$expired = const LinkedAccountStatusDto._(
  'expired',
);
const LinkedAccountStatusDto _$error = const LinkedAccountStatusDto._('error');

LinkedAccountStatusDto _$valueOf(String name) {
  switch (name) {
    case 'ok':
      return _$ok;
    case 'syncing':
      return _$syncing;
    case 'expired':
      return _$expired;
    case 'error':
      return _$error;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LinkedAccountStatusDto> _$values =
    BuiltSet<LinkedAccountStatusDto>(const <LinkedAccountStatusDto>[
      _$ok,
      _$syncing,
      _$expired,
      _$error,
    ]);

class _$LinkedAccountStatusDtoMeta {
  const _$LinkedAccountStatusDtoMeta();
  LinkedAccountStatusDto get ok => _$ok;
  LinkedAccountStatusDto get syncing => _$syncing;
  LinkedAccountStatusDto get expired => _$expired;
  LinkedAccountStatusDto get error => _$error;
  LinkedAccountStatusDto valueOf(String name) => _$valueOf(name);
  BuiltSet<LinkedAccountStatusDto> get values => _$values;
}

mixin _$LinkedAccountStatusDtoMixin {
  // ignore: non_constant_identifier_names
  _$LinkedAccountStatusDtoMeta get LinkedAccountStatusDto =>
      const _$LinkedAccountStatusDtoMeta();
}

Serializer<LinkedAccountStatusDto> _$linkedAccountStatusDtoSerializer =
    _$LinkedAccountStatusDtoSerializer();

class _$LinkedAccountStatusDtoSerializer
    implements PrimitiveSerializer<LinkedAccountStatusDto> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ok': 'ok',
    'syncing': 'syncing',
    'expired': 'expired',
    'error': 'error',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ok': 'ok',
    'syncing': 'syncing',
    'expired': 'expired',
    'error': 'error',
  };

  @override
  final Iterable<Type> types = const <Type>[LinkedAccountStatusDto];
  @override
  final String wireName = 'LinkedAccountStatusDto';

  @override
  Object serialize(
    Serializers serializers,
    LinkedAccountStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LinkedAccountStatusDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LinkedAccountStatusDto.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
