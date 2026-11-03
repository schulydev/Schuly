//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_code_run_dto.g.dart';

/// HelplyCodeRunDto
///
/// Properties:
/// * [command] 
/// * [output] 
/// * [exitCode] 
@BuiltValue()
abstract class HelplyCodeRunDto implements Built<HelplyCodeRunDto, HelplyCodeRunDtoBuilder> {
  @BuiltValueField(wireName: r'command')
  String get command;

  @BuiltValueField(wireName: r'output')
  String? get output;

  @BuiltValueField(wireName: r'exitCode')
  int? get exitCode;

  HelplyCodeRunDto._();

  factory HelplyCodeRunDto([void updates(HelplyCodeRunDtoBuilder b)]) = _$HelplyCodeRunDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyCodeRunDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyCodeRunDto> get serializer => _$HelplyCodeRunDtoSerializer();
}

class _$HelplyCodeRunDtoSerializer implements PrimitiveSerializer<HelplyCodeRunDto> {
  @override
  final Iterable<Type> types = const [HelplyCodeRunDto, _$HelplyCodeRunDto];

  @override
  final String wireName = r'HelplyCodeRunDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyCodeRunDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'command';
    yield serializers.serialize(
      object.command,
      specifiedType: const FullType(String),
    );
    yield r'output';
    yield object.output == null ? null : serializers.serialize(
      object.output,
      specifiedType: const FullType.nullable(String),
    );
    yield r'exitCode';
    yield object.exitCode == null ? null : serializers.serialize(
      object.exitCode,
      specifiedType: const FullType.nullable(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyCodeRunDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyCodeRunDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'command':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.command = valueDes;
          break;
        case r'output':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.output = valueDes;
          break;
        case r'exitCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.exitCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyCodeRunDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyCodeRunDtoBuilder();
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

