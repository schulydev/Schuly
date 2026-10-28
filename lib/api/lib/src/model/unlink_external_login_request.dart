//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unlink_external_login_request.g.dart';

/// UnlinkExternalLoginRequest
///
/// Properties:
/// * [currentPassword] 
/// * [code] 
@BuiltValue()
abstract class UnlinkExternalLoginRequest implements Built<UnlinkExternalLoginRequest, UnlinkExternalLoginRequestBuilder> {
  @BuiltValueField(wireName: r'currentPassword')
  String? get currentPassword;

  @BuiltValueField(wireName: r'code')
  String? get code;

  UnlinkExternalLoginRequest._();

  factory UnlinkExternalLoginRequest([void updates(UnlinkExternalLoginRequestBuilder b)]) = _$UnlinkExternalLoginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnlinkExternalLoginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnlinkExternalLoginRequest> get serializer => _$UnlinkExternalLoginRequestSerializer();
}

class _$UnlinkExternalLoginRequestSerializer implements PrimitiveSerializer<UnlinkExternalLoginRequest> {
  @override
  final Iterable<Type> types = const [UnlinkExternalLoginRequest, _$UnlinkExternalLoginRequest];

  @override
  final String wireName = r'UnlinkExternalLoginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnlinkExternalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.currentPassword != null) {
      yield r'currentPassword';
      yield serializers.serialize(
        object.currentPassword,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UnlinkExternalLoginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnlinkExternalLoginRequestBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.code = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UnlinkExternalLoginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnlinkExternalLoginRequestBuilder();
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

