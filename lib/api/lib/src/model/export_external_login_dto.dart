//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_external_login_dto.g.dart';

/// ExportExternalLoginDto
///
/// Properties:
/// * [providerKey] 
/// * [email] 
/// * [createdAt] 
/// * [lastSignInAt] 
@BuiltValue()
abstract class ExportExternalLoginDto implements Built<ExportExternalLoginDto, ExportExternalLoginDtoBuilder> {
  @BuiltValueField(wireName: r'providerKey')
  String get providerKey;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'createdAt')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'lastSignInAt')
  DateTime? get lastSignInAt;

  ExportExternalLoginDto._();

  factory ExportExternalLoginDto([void updates(ExportExternalLoginDtoBuilder b)]) = _$ExportExternalLoginDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportExternalLoginDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportExternalLoginDto> get serializer => _$ExportExternalLoginDtoSerializer();
}

class _$ExportExternalLoginDtoSerializer implements PrimitiveSerializer<ExportExternalLoginDto> {
  @override
  final Iterable<Type> types = const [ExportExternalLoginDto, _$ExportExternalLoginDto];

  @override
  final String wireName = r'ExportExternalLoginDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportExternalLoginDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'providerKey';
    yield serializers.serialize(
      object.providerKey,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
    yield r'createdAt';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'lastSignInAt';
    yield object.lastSignInAt == null ? null : serializers.serialize(
      object.lastSignInAt,
      specifiedType: const FullType.nullable(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportExternalLoginDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportExternalLoginDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'providerKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerKey = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'lastSignInAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSignInAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportExternalLoginDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportExternalLoginDtoBuilder();
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

