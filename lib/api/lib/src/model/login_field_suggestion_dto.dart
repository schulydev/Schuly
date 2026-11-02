//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_field_suggestion_dto.g.dart';

/// LoginFieldSuggestionDto
///
/// Properties:
/// * [label] 
/// * [value] 
@BuiltValue()
abstract class LoginFieldSuggestionDto implements Built<LoginFieldSuggestionDto, LoginFieldSuggestionDtoBuilder> {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'value')
  String get value;

  LoginFieldSuggestionDto._();

  factory LoginFieldSuggestionDto([void updates(LoginFieldSuggestionDtoBuilder b)]) = _$LoginFieldSuggestionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginFieldSuggestionDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginFieldSuggestionDto> get serializer => _$LoginFieldSuggestionDtoSerializer();
}

class _$LoginFieldSuggestionDtoSerializer implements PrimitiveSerializer<LoginFieldSuggestionDto> {
  @override
  final Iterable<Type> types = const [LoginFieldSuggestionDto, _$LoginFieldSuggestionDto];

  @override
  final String wireName = r'LoginFieldSuggestionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginFieldSuggestionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginFieldSuggestionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginFieldSuggestionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginFieldSuggestionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginFieldSuggestionDtoBuilder();
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

