//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_helply_workspace_request.g.dart';

/// UpdateHelplyWorkspaceRequest
///
/// Properties:
/// * [enabled] 
@BuiltValue()
abstract class UpdateHelplyWorkspaceRequest implements Built<UpdateHelplyWorkspaceRequest, UpdateHelplyWorkspaceRequestBuilder> {
  @BuiltValueField(wireName: r'enabled')
  bool get enabled;

  UpdateHelplyWorkspaceRequest._();

  factory UpdateHelplyWorkspaceRequest([void updates(UpdateHelplyWorkspaceRequestBuilder b)]) = _$UpdateHelplyWorkspaceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateHelplyWorkspaceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateHelplyWorkspaceRequest> get serializer => _$UpdateHelplyWorkspaceRequestSerializer();
}

class _$UpdateHelplyWorkspaceRequestSerializer implements PrimitiveSerializer<UpdateHelplyWorkspaceRequest> {
  @override
  final Iterable<Type> types = const [UpdateHelplyWorkspaceRequest, _$UpdateHelplyWorkspaceRequest];

  @override
  final String wireName = r'UpdateHelplyWorkspaceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateHelplyWorkspaceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'enabled';
    yield serializers.serialize(
      object.enabled,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateHelplyWorkspaceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateHelplyWorkspaceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.enabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateHelplyWorkspaceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateHelplyWorkspaceRequestBuilder();
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

