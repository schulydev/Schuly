//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/export_ai_app_key_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/export_ai_app_activity_dto.dart';
import 'package:schuly_api/src/model/export_ai_app_connection_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_ai_apps_dto.g.dart';

/// ExportAiAppsDto
///
/// Properties:
/// * [connections] 
/// * [apiKeys] 
/// * [activity] 
@BuiltValue()
abstract class ExportAiAppsDto implements Built<ExportAiAppsDto, ExportAiAppsDtoBuilder> {
  @BuiltValueField(wireName: r'connections')
  BuiltList<ExportAiAppConnectionDto> get connections;

  @BuiltValueField(wireName: r'apiKeys')
  BuiltList<ExportAiAppKeyDto> get apiKeys;

  @BuiltValueField(wireName: r'activity')
  BuiltList<ExportAiAppActivityDto> get activity;

  ExportAiAppsDto._();

  factory ExportAiAppsDto([void updates(ExportAiAppsDtoBuilder b)]) = _$ExportAiAppsDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportAiAppsDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportAiAppsDto> get serializer => _$ExportAiAppsDtoSerializer();
}

class _$ExportAiAppsDtoSerializer implements PrimitiveSerializer<ExportAiAppsDto> {
  @override
  final Iterable<Type> types = const [ExportAiAppsDto, _$ExportAiAppsDto];

  @override
  final String wireName = r'ExportAiAppsDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportAiAppsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'connections';
    yield serializers.serialize(
      object.connections,
      specifiedType: const FullType(BuiltList, [FullType(ExportAiAppConnectionDto)]),
    );
    yield r'apiKeys';
    yield serializers.serialize(
      object.apiKeys,
      specifiedType: const FullType(BuiltList, [FullType(ExportAiAppKeyDto)]),
    );
    yield r'activity';
    yield serializers.serialize(
      object.activity,
      specifiedType: const FullType(BuiltList, [FullType(ExportAiAppActivityDto)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportAiAppsDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportAiAppsDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'connections':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportAiAppConnectionDto)]),
          ) as BuiltList<ExportAiAppConnectionDto>;
          result.connections.replace(valueDes);
          break;
        case r'apiKeys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportAiAppKeyDto)]),
          ) as BuiltList<ExportAiAppKeyDto>;
          result.apiKeys.replace(valueDes);
          break;
        case r'activity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ExportAiAppActivityDto)]),
          ) as BuiltList<ExportAiAppActivityDto>;
          result.activity.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportAiAppsDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportAiAppsDtoBuilder();
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

