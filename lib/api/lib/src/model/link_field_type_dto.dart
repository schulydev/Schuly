//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_field_type_dto.g.dart';

class LinkFieldTypeDto extends EnumClass {

  @BuiltValueEnumConst(wireName: r'text')
  static const LinkFieldTypeDto text = _$text;
  @BuiltValueEnumConst(wireName: r'email')
  static const LinkFieldTypeDto email = _$email;
  @BuiltValueEnumConst(wireName: r'password')
  static const LinkFieldTypeDto password = _$password;
  @BuiltValueEnumConst(wireName: r'select')
  static const LinkFieldTypeDto select = _$select;
  @BuiltValueEnumConst(wireName: r'url')
  static const LinkFieldTypeDto url = _$url;
  @BuiltValueEnumConst(wireName: r'totpSecret')
  static const LinkFieldTypeDto totpSecret = _$totpSecret;

  static Serializer<LinkFieldTypeDto> get serializer => _$linkFieldTypeDtoSerializer;

  const LinkFieldTypeDto._(String name): super(name);

  static BuiltSet<LinkFieldTypeDto> get values => _$values;
  static LinkFieldTypeDto valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LinkFieldTypeDtoMixin = Object with _$LinkFieldTypeDtoMixin;

