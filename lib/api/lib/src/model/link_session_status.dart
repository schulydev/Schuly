//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_session_status.g.dart';

class LinkSessionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const LinkSessionStatus active = _$active;
  @BuiltValueEnumConst(wireName: r'done')
  static const LinkSessionStatus done = _$done;
  @BuiltValueEnumConst(wireName: r'failed')
  static const LinkSessionStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'expired')
  static const LinkSessionStatus expired = _$expired;

  static Serializer<LinkSessionStatus> get serializer => _$linkSessionStatusSerializer;

  const LinkSessionStatus._(String name): super(name);

  static BuiltSet<LinkSessionStatus> get values => _$values;
  static LinkSessionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LinkSessionStatusMixin = Object with _$LinkSessionStatusMixin;

