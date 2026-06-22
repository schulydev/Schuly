//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/school_system_login_field_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_school_system_command.g.dart';

/// CreateSchoolSystemCommand
///
/// Properties:
/// * [key] 
/// * [displayName] 
/// * [loginMethod] 
/// * [logoUrl] 
/// * [schulwareApiBaseUrl] 
/// * [statelessBasePath] 
/// * [pluginBasePath] 
/// * [enabled] 
/// * [sortOrder] 
/// * [loginFields] 
@BuiltValue()
abstract class CreateSchoolSystemCommand implements Built<CreateSchoolSystemCommand, CreateSchoolSystemCommandBuilder> {
  @BuiltValueField(wireName: r'key')
  String get key;

  @BuiltValueField(wireName: r'displayName')
  String get displayName;

  @BuiltValueField(wireName: r'loginMethod')
  String get loginMethod;

  @BuiltValueField(wireName: r'logoUrl')
  String? get logoUrl;

  @BuiltValueField(wireName: r'schulwareApiBaseUrl')
  String? get schulwareApiBaseUrl;

  @BuiltValueField(wireName: r'statelessBasePath')
  String? get statelessBasePath;

  @BuiltValueField(wireName: r'pluginBasePath')
  String? get pluginBasePath;

  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  @BuiltValueField(wireName: r'sortOrder')
  int? get sortOrder;

  @BuiltValueField(wireName: r'loginFields')
  BuiltList<SchoolSystemLoginFieldDto>? get loginFields;

  CreateSchoolSystemCommand._();

  factory CreateSchoolSystemCommand([void updates(CreateSchoolSystemCommandBuilder b)]) = _$CreateSchoolSystemCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateSchoolSystemCommandBuilder b) => b
      ..enabled = true
      ..sortOrder = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateSchoolSystemCommand> get serializer => _$CreateSchoolSystemCommandSerializer();
}

class _$CreateSchoolSystemCommandSerializer implements PrimitiveSerializer<CreateSchoolSystemCommand> {
  @override
  final Iterable<Type> types = const [CreateSchoolSystemCommand, _$CreateSchoolSystemCommand];

  @override
  final String wireName = r'CreateSchoolSystemCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateSchoolSystemCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(String),
    );
    yield r'displayName';
    yield serializers.serialize(
      object.displayName,
      specifiedType: const FullType(String),
    );
    yield r'loginMethod';
    yield serializers.serialize(
      object.loginMethod,
      specifiedType: const FullType(String),
    );
    if (object.logoUrl != null) {
      yield r'logoUrl';
      yield serializers.serialize(
        object.logoUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.schulwareApiBaseUrl != null) {
      yield r'schulwareApiBaseUrl';
      yield serializers.serialize(
        object.schulwareApiBaseUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.statelessBasePath != null) {
      yield r'statelessBasePath';
      yield serializers.serialize(
        object.statelessBasePath,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.pluginBasePath != null) {
      yield r'pluginBasePath';
      yield serializers.serialize(
        object.pluginBasePath,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
    if (object.sortOrder != null) {
      yield r'sortOrder';
      yield serializers.serialize(
        object.sortOrder,
        specifiedType: const FullType(int),
      );
    }
    if (object.loginFields != null) {
      yield r'loginFields';
      yield serializers.serialize(
        object.loginFields,
        specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolSystemLoginFieldDto)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateSchoolSystemCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateSchoolSystemCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.key = valueDes;
          break;
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.displayName = valueDes;
          break;
        case r'loginMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.loginMethod = valueDes;
          break;
        case r'logoUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.logoUrl = valueDes;
          break;
        case r'schulwareApiBaseUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.schulwareApiBaseUrl = valueDes;
          break;
        case r'statelessBasePath':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.statelessBasePath = valueDes;
          break;
        case r'pluginBasePath':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pluginBasePath = valueDes;
          break;
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        case r'loginFields':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(SchoolSystemLoginFieldDto)]),
          ) as BuiltList<SchoolSystemLoginFieldDto>?;
          if (valueDes == null) continue;
          result.loginFields.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateSchoolSystemCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateSchoolSystemCommandBuilder();
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

