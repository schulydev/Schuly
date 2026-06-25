//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'install_plugin_request.g.dart';

/// InstallPluginRequest
///
/// Properties:
/// * [name] 
/// * [version] 
@BuiltValue()
abstract class InstallPluginRequest implements Built<InstallPluginRequest, InstallPluginRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'version')
  String? get version;

  InstallPluginRequest._();

  factory InstallPluginRequest([void updates(InstallPluginRequestBuilder b)]) = _$InstallPluginRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallPluginRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallPluginRequest> get serializer => _$InstallPluginRequestSerializer();
}

class _$InstallPluginRequestSerializer implements PrimitiveSerializer<InstallPluginRequest> {
  @override
  final Iterable<Type> types = const [InstallPluginRequest, _$InstallPluginRequest];

  @override
  final String wireName = r'InstallPluginRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallPluginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield object.version == null ? null : serializers.serialize(
      object.version,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallPluginRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallPluginRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallPluginRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallPluginRequestBuilder();
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

