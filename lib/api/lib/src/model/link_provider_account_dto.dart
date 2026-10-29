//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/linked_account_status_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/link_capability_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_provider_account_dto.g.dart';

/// LinkProviderAccountDto
///
/// Properties:
/// * [providerId] 
/// * [providerName] 
/// * [id] 
/// * [title] 
/// * [detail] 
/// * [status] 
/// * [message] 
/// * [linkedAt] 
/// * [lastSyncedAt] 
/// * [capabilities] 
/// * [canReauth] 
@BuiltValue()
abstract class LinkProviderAccountDto implements Built<LinkProviderAccountDto, LinkProviderAccountDtoBuilder> {
  @BuiltValueField(wireName: r'providerId')
  String get providerId;

  @BuiltValueField(wireName: r'providerName')
  String get providerName;

  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  LinkedAccountStatusDto get status;
  // enum statusEnum {  ok,  syncing,  expired,  error,  };

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'linkedAt')
  DateTime? get linkedAt;

  @BuiltValueField(wireName: r'lastSyncedAt')
  DateTime? get lastSyncedAt;

  @BuiltValueField(wireName: r'capabilities')
  BuiltList<LinkCapabilityDto> get capabilities;

  @BuiltValueField(wireName: r'canReauth')
  bool get canReauth;

  LinkProviderAccountDto._();

  factory LinkProviderAccountDto([void updates(LinkProviderAccountDtoBuilder b)]) = _$LinkProviderAccountDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkProviderAccountDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkProviderAccountDto> get serializer => _$LinkProviderAccountDtoSerializer();
}

class _$LinkProviderAccountDtoSerializer implements PrimitiveSerializer<LinkProviderAccountDto> {
  @override
  final Iterable<Type> types = const [LinkProviderAccountDto, _$LinkProviderAccountDto];

  @override
  final String wireName = r'LinkProviderAccountDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkProviderAccountDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'providerId';
    yield serializers.serialize(
      object.providerId,
      specifiedType: const FullType(String),
    );
    yield r'providerName';
    yield serializers.serialize(
      object.providerName,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'detail';
    yield object.detail == null ? null : serializers.serialize(
      object.detail,
      specifiedType: const FullType.nullable(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(LinkedAccountStatusDto),
    );
    yield r'message';
    yield object.message == null ? null : serializers.serialize(
      object.message,
      specifiedType: const FullType.nullable(String),
    );
    yield r'linkedAt';
    yield object.linkedAt == null ? null : serializers.serialize(
      object.linkedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'lastSyncedAt';
    yield object.lastSyncedAt == null ? null : serializers.serialize(
      object.lastSyncedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'capabilities';
    yield serializers.serialize(
      object.capabilities,
      specifiedType: const FullType(BuiltList, [FullType(LinkCapabilityDto)]),
    );
    yield r'canReauth';
    yield serializers.serialize(
      object.canReauth,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkProviderAccountDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkProviderAccountDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'providerId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerId = valueDes;
          break;
        case r'providerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.providerName = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'detail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.detail = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkedAccountStatusDto),
          ) as LinkedAccountStatusDto;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.message = valueDes;
          break;
        case r'linkedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.linkedAt = valueDes;
          break;
        case r'lastSyncedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSyncedAt = valueDes;
          break;
        case r'capabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkCapabilityDto)]),
          ) as BuiltList<LinkCapabilityDto>;
          result.capabilities.replace(valueDes);
          break;
        case r'canReauth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.canReauth = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkProviderAccountDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkProviderAccountDtoBuilder();
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

