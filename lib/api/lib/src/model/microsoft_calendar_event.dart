//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'microsoft_calendar_event.g.dart';

/// MicrosoftCalendarEvent
///
/// Properties:
/// * [id] 
/// * [accountId] 
/// * [title] 
/// * [start] 
/// * [end] 
/// * [isAllDay] 
/// * [location] 
/// * [organizer] 
/// * [preview] 
/// * [webLink] 
/// * [joinUrl] 
/// * [showAs] 
/// * [isCancelled] 
@BuiltValue()
abstract class MicrosoftCalendarEvent implements Built<MicrosoftCalendarEvent, MicrosoftCalendarEventBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'start')
  String get start;

  @BuiltValueField(wireName: r'end')
  String get end;

  @BuiltValueField(wireName: r'isAllDay')
  bool get isAllDay;

  @BuiltValueField(wireName: r'location')
  String? get location;

  @BuiltValueField(wireName: r'organizer')
  String? get organizer;

  @BuiltValueField(wireName: r'preview')
  String? get preview;

  @BuiltValueField(wireName: r'webLink')
  String? get webLink;

  @BuiltValueField(wireName: r'joinUrl')
  String? get joinUrl;

  @BuiltValueField(wireName: r'showAs')
  String? get showAs;

  @BuiltValueField(wireName: r'isCancelled')
  bool get isCancelled;

  MicrosoftCalendarEvent._();

  factory MicrosoftCalendarEvent([void updates(MicrosoftCalendarEventBuilder b)]) = _$MicrosoftCalendarEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MicrosoftCalendarEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MicrosoftCalendarEvent> get serializer => _$MicrosoftCalendarEventSerializer();
}

class _$MicrosoftCalendarEventSerializer implements PrimitiveSerializer<MicrosoftCalendarEvent> {
  @override
  final Iterable<Type> types = const [MicrosoftCalendarEvent, _$MicrosoftCalendarEvent];

  @override
  final String wireName = r'MicrosoftCalendarEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MicrosoftCalendarEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'start';
    yield serializers.serialize(
      object.start,
      specifiedType: const FullType(String),
    );
    yield r'end';
    yield serializers.serialize(
      object.end,
      specifiedType: const FullType(String),
    );
    yield r'isAllDay';
    yield serializers.serialize(
      object.isAllDay,
      specifiedType: const FullType(bool),
    );
    yield r'location';
    yield object.location == null ? null : serializers.serialize(
      object.location,
      specifiedType: const FullType.nullable(String),
    );
    yield r'organizer';
    yield object.organizer == null ? null : serializers.serialize(
      object.organizer,
      specifiedType: const FullType.nullable(String),
    );
    yield r'preview';
    yield object.preview == null ? null : serializers.serialize(
      object.preview,
      specifiedType: const FullType.nullable(String),
    );
    yield r'webLink';
    yield object.webLink == null ? null : serializers.serialize(
      object.webLink,
      specifiedType: const FullType.nullable(String),
    );
    yield r'joinUrl';
    yield object.joinUrl == null ? null : serializers.serialize(
      object.joinUrl,
      specifiedType: const FullType.nullable(String),
    );
    yield r'showAs';
    yield object.showAs == null ? null : serializers.serialize(
      object.showAs,
      specifiedType: const FullType.nullable(String),
    );
    yield r'isCancelled';
    yield serializers.serialize(
      object.isCancelled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MicrosoftCalendarEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MicrosoftCalendarEventBuilder result,
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
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.start = valueDes;
          break;
        case r'end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.end = valueDes;
          break;
        case r'isAllDay':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isAllDay = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.location = valueDes;
          break;
        case r'organizer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.organizer = valueDes;
          break;
        case r'preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.preview = valueDes;
          break;
        case r'webLink':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.webLink = valueDes;
          break;
        case r'joinUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.joinUrl = valueDes;
          break;
        case r'showAs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.showAs = valueDes;
          break;
        case r'isCancelled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCancelled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MicrosoftCalendarEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MicrosoftCalendarEventBuilder();
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

