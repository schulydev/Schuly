//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_ai_app_activity_dto.g.dart';

/// ExportAiAppActivityDto
///
/// Properties:
/// * [toolName] 
/// * [allowed] 
/// * [at] 
@BuiltValue()
abstract class ExportAiAppActivityDto implements Built<ExportAiAppActivityDto, ExportAiAppActivityDtoBuilder> {
  @BuiltValueField(wireName: r'toolName')
  String get toolName;

  @BuiltValueField(wireName: r'allowed')
  bool get allowed;

  @BuiltValueField(wireName: r'at')
  DateTime get at;

  ExportAiAppActivityDto._();

  factory ExportAiAppActivityDto([void updates(ExportAiAppActivityDtoBuilder b)]) = _$ExportAiAppActivityDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportAiAppActivityDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportAiAppActivityDto> get serializer => _$ExportAiAppActivityDtoSerializer();
}

class _$ExportAiAppActivityDtoSerializer implements PrimitiveSerializer<ExportAiAppActivityDto> {
  @override
  final Iterable<Type> types = const [ExportAiAppActivityDto, _$ExportAiAppActivityDto];

  @override
  final String wireName = r'ExportAiAppActivityDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportAiAppActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'toolName';
    yield serializers.serialize(
      object.toolName,
      specifiedType: const FullType(String),
    );
    yield r'allowed';
    yield serializers.serialize(
      object.allowed,
      specifiedType: const FullType(bool),
    );
    yield r'at';
    yield serializers.serialize(
      object.at,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportAiAppActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportAiAppActivityDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'toolName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.toolName = valueDes;
          break;
        case r'allowed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.allowed = valueDes;
          break;
        case r'at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.at = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportAiAppActivityDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportAiAppActivityDtoBuilder();
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

