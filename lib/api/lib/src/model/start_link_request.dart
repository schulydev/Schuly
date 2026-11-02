//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'start_link_request.g.dart';

/// StartLinkRequest
///
/// Properties:
/// * [flowId] 
/// * [platform] 
/// * [reauthAccountId] 
@BuiltValue()
abstract class StartLinkRequest implements Built<StartLinkRequest, StartLinkRequestBuilder> {
  @BuiltValueField(wireName: r'flowId')
  String? get flowId;

  @BuiltValueField(wireName: r'platform')
  String? get platform;

  @BuiltValueField(wireName: r'reauthAccountId')
  String? get reauthAccountId;

  StartLinkRequest._();

  factory StartLinkRequest([void updates(StartLinkRequestBuilder b)]) = _$StartLinkRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StartLinkRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StartLinkRequest> get serializer => _$StartLinkRequestSerializer();
}

class _$StartLinkRequestSerializer implements PrimitiveSerializer<StartLinkRequest> {
  @override
  final Iterable<Type> types = const [StartLinkRequest, _$StartLinkRequest];

  @override
  final String wireName = r'StartLinkRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StartLinkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.flowId != null) {
      yield r'flowId';
      yield serializers.serialize(
        object.flowId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.platform != null) {
      yield r'platform';
      yield serializers.serialize(
        object.platform,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.reauthAccountId != null) {
      yield r'reauthAccountId';
      yield serializers.serialize(
        object.reauthAccountId,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StartLinkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StartLinkRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'flowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.flowId = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.platform = valueDes;
          break;
        case r'reauthAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.reauthAccountId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StartLinkRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StartLinkRequestBuilder();
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

