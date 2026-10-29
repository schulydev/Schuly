//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mcp_access_level.g.dart';

class McpAccessLevel extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Off')
  static const McpAccessLevel off = _$off;
  @BuiltValueEnumConst(wireName: r'Read')
  static const McpAccessLevel read = _$read;
  @BuiltValueEnumConst(wireName: r'ReadWrite')
  static const McpAccessLevel readWrite = _$readWrite;

  static Serializer<McpAccessLevel> get serializer => _$mcpAccessLevelSerializer;

  const McpAccessLevel._(String name): super(name);

  static BuiltSet<McpAccessLevel> get values => _$values;
  static McpAccessLevel valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class McpAccessLevelMixin = Object with _$McpAccessLevelMixin;

