//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_step_kind_dto.g.dart';

class LinkStepKindDto extends EnumClass {

  @BuiltValueEnumConst(wireName: r'form')
  static const LinkStepKindDto form = _$form;
  @BuiltValueEnumConst(wireName: r'otp')
  static const LinkStepKindDto otp = _$otp;
  @BuiltValueEnumConst(wireName: r'pushCode')
  static const LinkStepKindDto pushCode = _$pushCode;
  @BuiltValueEnumConst(wireName: r'deviceCode')
  static const LinkStepKindDto deviceCode = _$deviceCode;
  @BuiltValueEnumConst(wireName: r'redirect')
  static const LinkStepKindDto redirect = _$redirect;
  @BuiltValueEnumConst(wireName: r'select')
  static const LinkStepKindDto select = _$select;
  @BuiltValueEnumConst(wireName: r'done')
  static const LinkStepKindDto done = _$done;
  @BuiltValueEnumConst(wireName: r'error')
  static const LinkStepKindDto error = _$error;

  static Serializer<LinkStepKindDto> get serializer => _$linkStepKindDtoSerializer;

  const LinkStepKindDto._(String name): super(name);

  static BuiltSet<LinkStepKindDto> get values => _$values;
  static LinkStepKindDto valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LinkStepKindDtoMixin = Object with _$LinkStepKindDtoMixin;

