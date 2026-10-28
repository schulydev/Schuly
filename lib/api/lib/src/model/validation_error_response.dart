//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'validation_error_response.g.dart';

/// ValidationErrorResponse
///
/// Properties:
/// * [errors] 
@BuiltValue()
abstract class ValidationErrorResponse implements Built<ValidationErrorResponse, ValidationErrorResponseBuilder> {
  @BuiltValueField(wireName: r'errors')
  BuiltList<String> get errors;

  ValidationErrorResponse._();

  factory ValidationErrorResponse([void updates(ValidationErrorResponseBuilder b)]) = _$ValidationErrorResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ValidationErrorResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ValidationErrorResponse> get serializer => _$ValidationErrorResponseSerializer();
}

class _$ValidationErrorResponseSerializer implements PrimitiveSerializer<ValidationErrorResponse> {
  @override
  final Iterable<Type> types = const [ValidationErrorResponse, _$ValidationErrorResponse];

  @override
  final String wireName = r'ValidationErrorResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ValidationErrorResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ValidationErrorResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ValidationErrorResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.errors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ValidationErrorResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ValidationErrorResponseBuilder();
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

