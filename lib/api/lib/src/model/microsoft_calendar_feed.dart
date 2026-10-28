//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/microsoft_calendar_account.dart';
import 'package:schuly_api/src/model/microsoft_calendar_event.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'microsoft_calendar_feed.g.dart';

/// MicrosoftCalendarFeed
///
/// Properties:
/// * [accounts] 
/// * [events] 
@BuiltValue()
abstract class MicrosoftCalendarFeed implements Built<MicrosoftCalendarFeed, MicrosoftCalendarFeedBuilder> {
  @BuiltValueField(wireName: r'accounts')
  BuiltList<MicrosoftCalendarAccount> get accounts;

  @BuiltValueField(wireName: r'events')
  BuiltList<MicrosoftCalendarEvent> get events;

  MicrosoftCalendarFeed._();

  factory MicrosoftCalendarFeed([void updates(MicrosoftCalendarFeedBuilder b)]) = _$MicrosoftCalendarFeed;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MicrosoftCalendarFeedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MicrosoftCalendarFeed> get serializer => _$MicrosoftCalendarFeedSerializer();
}

class _$MicrosoftCalendarFeedSerializer implements PrimitiveSerializer<MicrosoftCalendarFeed> {
  @override
  final Iterable<Type> types = const [MicrosoftCalendarFeed, _$MicrosoftCalendarFeed];

  @override
  final String wireName = r'MicrosoftCalendarFeed';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MicrosoftCalendarFeed object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accounts';
    yield serializers.serialize(
      object.accounts,
      specifiedType: const FullType(BuiltList, [FullType(MicrosoftCalendarAccount)]),
    );
    yield r'events';
    yield serializers.serialize(
      object.events,
      specifiedType: const FullType(BuiltList, [FullType(MicrosoftCalendarEvent)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MicrosoftCalendarFeed object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MicrosoftCalendarFeedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accounts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MicrosoftCalendarAccount)]),
          ) as BuiltList<MicrosoftCalendarAccount>;
          result.accounts.replace(valueDes);
          break;
        case r'events':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MicrosoftCalendarEvent)]),
          ) as BuiltList<MicrosoftCalendarEvent>;
          result.events.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MicrosoftCalendarFeed deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MicrosoftCalendarFeedBuilder();
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

