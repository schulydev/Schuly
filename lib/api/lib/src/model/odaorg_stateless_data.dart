//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:schuly_api/src/model/odaorg_stateless_user_info.dart';
import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/model/odaorg_stateless_agenda_event.dart';
import 'package:schuly_api/src/model/odaorg_stateless_exam.dart';
import 'package:schuly_api/src/model/odaorg_stateless_grade.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'odaorg_stateless_data.g.dart';

/// OdaorgStatelessData
///
/// Properties:
/// * [userInfo] 
/// * [grades] 
/// * [exams] 
/// * [agenda] 
@BuiltValue()
abstract class OdaorgStatelessData implements Built<OdaorgStatelessData, OdaorgStatelessDataBuilder> {
  @BuiltValueField(wireName: r'userInfo')
  OdaorgStatelessUserInfo? get userInfo;

  @BuiltValueField(wireName: r'grades')
  BuiltList<OdaorgStatelessGrade> get grades;

  @BuiltValueField(wireName: r'exams')
  BuiltList<OdaorgStatelessExam> get exams;

  @BuiltValueField(wireName: r'agenda')
  BuiltList<OdaorgStatelessAgendaEvent> get agenda;

  OdaorgStatelessData._();

  factory OdaorgStatelessData([void updates(OdaorgStatelessDataBuilder b)]) = _$OdaorgStatelessData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OdaorgStatelessDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OdaorgStatelessData> get serializer => _$OdaorgStatelessDataSerializer();
}

class _$OdaorgStatelessDataSerializer implements PrimitiveSerializer<OdaorgStatelessData> {
  @override
  final Iterable<Type> types = const [OdaorgStatelessData, _$OdaorgStatelessData];

  @override
  final String wireName = r'OdaorgStatelessData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OdaorgStatelessData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'userInfo';
    yield object.userInfo == null ? null : serializers.serialize(
      object.userInfo,
      specifiedType: const FullType.nullable(OdaorgStatelessUserInfo),
    );
    yield r'grades';
    yield serializers.serialize(
      object.grades,
      specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessGrade)]),
    );
    yield r'exams';
    yield serializers.serialize(
      object.exams,
      specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessExam)]),
    );
    yield r'agenda';
    yield serializers.serialize(
      object.agenda,
      specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessAgendaEvent)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OdaorgStatelessData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OdaorgStatelessDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userInfo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OdaorgStatelessUserInfo),
          ) as OdaorgStatelessUserInfo?;
          if (valueDes == null) continue;
          result.userInfo.replace(valueDes);
          break;
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessGrade)]),
          ) as BuiltList<OdaorgStatelessGrade>;
          result.grades.replace(valueDes);
          break;
        case r'exams':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessExam)]),
          ) as BuiltList<OdaorgStatelessExam>;
          result.exams.replace(valueDes);
          break;
        case r'agenda':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OdaorgStatelessAgendaEvent)]),
          ) as BuiltList<OdaorgStatelessAgendaEvent>;
          result.agenda.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OdaorgStatelessData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OdaorgStatelessDataBuilder();
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

