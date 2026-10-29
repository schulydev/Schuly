// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_access_level.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const McpAccessLevel _$off = const McpAccessLevel._('off');
const McpAccessLevel _$read = const McpAccessLevel._('read');
const McpAccessLevel _$readWrite = const McpAccessLevel._('readWrite');

McpAccessLevel _$valueOf(String name) {
  switch (name) {
    case 'off':
      return _$off;
    case 'read':
      return _$read;
    case 'readWrite':
      return _$readWrite;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<McpAccessLevel> _$values = BuiltSet<McpAccessLevel>(
  const <McpAccessLevel>[_$off, _$read, _$readWrite],
);

class _$McpAccessLevelMeta {
  const _$McpAccessLevelMeta();
  McpAccessLevel get off => _$off;
  McpAccessLevel get read => _$read;
  McpAccessLevel get readWrite => _$readWrite;
  McpAccessLevel valueOf(String name) => _$valueOf(name);
  BuiltSet<McpAccessLevel> get values => _$values;
}

mixin _$McpAccessLevelMixin {
  // ignore: non_constant_identifier_names
  _$McpAccessLevelMeta get McpAccessLevel => const _$McpAccessLevelMeta();
}

Serializer<McpAccessLevel> _$mcpAccessLevelSerializer =
    _$McpAccessLevelSerializer();

class _$McpAccessLevelSerializer
    implements PrimitiveSerializer<McpAccessLevel> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'off': 'Off',
    'read': 'Read',
    'readWrite': 'ReadWrite',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Off': 'off',
    'Read': 'read',
    'ReadWrite': 'readWrite',
  };

  @override
  final Iterable<Type> types = const <Type>[McpAccessLevel];
  @override
  final String wireName = 'McpAccessLevel';

  @override
  Object serialize(
    Serializers serializers,
    McpAccessLevel object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  McpAccessLevel deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => McpAccessLevel.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
