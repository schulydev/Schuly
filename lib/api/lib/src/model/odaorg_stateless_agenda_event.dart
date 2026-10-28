//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'odaorg_stateless_agenda_event.g.dart';

/// OdaorgStatelessAgendaEvent
///
/// Properties:
/// * [id] 
/// * [title] 
/// * [startDate] 
/// * [endDate] 
/// * [room] 
/// * [comment] 
@BuiltValue()
abstract class OdaorgStatelessAgendaEvent implements Built<OdaorgStatelessAgendaEvent, OdaorgStatelessAgendaEventBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'startDate')
  String? get startDate;

  @BuiltValueField(wireName: r'endDate')
  String? get endDate;

  @BuiltValueField(wireName: r'room')
  String? get room;

  @BuiltValueField(wireName: r'comment')
  String? get comment;

  OdaorgStatelessAgendaEvent._();

  factory OdaorgStatelessAgendaEvent([void updates(OdaorgStatelessAgendaEventBuilder b)]) = _$OdaorgStatelessAgendaEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OdaorgStatelessAgendaEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OdaorgStatelessAgendaEvent> get serializer => _$OdaorgStatelessAgendaEventSerializer();
}

class _$OdaorgStatelessAgendaEventSerializer implements PrimitiveSerializer<OdaorgStatelessAgendaEvent> {
  @override
  final Iterable<Type> types = const [OdaorgStatelessAgendaEvent, _$OdaorgStatelessAgendaEvent];

  @override
  final String wireName = r'OdaorgStatelessAgendaEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OdaorgStatelessAgendaEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield object.id == null ? null : serializers.serialize(
      object.id,
      specifiedType: const FullType.nullable(String),
    );
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
    yield r'startDate';
    yield object.startDate == null ? null : serializers.serialize(
      object.startDate,
      specifiedType: const FullType.nullable(String),
    );
    yield r'endDate';
    yield object.endDate == null ? null : serializers.serialize(
      object.endDate,
      specifiedType: const FullType.nullable(String),
    );
    yield r'room';
    yield object.room == null ? null : serializers.serialize(
      object.room,
      specifiedType: const FullType.nullable(String),
    );
    yield r'comment';
    yield object.comment == null ? null : serializers.serialize(
      object.comment,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OdaorgStatelessAgendaEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OdaorgStatelessAgendaEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'startDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.startDate = valueDes;
          break;
        case r'endDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.endDate = valueDes;
          break;
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.room = valueDes;
          break;
        case r'comment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.comment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OdaorgStatelessAgendaEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OdaorgStatelessAgendaEventBuilder();
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

