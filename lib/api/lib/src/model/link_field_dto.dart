//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/link_option_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/link_field_type_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_field_dto.g.dart';

/// LinkFieldDto
///
/// Properties:
/// * [key] 
/// * [label] 
/// * [type] 
/// * [placeholder] 
/// * [help] 
/// * [defaultValue] 
/// * [required_] 
/// * [secret] 
/// * [maxLength] 
/// * [pattern] 
/// * [options] 
/// * [allowCustom] 
@BuiltValue()
abstract class LinkFieldDto implements Built<LinkFieldDto, LinkFieldDtoBuilder> {
  @BuiltValueField(wireName: r'key')
  String get key;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'type')
  LinkFieldTypeDto get type;
  // enum typeEnum {  text,  email,  password,  select,  url,  totpSecret,  };

  @BuiltValueField(wireName: r'placeholder')
  String? get placeholder;

  @BuiltValueField(wireName: r'help')
  String? get help;

  @BuiltValueField(wireName: r'defaultValue')
  String? get defaultValue;

  @BuiltValueField(wireName: r'required')
  bool get required_;

  @BuiltValueField(wireName: r'secret')
  bool get secret;

  @BuiltValueField(wireName: r'maxLength')
  int? get maxLength;

  @BuiltValueField(wireName: r'pattern')
  String? get pattern;

  @BuiltValueField(wireName: r'options')
  BuiltList<LinkOptionDto> get options;

  @BuiltValueField(wireName: r'allowCustom')
  bool get allowCustom;

  LinkFieldDto._();

  factory LinkFieldDto([void updates(LinkFieldDtoBuilder b)]) = _$LinkFieldDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkFieldDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkFieldDto> get serializer => _$LinkFieldDtoSerializer();
}

class _$LinkFieldDtoSerializer implements PrimitiveSerializer<LinkFieldDto> {
  @override
  final Iterable<Type> types = const [LinkFieldDto, _$LinkFieldDto];

  @override
  final String wireName = r'LinkFieldDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkFieldDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(String),
    );
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(LinkFieldTypeDto),
    );
    yield r'placeholder';
    yield object.placeholder == null ? null : serializers.serialize(
      object.placeholder,
      specifiedType: const FullType.nullable(String),
    );
    yield r'help';
    yield object.help == null ? null : serializers.serialize(
      object.help,
      specifiedType: const FullType.nullable(String),
    );
    yield r'defaultValue';
    yield object.defaultValue == null ? null : serializers.serialize(
      object.defaultValue,
      specifiedType: const FullType.nullable(String),
    );
    yield r'required';
    yield serializers.serialize(
      object.required_,
      specifiedType: const FullType(bool),
    );
    yield r'secret';
    yield serializers.serialize(
      object.secret,
      specifiedType: const FullType(bool),
    );
    yield r'maxLength';
    yield object.maxLength == null ? null : serializers.serialize(
      object.maxLength,
      specifiedType: const FullType.nullable(int),
    );
    yield r'pattern';
    yield object.pattern == null ? null : serializers.serialize(
      object.pattern,
      specifiedType: const FullType.nullable(String),
    );
    yield r'options';
    yield serializers.serialize(
      object.options,
      specifiedType: const FullType(BuiltList, [FullType(LinkOptionDto)]),
    );
    yield r'allowCustom';
    yield serializers.serialize(
      object.allowCustom,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkFieldDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkFieldDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.key = valueDes;
          break;
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkFieldTypeDto),
          ) as LinkFieldTypeDto;
          result.type = valueDes;
          break;
        case r'placeholder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.placeholder = valueDes;
          break;
        case r'help':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.help = valueDes;
          break;
        case r'defaultValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.defaultValue = valueDes;
          break;
        case r'required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.required_ = valueDes;
          break;
        case r'secret':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.secret = valueDes;
          break;
        case r'maxLength':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.maxLength = valueDes;
          break;
        case r'pattern':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pattern = valueDes;
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkOptionDto)]),
          ) as BuiltList<LinkOptionDto>;
          result.options.replace(valueDes);
          break;
        case r'allowCustom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allowCustom = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkFieldDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkFieldDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

