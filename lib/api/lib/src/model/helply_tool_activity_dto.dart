//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/helply_code_run_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'helply_tool_activity_dto.g.dart';

/// HelplyToolActivityDto
///
/// Properties:
/// * [id] 
/// * [label] 
/// * [status] 
/// * [code] 
/// * [at] 
/// * [detail] 
@BuiltValue()
abstract class HelplyToolActivityDto implements Built<HelplyToolActivityDto, HelplyToolActivityDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'code')
  HelplyCodeRunDto? get code;

  @BuiltValueField(wireName: r'at')
  int? get at;

  @BuiltValueField(wireName: r'detail')
  String? get detail;

  HelplyToolActivityDto._();

  factory HelplyToolActivityDto([void updates(HelplyToolActivityDtoBuilder b)]) = _$HelplyToolActivityDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HelplyToolActivityDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HelplyToolActivityDto> get serializer => _$HelplyToolActivityDtoSerializer();
}

class _$HelplyToolActivityDtoSerializer implements PrimitiveSerializer<HelplyToolActivityDto> {
  @override
  final Iterable<Type> types = const [HelplyToolActivityDto, _$HelplyToolActivityDto];

  @override
  final String wireName = r'HelplyToolActivityDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HelplyToolActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'code';
    yield object.code == null ? null : serializers.serialize(
      object.code,
      specifiedType: const FullType.nullable(HelplyCodeRunDto),
    );
    yield r'at';
    yield object.at == null ? null : serializers.serialize(
      object.at,
      specifiedType: const FullType.nullable(int),
    );
    yield r'detail';
    yield object.detail == null ? null : serializers.serialize(
      object.detail,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HelplyToolActivityDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HelplyToolActivityDtoBuilder result,
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
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(HelplyCodeRunDto),
          ) as HelplyCodeRunDto?;
          if (valueDes == null) continue;
          result.code.replace(valueDes);
          break;
        case r'at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.at = valueDes;
          break;
        case r'detail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.detail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HelplyToolActivityDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HelplyToolActivityDtoBuilder();
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

