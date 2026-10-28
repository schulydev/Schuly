//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_my_school_command.g.dart';

/// CreateMySchoolCommand
///
/// Properties:
/// * [schoolName] 
/// * [firstName] 
/// * [lastName] 
@BuiltValue()
abstract class CreateMySchoolCommand implements Built<CreateMySchoolCommand, CreateMySchoolCommandBuilder> {
  @BuiltValueField(wireName: r'schoolName')
  String get schoolName;

  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  CreateMySchoolCommand._();

  factory CreateMySchoolCommand([void updates(CreateMySchoolCommandBuilder b)]) = _$CreateMySchoolCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateMySchoolCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateMySchoolCommand> get serializer => _$CreateMySchoolCommandSerializer();
}

class _$CreateMySchoolCommandSerializer implements PrimitiveSerializer<CreateMySchoolCommand> {
  @override
  final Iterable<Type> types = const [CreateMySchoolCommand, _$CreateMySchoolCommand];

  @override
  final String wireName = r'CreateMySchoolCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateMySchoolCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'schoolName';
    yield serializers.serialize(
      object.schoolName,
      specifiedType: const FullType(String),
    );
    yield r'firstName';
    yield serializers.serialize(
      object.firstName,
      specifiedType: const FullType(String),
    );
    yield r'lastName';
    yield serializers.serialize(
      object.lastName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateMySchoolCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateMySchoolCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'schoolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.schoolName = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateMySchoolCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateMySchoolCommandBuilder();
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

