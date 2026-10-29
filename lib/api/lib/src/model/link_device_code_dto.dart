//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_device_code_dto.g.dart';

/// LinkDeviceCodeDto
///
/// Properties:
/// * [userCode] 
/// * [verificationUri] 
/// * [expiresAt] 
/// * [pollIntervalSeconds] 
@BuiltValue()
abstract class LinkDeviceCodeDto implements Built<LinkDeviceCodeDto, LinkDeviceCodeDtoBuilder> {
  @BuiltValueField(wireName: r'userCode')
  String get userCode;

  @BuiltValueField(wireName: r'verificationUri')
  String get verificationUri;

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'pollIntervalSeconds')
  int get pollIntervalSeconds;

  LinkDeviceCodeDto._();

  factory LinkDeviceCodeDto([void updates(LinkDeviceCodeDtoBuilder b)]) = _$LinkDeviceCodeDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkDeviceCodeDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkDeviceCodeDto> get serializer => _$LinkDeviceCodeDtoSerializer();
}

class _$LinkDeviceCodeDtoSerializer implements PrimitiveSerializer<LinkDeviceCodeDto> {
  @override
  final Iterable<Type> types = const [LinkDeviceCodeDto, _$LinkDeviceCodeDto];

  @override
  final String wireName = r'LinkDeviceCodeDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkDeviceCodeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userCode';
    yield serializers.serialize(
      object.userCode,
      specifiedType: const FullType(String),
    );
    yield r'verificationUri';
    yield serializers.serialize(
      object.verificationUri,
      specifiedType: const FullType(String),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'pollIntervalSeconds';
    yield serializers.serialize(
      object.pollIntervalSeconds,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkDeviceCodeDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkDeviceCodeDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userCode = valueDes;
          break;
        case r'verificationUri':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.verificationUri = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'pollIntervalSeconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pollIntervalSeconds = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkDeviceCodeDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkDeviceCodeDtoBuilder();
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

