//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'microsoft_calendar_account.g.dart';

/// MicrosoftCalendarAccount
///
/// Properties:
/// * [id] 
/// * [email] 
/// * [displayName] 
/// * [status] 
/// * [message] 
@BuiltValue()
abstract class MicrosoftCalendarAccount implements Built<MicrosoftCalendarAccount, MicrosoftCalendarAccountBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'displayName')
  String? get displayName;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'message')
  String? get message;

  MicrosoftCalendarAccount._();

  factory MicrosoftCalendarAccount([void updates(MicrosoftCalendarAccountBuilder b)]) = _$MicrosoftCalendarAccount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MicrosoftCalendarAccountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MicrosoftCalendarAccount> get serializer => _$MicrosoftCalendarAccountSerializer();
}

class _$MicrosoftCalendarAccountSerializer implements PrimitiveSerializer<MicrosoftCalendarAccount> {
  @override
  final Iterable<Type> types = const [MicrosoftCalendarAccount, _$MicrosoftCalendarAccount];

  @override
  final String wireName = r'MicrosoftCalendarAccount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MicrosoftCalendarAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'displayName';
    yield object.displayName == null ? null : serializers.serialize(
      object.displayName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'message';
    yield object.message == null ? null : serializers.serialize(
      object.message,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MicrosoftCalendarAccount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MicrosoftCalendarAccountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.displayName = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MicrosoftCalendarAccount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MicrosoftCalendarAccountBuilder();
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

