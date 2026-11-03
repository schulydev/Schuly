//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/export_external_login_dto.dart';
import 'package:schuly_api/src/model/export_passkey_dto.dart';
import 'package:schuly_api/src/model/export_session_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_sign_in_dto.g.dart';

/// ExportSignInDto
///
/// Properties:
/// * [userName] 
/// * [email] 
/// * [emailConfirmedAt] 
/// * [lastSeenAt] 
/// * [twoFactorEnabled] 
/// * [externalLogins] 
/// * [passkeys] 
/// * [sessions] 
/// * [trustedDevices] 
@BuiltValue()
abstract class ExportSignInDto implements Built<ExportSignInDto, ExportSignInDtoBuilder> {
  @BuiltValueField(wireName: r'userName')
  String? get userName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'emailConfirmedAt')
  DateTime? get emailConfirmedAt;

  @BuiltValueField(wireName: r'lastSeenAt')
  DateTime? get lastSeenAt;

  @BuiltValueField(wireName: r'twoFactorEnabled')
  bool get twoFactorEnabled;

  @BuiltValueField(wireName: r'externalLogins')
  BuiltList<ExportExternalLoginDto> get externalLogins;

  @BuiltValueField(wireName: r'passkeys')
  BuiltList<ExportPasskeyDto> get passkeys;

  @BuiltValueField(wireName: r'sessions')
  BuiltList<ExportSessionDto> get sessions;

  @BuiltValueField(wireName: r'trustedDevices')
  BuiltList<ExportSessionDto> get trustedDevices;

  ExportSignInDto._();

  factory ExportSignInDto([void updates(ExportSignInDtoBuilder b)]) = _$ExportSignInDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportSignInDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportSignInDto> get serializer => _$ExportSignInDtoSerializer();
}

class _$ExportSignInDtoSerializer implements PrimitiveSerializer<ExportSignInDto> {
  @override
  final Iterable<Type> types = const [ExportSignInDto, _$ExportSignInDto];

  @override
  final String wireName = r'ExportSignInDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportSignInDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userName';
    yield object.userName == null ? null : serializers.serialize(
      object.userName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
    yield r'emailConfirmedAt';
    yield object.emailConfirmedAt == null ? null : serializers.serialize(
      object.emailConfirmedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'lastSeenAt';
    yield object.lastSeenAt == null ? null : serializers.serialize(
      object.lastSeenAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'twoFactorEnabled';
    yield serializers.serialize(
      object.twoFactorEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'externalLogins';
    yield serializers.serialize(
      object.externalLogins,
      specifiedType: const FullType(BuiltList, [FullType(ExportExternalLoginDto)]),
    );
    yield r'passkeys';
    yield serializers.serialize(
      object.passkeys,
      specifiedType: const FullType(BuiltList, [FullType(ExportPasskeyDto)]),
    );
    yield r'sessions';
    yield serializers.serialize(
      object.sessions,
      specifiedType: const FullType(BuiltList, [FullType(ExportSessionDto)]),
    );
    yield r'trustedDevices';
    yield serializers.serialize(
      object.trustedDevices,
      specifiedType: const FullType(BuiltList, [FullType(ExportSessionDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportSignInDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportSignInDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userName = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'emailConfirmedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.emailConfirmedAt = valueDes;
          break;
        case r'lastSeenAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSeenAt = valueDes;
          break;
        case r'twoFactorEnabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.twoFactorEnabled = valueDes;
          break;
        case r'externalLogins':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportExternalLoginDto)]),
          ) as BuiltList<ExportExternalLoginDto>;
          result.externalLogins.replace(valueDes);
          break;
        case r'passkeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportPasskeyDto)]),
          ) as BuiltList<ExportPasskeyDto>;
          result.passkeys.replace(valueDes);
          break;
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportSessionDto)]),
          ) as BuiltList<ExportSessionDto>;
          result.sessions.replace(valueDes);
          break;
        case r'trustedDevices':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportSessionDto)]),
          ) as BuiltList<ExportSessionDto>;
          result.trustedDevices.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportSignInDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportSignInDtoBuilder();
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

