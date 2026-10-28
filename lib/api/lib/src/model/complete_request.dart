//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/cookie.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'complete_request.g.dart';

/// CompleteRequest
///
/// Properties:
/// * [code] 
/// * [sessionCookies] 
@BuiltValue()
abstract class CompleteRequest implements Built<CompleteRequest, CompleteRequestBuilder> {
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'sessionCookies')
  BuiltList<Cookie>? get sessionCookies;

  CompleteRequest._();

  factory CompleteRequest([void updates(CompleteRequestBuilder b)]) = _$CompleteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompleteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompleteRequest> get serializer => _$CompleteRequestSerializer();
}

class _$CompleteRequestSerializer implements PrimitiveSerializer<CompleteRequest> {
  @override
  final Iterable<Type> types = const [CompleteRequest, _$CompleteRequest];

  @override
  final String wireName = r'CompleteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompleteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'sessionCookies';
    yield object.sessionCookies == null ? null : serializers.serialize(
      object.sessionCookies,
      specifiedType: const FullType.nullable(BuiltList, [FullType(Cookie)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CompleteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompleteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'sessionCookies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(Cookie)]),
          ) as BuiltList<Cookie>?;
          if (valueDes == null) continue;
          result.sessionCookies.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CompleteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompleteRequestBuilder();
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

