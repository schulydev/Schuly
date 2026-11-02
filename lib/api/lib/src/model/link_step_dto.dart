//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/link_done_dto.dart';
import 'package:schuly_api/src/model/link_action_dto.dart';
import 'package:schuly_api/src/model/link_device_code_dto.dart';
import 'package:schuly_api/src/model/link_otp_dto.dart';
import 'package:schuly_api/src/model/link_push_code_dto.dart';
import 'package:schuly_api/src/model/link_redirect_dto.dart';
import 'package:schuly_api/src/model/link_option_dto.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/link_step_kind_dto.dart';
import 'package:schuly_api/src/model/link_field_dto.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'link_step_dto.g.dart';

/// LinkStepDto
///
/// Properties:
/// * [id] 
/// * [kind] 
/// * [title] 
/// * [description] 
/// * [error] 
/// * [fields] 
/// * [otp] 
/// * [pushCode] 
/// * [deviceCode] 
/// * [redirect] 
/// * [options] 
/// * [actions] 
/// * [submitLabel] 
/// * [done] 
@BuiltValue()
abstract class LinkStepDto implements Built<LinkStepDto, LinkStepDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'kind')
  LinkStepKindDto get kind;
  // enum kindEnum {  form,  otp,  pushCode,  deviceCode,  redirect,  select,  done,  error,  };

  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'error')
  String? get error;

  @BuiltValueField(wireName: r'fields')
  BuiltList<LinkFieldDto> get fields;

  @BuiltValueField(wireName: r'otp')
  LinkOtpDto? get otp;

  @BuiltValueField(wireName: r'pushCode')
  LinkPushCodeDto? get pushCode;

  @BuiltValueField(wireName: r'deviceCode')
  LinkDeviceCodeDto? get deviceCode;

  @BuiltValueField(wireName: r'redirect')
  LinkRedirectDto? get redirect;

  @BuiltValueField(wireName: r'options')
  BuiltList<LinkOptionDto> get options;

  @BuiltValueField(wireName: r'actions')
  BuiltList<LinkActionDto> get actions;

  @BuiltValueField(wireName: r'submitLabel')
  String? get submitLabel;

  @BuiltValueField(wireName: r'done')
  LinkDoneDto? get done;

  LinkStepDto._();

  factory LinkStepDto([void updates(LinkStepDtoBuilder b)]) = _$LinkStepDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LinkStepDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LinkStepDto> get serializer => _$LinkStepDtoSerializer();
}

class _$LinkStepDtoSerializer implements PrimitiveSerializer<LinkStepDto> {
  @override
  final Iterable<Type> types = const [LinkStepDto, _$LinkStepDto];

  @override
  final String wireName = r'LinkStepDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LinkStepDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(LinkStepKindDto),
    );
    yield r'title';
    yield object.title == null ? null : serializers.serialize(
      object.title,
      specifiedType: const FullType.nullable(String),
    );
    yield r'description';
    yield object.description == null ? null : serializers.serialize(
      object.description,
      specifiedType: const FullType.nullable(String),
    );
    yield r'error';
    yield object.error == null ? null : serializers.serialize(
      object.error,
      specifiedType: const FullType.nullable(String),
    );
    yield r'fields';
    yield serializers.serialize(
      object.fields,
      specifiedType: const FullType(BuiltList, [FullType(LinkFieldDto)]),
    );
    yield r'otp';
    yield object.otp == null ? null : serializers.serialize(
      object.otp,
      specifiedType: const FullType.nullable(LinkOtpDto),
    );
    yield r'pushCode';
    yield object.pushCode == null ? null : serializers.serialize(
      object.pushCode,
      specifiedType: const FullType.nullable(LinkPushCodeDto),
    );
    yield r'deviceCode';
    yield object.deviceCode == null ? null : serializers.serialize(
      object.deviceCode,
      specifiedType: const FullType.nullable(LinkDeviceCodeDto),
    );
    yield r'redirect';
    yield object.redirect == null ? null : serializers.serialize(
      object.redirect,
      specifiedType: const FullType.nullable(LinkRedirectDto),
    );
    yield r'options';
    yield serializers.serialize(
      object.options,
      specifiedType: const FullType(BuiltList, [FullType(LinkOptionDto)]),
    );
    yield r'actions';
    yield serializers.serialize(
      object.actions,
      specifiedType: const FullType(BuiltList, [FullType(LinkActionDto)]),
    );
    yield r'submitLabel';
    yield object.submitLabel == null ? null : serializers.serialize(
      object.submitLabel,
      specifiedType: const FullType.nullable(String),
    );
    yield r'done';
    yield object.done == null ? null : serializers.serialize(
      object.done,
      specifiedType: const FullType.nullable(LinkDoneDto),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    LinkStepDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LinkStepDtoBuilder result,
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
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(LinkStepKindDto),
          ) as LinkStepKindDto;
          result.kind = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.error = valueDes;
          break;
        case r'fields':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkFieldDto)]),
          ) as BuiltList<LinkFieldDto>;
          result.fields.replace(valueDes);
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LinkOtpDto),
          ) as LinkOtpDto?;
          if (valueDes == null) continue;
          result.otp.replace(valueDes);
          break;
        case r'pushCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LinkPushCodeDto),
          ) as LinkPushCodeDto?;
          if (valueDes == null) continue;
          result.pushCode.replace(valueDes);
          break;
        case r'deviceCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LinkDeviceCodeDto),
          ) as LinkDeviceCodeDto?;
          if (valueDes == null) continue;
          result.deviceCode.replace(valueDes);
          break;
        case r'redirect':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LinkRedirectDto),
          ) as LinkRedirectDto?;
          if (valueDes == null) continue;
          result.redirect.replace(valueDes);
          break;
        case r'options':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkOptionDto)]),
          ) as BuiltList<LinkOptionDto>;
          result.options.replace(valueDes);
          break;
        case r'actions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(LinkActionDto)]),
          ) as BuiltList<LinkActionDto>;
          result.actions.replace(valueDes);
          break;
        case r'submitLabel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.submitLabel = valueDes;
          break;
        case r'done':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(LinkDoneDto),
          ) as LinkDoneDto?;
          if (valueDes == null) continue;
          result.done.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LinkStepDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LinkStepDtoBuilder();
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

