//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'change_email_request.g.dart';

/// ChangeEmailRequest
///
/// Properties:
/// * [newEmail] 
/// * [currentPassword] 
@BuiltValue()
abstract class ChangeEmailRequest implements Built<ChangeEmailRequest, ChangeEmailRequestBuilder> {
  @BuiltValueField(wireName: r'newEmail')
  String get newEmail;

  @BuiltValueField(wireName: r'currentPassword')
  String get currentPassword;

  ChangeEmailRequest._();

  factory ChangeEmailRequest([void updates(ChangeEmailRequestBuilder b)]) = _$ChangeEmailRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChangeEmailRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChangeEmailRequest> get serializer => _$ChangeEmailRequestSerializer();
}

class _$ChangeEmailRequestSerializer implements PrimitiveSerializer<ChangeEmailRequest> {
  @override
  final Iterable<Type> types = const [ChangeEmailRequest, _$ChangeEmailRequest];

  @override
  final String wireName = r'ChangeEmailRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChangeEmailRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newEmail';
    yield serializers.serialize(
      object.newEmail,
      specifiedType: const FullType(String),
    );
    yield r'currentPassword';
    yield serializers.serialize(
      object.currentPassword,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChangeEmailRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChangeEmailRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newEmail = valueDes;
          break;
        case r'currentPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ChangeEmailRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChangeEmailRequestBuilder();
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

