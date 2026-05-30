//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/user_state.dart';
import 'package:schuly_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_school_user_command.g.dart';

/// UpdateSchoolUserCommand
///
/// Properties:
/// * [schoolUserId] 
/// * [firstName] 
/// * [lastName] 
/// * [email] 
/// * [privateEmail] 
/// * [phoneNumber] 
/// * [street] 
/// * [city] 
/// * [zip] 
/// * [leaveDate] 
/// * [state] 
/// * [profilePictureUrl] 
@BuiltValue()
abstract class UpdateSchoolUserCommand implements Built<UpdateSchoolUserCommand, UpdateSchoolUserCommandBuilder> {
  @BuiltValueField(wireName: r'schoolUserId')
  String get schoolUserId;

  @BuiltValueField(wireName: r'firstName')
  String? get firstName;

  @BuiltValueField(wireName: r'lastName')
  String? get lastName;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'privateEmail')
  String? get privateEmail;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: r'street')
  String? get street;

  @BuiltValueField(wireName: r'city')
  String? get city;

  @BuiltValueField(wireName: r'zip')
  String? get zip;

  @BuiltValueField(wireName: r'leaveDate')
  Date? get leaveDate;

  @BuiltValueField(wireName: r'state')
  UserState? get state;
  // enum stateEnum {  None,  Active,  Inactive,  };

  @BuiltValueField(wireName: r'profilePictureUrl')
  String? get profilePictureUrl;

  UpdateSchoolUserCommand._();

  factory UpdateSchoolUserCommand([void updates(UpdateSchoolUserCommandBuilder b)]) = _$UpdateSchoolUserCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSchoolUserCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSchoolUserCommand> get serializer => _$UpdateSchoolUserCommandSerializer();
}

class _$UpdateSchoolUserCommandSerializer implements PrimitiveSerializer<UpdateSchoolUserCommand> {
  @override
  final Iterable<Type> types = const [UpdateSchoolUserCommand, _$UpdateSchoolUserCommand];

  @override
  final String wireName = r'UpdateSchoolUserCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSchoolUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'schoolUserId';
    yield serializers.serialize(
      object.schoolUserId,
      specifiedType: const FullType(String),
    );
    yield r'firstName';
    yield object.firstName == null ? null : serializers.serialize(
      object.firstName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'lastName';
    yield object.lastName == null ? null : serializers.serialize(
      object.lastName,
      specifiedType: const FullType.nullable(String),
    );
    yield r'email';
    yield object.email == null ? null : serializers.serialize(
      object.email,
      specifiedType: const FullType.nullable(String),
    );
    yield r'privateEmail';
    yield object.privateEmail == null ? null : serializers.serialize(
      object.privateEmail,
      specifiedType: const FullType.nullable(String),
    );
    yield r'phoneNumber';
    yield object.phoneNumber == null ? null : serializers.serialize(
      object.phoneNumber,
      specifiedType: const FullType.nullable(String),
    );
    yield r'street';
    yield object.street == null ? null : serializers.serialize(
      object.street,
      specifiedType: const FullType.nullable(String),
    );
    yield r'city';
    yield object.city == null ? null : serializers.serialize(
      object.city,
      specifiedType: const FullType.nullable(String),
    );
    yield r'zip';
    yield object.zip == null ? null : serializers.serialize(
      object.zip,
      specifiedType: const FullType.nullable(String),
    );
    yield r'leaveDate';
    yield object.leaveDate == null ? null : serializers.serialize(
      object.leaveDate,
      specifiedType: const FullType.nullable(Date),
    );
    yield r'state';
    yield object.state == null ? null : serializers.serialize(
      object.state,
      specifiedType: const FullType.nullable(UserState),
    );
    if (object.profilePictureUrl != null) {
      yield r'profilePictureUrl';
      yield serializers.serialize(
        object.profilePictureUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateSchoolUserCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateSchoolUserCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'schoolUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolUserId = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.lastName = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.email = valueDes;
          break;
        case r'privateEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.privateEmail = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.phoneNumber = valueDes;
          break;
        case r'street':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.street = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.city = valueDes;
          break;
        case r'zip':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.zip = valueDes;
          break;
        case r'leaveDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.leaveDate = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UserState),
          ) as UserState?;
          if (valueDes == null) continue;
          result.state = valueDes;
          break;
        case r'profilePictureUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.profilePictureUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateSchoolUserCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSchoolUserCommandBuilder();
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

