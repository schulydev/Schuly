//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/link_step_dto.dart';
import 'package:schuly_api/src/model/link_session_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_session_dto.g.dart';

/// LinkSessionDto
///
/// Properties:
/// * [sessionId] 
/// * [providerId] 
/// * [flowId] 
/// * [status] 
/// * [expiresAt] 
/// * [step] 
@BuiltValue()
abstract class LinkSessionDto implements Built<LinkSessionDto, LinkSessionDtoBuilder> {
  @BuiltValueField(wireName: r'sessionId')
  String get sessionId;

  @BuiltValueField(wireName: r'providerId')
  String get providerId;

  @BuiltValueField(wireName: r'flowId')
  String get flowId;

  @BuiltValueField(wireName: r'status')
  LinkSessionStatus get status;
  // enum statusEnum {  active,  done,  failed,  expired,  };

  @BuiltValueField(wireName: r'expiresAt')
  DateTime get expiresAt;

  @BuiltValueField(wireName: r'step')
  LinkStepDto get step;

  LinkSessionDto._();

  factory LinkSessionDto([void updates(LinkSessionDtoBuilder b)]) = _$LinkSessionDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkSessionDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkSessionDto> get serializer => _$LinkSessionDtoSerializer();
}

class _$LinkSessionDtoSerializer implements PrimitiveSerializer<LinkSessionDto> {
  @override
  final Iterable<Type> types = const [LinkSessionDto, _$LinkSessionDto];

  @override
  final String wireName = r'LinkSessionDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkSessionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sessionId';
    yield serializers.serialize(
      object.sessionId,
      specifiedType: const FullType(String),
    );
    yield r'providerId';
    yield serializers.serialize(
      object.providerId,
      specifiedType: const FullType(String),
    );
    yield r'flowId';
    yield serializers.serialize(
      object.flowId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(LinkSessionStatus),
    );
    yield r'expiresAt';
    yield serializers.serialize(
      object.expiresAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'step';
    yield serializers.serialize(
      object.step,
      specifiedType: const FullType(LinkStepDto),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkSessionDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkSessionDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sessionId = valueDes;
          break;
        case r'providerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerId = valueDes;
          break;
        case r'flowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.flowId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkSessionStatus),
          ) as LinkSessionStatus;
          result.status = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        case r'step':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkStepDto),
          ) as LinkStepDto;
          result.step.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkSessionDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkSessionDtoBuilder();
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

