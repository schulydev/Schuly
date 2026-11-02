//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_redirect_mode_dto.g.dart';

class LinkRedirectModeDto extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hostCallback')
  static const LinkRedirectModeDto hostCallback = _$hostCallback;
  @BuiltValueEnumConst(wireName: r'capture')
  static const LinkRedirectModeDto capture = _$capture;

  static Serializer<LinkRedirectModeDto> get serializer => _$linkRedirectModeDtoSerializer;

  const LinkRedirectModeDto._(String name): super(name);

  static BuiltSet<LinkRedirectModeDto> get values => _$values;
  static LinkRedirectModeDto valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LinkRedirectModeDtoMixin = Object with _$LinkRedirectModeDtoMixin;

