//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'linked_account_status_dto.g.dart';

class LinkedAccountStatusDto extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ok')
  static const LinkedAccountStatusDto ok = _$ok;
  @BuiltValueEnumConst(wireName: r'syncing')
  static const LinkedAccountStatusDto syncing = _$syncing;
  @BuiltValueEnumConst(wireName: r'expired')
  static const LinkedAccountStatusDto expired = _$expired;
  @BuiltValueEnumConst(wireName: r'error')
  static const LinkedAccountStatusDto error = _$error;

  static Serializer<LinkedAccountStatusDto> get serializer => _$linkedAccountStatusDtoSerializer;

  const LinkedAccountStatusDto._(String name): super(name);

  static BuiltSet<LinkedAccountStatusDto> get values => _$values;
  static LinkedAccountStatusDto valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class LinkedAccountStatusDtoMixin = Object with _$LinkedAccountStatusDtoMixin;

