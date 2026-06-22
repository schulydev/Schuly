//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'school_system_login_field_dto.g.dart';

/// SchoolSystemLoginFieldDto
///
/// Properties:
/// * [key] 
/// * [label] 
/// * [type] 
/// * [placeholder] 
/// * [defaultValue] 
/// * [required_] 
@BuiltValue()
abstract class SchoolSystemLoginFieldDto implements Built<SchoolSystemLoginFieldDto, SchoolSystemLoginFieldDtoBuilder> {
  @BuiltValueField(wireName: r'key')
  String get key;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'placeholder')
  String? get placeholder;

  @BuiltValueField(wireName: r'defaultValue')
  String? get defaultValue;

  @BuiltValueField(wireName: r'required')
  bool? get required_;

  SchoolSystemLoginFieldDto._();

  factory SchoolSystemLoginFieldDto([void updates(SchoolSystemLoginFieldDtoBuilder b)]) = _$SchoolSystemLoginFieldDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SchoolSystemLoginFieldDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SchoolSystemLoginFieldDto> get serializer => _$SchoolSystemLoginFieldDtoSerializer();
}

class _$SchoolSystemLoginFieldDtoSerializer implements PrimitiveSerializer<SchoolSystemLoginFieldDto> {
  @override
  final Iterable<Type> types = const [SchoolSystemLoginFieldDto, _$SchoolSystemLoginFieldDto];

  @override
  final String wireName = r'SchoolSystemLoginFieldDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SchoolSystemLoginFieldDto object, {
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
      specifiedType: const FullType(String),
    );
    if (object.placeholder != null) {
      yield r'placeholder';
      yield serializers.serialize(
        object.placeholder,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.defaultValue != null) {
      yield r'defaultValue';
      yield serializers.serialize(
        object.defaultValue,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.required_ != null) {
      yield r'required';
      yield serializers.serialize(
        object.required_,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SchoolSystemLoginFieldDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SchoolSystemLoginFieldDtoBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SchoolSystemLoginFieldDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SchoolSystemLoginFieldDtoBuilder();
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

