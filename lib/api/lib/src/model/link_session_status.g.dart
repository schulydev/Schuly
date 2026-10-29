// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_session_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const LinkSessionStatus _$active = const LinkSessionStatus._('active');
const LinkSessionStatus _$done = const LinkSessionStatus._('done');
const LinkSessionStatus _$failed = const LinkSessionStatus._('failed');
const LinkSessionStatus _$expired = const LinkSessionStatus._('expired');

LinkSessionStatus _$valueOf(String name) {
  switch (name) {
    case 'active':
      return _$active;
    case 'done':
      return _$done;
    case 'failed':
      return _$failed;
    case 'expired':
      return _$expired;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<LinkSessionStatus> _$values = BuiltSet<LinkSessionStatus>(
  const <LinkSessionStatus>[_$active, _$done, _$failed, _$expired],
);

class _$LinkSessionStatusMeta {
  const _$LinkSessionStatusMeta();
  LinkSessionStatus get active => _$active;
  LinkSessionStatus get done => _$done;
  LinkSessionStatus get failed => _$failed;
  LinkSessionStatus get expired => _$expired;
  LinkSessionStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<LinkSessionStatus> get values => _$values;
}

mixin _$LinkSessionStatusMixin {
  // ignore: non_constant_identifier_names
  _$LinkSessionStatusMeta get LinkSessionStatus =>
      const _$LinkSessionStatusMeta();
}

Serializer<LinkSessionStatus> _$linkSessionStatusSerializer =
    _$LinkSessionStatusSerializer();

class _$LinkSessionStatusSerializer
    implements PrimitiveSerializer<LinkSessionStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
    'done': 'done',
    'failed': 'failed',
    'expired': 'expired',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
    'done': 'done',
    'failed': 'failed',
    'expired': 'expired',
  };

  @override
  final Iterable<Type> types = const <Type>[LinkSessionStatus];
  @override
  final String wireName = 'LinkSessionStatus';

  @override
  Object serialize(
    Serializers serializers,
    LinkSessionStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  LinkSessionStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => LinkSessionStatus.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
