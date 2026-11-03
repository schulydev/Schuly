//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_account_request.g.dart';

/// DeleteAccountRequest
///
/// Properties:
/// * [password] 
@BuiltValue()
abstract class DeleteAccountRequest implements Built<DeleteAccountRequest, DeleteAccountRequestBuilder> {
  @BuiltValueField(wireName: r'password')
  String? get password;

  DeleteAccountRequest._();

  factory DeleteAccountRequest([void updates(DeleteAccountRequestBuilder b)]) = _$DeleteAccountRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteAccountRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteAccountRequest> get serializer => _$DeleteAccountRequestSerializer();
}

class _$DeleteAccountRequestSerializer implements PrimitiveSerializer<DeleteAccountRequest> {
  @override
  final Iterable<Type> types = const [DeleteAccountRequest, _$DeleteAccountRequest];

  @override
  final String wireName = r'DeleteAccountRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield object.password == null ? null : serializers.serialize(
      object.password,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteAccountRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteAccountRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteAccountRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteAccountRequestBuilder();
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

