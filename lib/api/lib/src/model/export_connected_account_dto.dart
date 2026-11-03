//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_connected_account_dto.g.dart';

/// ExportConnectedAccountDto
///
/// Properties:
/// * [provider] 
/// * [title] 
/// * [detail] 
/// * [status] 
/// * [linkedAt] 
/// * [lastSyncedAt] 
@BuiltValue()
abstract class ExportConnectedAccountDto implements Built<ExportConnectedAccountDto, ExportConnectedAccountDtoBuilder> {
  @BuiltValueField(wireName: r'provider')
  String get provider;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'detail')
  String? get detail;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'linkedAt')
  DateTime? get linkedAt;

  @BuiltValueField(wireName: r'lastSyncedAt')
  DateTime? get lastSyncedAt;

  ExportConnectedAccountDto._();

  factory ExportConnectedAccountDto([void updates(ExportConnectedAccountDtoBuilder b)]) = _$ExportConnectedAccountDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportConnectedAccountDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportConnectedAccountDto> get serializer => _$ExportConnectedAccountDtoSerializer();
}

class _$ExportConnectedAccountDtoSerializer implements PrimitiveSerializer<ExportConnectedAccountDto> {
  @override
  final Iterable<Type> types = const [ExportConnectedAccountDto, _$ExportConnectedAccountDto];

  @override
  final String wireName = r'ExportConnectedAccountDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportConnectedAccountDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'provider';
    yield serializers.serialize(
      object.provider,
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
      specifiedType: const FullType(String),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportConnectedAccountDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportConnectedAccountDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'provider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.provider = valueDes;
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
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportConnectedAccountDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportConnectedAccountDtoBuilder();
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

