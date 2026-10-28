//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'begin_two_factor_request.g.dart';

/// BeginTwoFactorRequest
///
/// Properties:
/// * [currentPassword] 
@BuiltValue()
abstract class BeginTwoFactorRequest implements Built<BeginTwoFactorRequest, BeginTwoFactorRequestBuilder> {
  @BuiltValueField(wireName: r'currentPassword')
  String? get currentPassword;

  BeginTwoFactorRequest._();

  factory BeginTwoFactorRequest([void updates(BeginTwoFactorRequestBuilder b)]) = _$BeginTwoFactorRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BeginTwoFactorRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BeginTwoFactorRequest> get serializer => _$BeginTwoFactorRequestSerializer();
}

class _$BeginTwoFactorRequestSerializer implements PrimitiveSerializer<BeginTwoFactorRequest> {
  @override
  final Iterable<Type> types = const [BeginTwoFactorRequest, _$BeginTwoFactorRequest];

  @override
  final String wireName = r'BeginTwoFactorRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BeginTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.currentPassword != null) {
      yield r'currentPassword';
      yield serializers.serialize(
        object.currentPassword,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BeginTwoFactorRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BeginTwoFactorRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentPassword = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BeginTwoFactorRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BeginTwoFactorRequestBuilder();
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

