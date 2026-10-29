//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/link_redirect_mode_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_redirect_dto.g.dart';

/// LinkRedirectDto
///
/// Properties:
/// * [url] 
/// * [mode] 
/// * [callbackPrefix] 
/// * [captureCookieDomains] 
@BuiltValue()
abstract class LinkRedirectDto implements Built<LinkRedirectDto, LinkRedirectDtoBuilder> {
  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'mode')
  LinkRedirectModeDto get mode;
  // enum modeEnum {  hostCallback,  capture,  };

  @BuiltValueField(wireName: r'callbackPrefix')
  String? get callbackPrefix;

  @BuiltValueField(wireName: r'captureCookieDomains')
  BuiltList<String> get captureCookieDomains;

  LinkRedirectDto._();

  factory LinkRedirectDto([void updates(LinkRedirectDtoBuilder b)]) = _$LinkRedirectDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkRedirectDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkRedirectDto> get serializer => _$LinkRedirectDtoSerializer();
}

class _$LinkRedirectDtoSerializer implements PrimitiveSerializer<LinkRedirectDto> {
  @override
  final Iterable<Type> types = const [LinkRedirectDto, _$LinkRedirectDto];

  @override
  final String wireName = r'LinkRedirectDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkRedirectDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'mode';
    yield serializers.serialize(
      object.mode,
      specifiedType: const FullType(LinkRedirectModeDto),
    );
    yield r'callbackPrefix';
    yield object.callbackPrefix == null ? null : serializers.serialize(
      object.callbackPrefix,
      specifiedType: const FullType.nullable(String),
    );
    yield r'captureCookieDomains';
    yield serializers.serialize(
      object.captureCookieDomains,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkRedirectDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkRedirectDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkRedirectModeDto),
          ) as LinkRedirectModeDto;
          result.mode = valueDes;
          break;
        case r'callbackPrefix':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.callbackPrefix = valueDes;
          break;
        case r'captureCookieDomains':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.captureCookieDomains.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkRedirectDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkRedirectDtoBuilder();
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

