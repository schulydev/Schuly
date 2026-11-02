//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/link_icon_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/link_capability_dto.dart';
import 'package:schuly_api/src/model/link_flow_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_provider_dto.g.dart';

/// LinkProviderDto
///
/// Properties:
/// * [id] 
/// * [displayName] 
/// * [description] 
/// * [icon] 
/// * [capabilities] 
/// * [flows] 
/// * [sortOrder] 
@BuiltValue()
abstract class LinkProviderDto implements Built<LinkProviderDto, LinkProviderDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'displayName')
  String get displayName;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'icon')
  LinkIconDto get icon;

  @BuiltValueField(wireName: r'capabilities')
  BuiltList<LinkCapabilityDto> get capabilities;

  @BuiltValueField(wireName: r'flows')
  BuiltList<LinkFlowDto> get flows;

  @BuiltValueField(wireName: r'sortOrder')
  int get sortOrder;

  LinkProviderDto._();

  factory LinkProviderDto([void updates(LinkProviderDtoBuilder b)]) = _$LinkProviderDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkProviderDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkProviderDto> get serializer => _$LinkProviderDtoSerializer();
}

class _$LinkProviderDtoSerializer implements PrimitiveSerializer<LinkProviderDto> {
  @override
  final Iterable<Type> types = const [LinkProviderDto, _$LinkProviderDto];

  @override
  final String wireName = r'LinkProviderDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkProviderDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'displayName';
    yield serializers.serialize(
      object.displayName,
      specifiedType: const FullType(String),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
    yield r'icon';
    yield serializers.serialize(
      object.icon,
      specifiedType: const FullType(LinkIconDto),
    );
    yield r'capabilities';
    yield serializers.serialize(
      object.capabilities,
      specifiedType: const FullType(BuiltList, [FullType(LinkCapabilityDto)]),
    );
    yield r'flows';
    yield serializers.serialize(
      object.flows,
      specifiedType: const FullType(BuiltList, [FullType(LinkFlowDto)]),
    );
    yield r'sortOrder';
    yield serializers.serialize(
      object.sortOrder,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkProviderDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkProviderDtoBuilder result,
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
        case r'displayName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.displayName = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'icon':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkIconDto),
          ) as LinkIconDto;
          result.icon.replace(valueDes);
          break;
        case r'capabilities':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkCapabilityDto)]),
          ) as BuiltList<LinkCapabilityDto>;
          result.capabilities.replace(valueDes);
          break;
        case r'flows':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkFlowDto)]),
          ) as BuiltList<LinkFlowDto>;
          result.flows.replace(valueDes);
          break;
        case r'sortOrder':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.sortOrder = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkProviderDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkProviderDtoBuilder();
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

