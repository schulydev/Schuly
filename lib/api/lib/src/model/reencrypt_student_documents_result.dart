//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reencrypt_student_documents_result.g.dart';

/// ReencryptStudentDocumentsResult
///
/// Properties:
/// * [total] 
/// * [reencrypted] 
/// * [alreadyEncrypted] 
/// * [failed] 
@BuiltValue()
abstract class ReencryptStudentDocumentsResult implements Built<ReencryptStudentDocumentsResult, ReencryptStudentDocumentsResultBuilder> {
  @BuiltValueField(wireName: r'total')
  int get total;

  @BuiltValueField(wireName: r'reencrypted')
  int get reencrypted;

  @BuiltValueField(wireName: r'alreadyEncrypted')
  int get alreadyEncrypted;

  @BuiltValueField(wireName: r'failed')
  int get failed;

  ReencryptStudentDocumentsResult._();

  factory ReencryptStudentDocumentsResult([void updates(ReencryptStudentDocumentsResultBuilder b)]) = _$ReencryptStudentDocumentsResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ReencryptStudentDocumentsResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ReencryptStudentDocumentsResult> get serializer => _$ReencryptStudentDocumentsResultSerializer();
}

class _$ReencryptStudentDocumentsResultSerializer implements PrimitiveSerializer<ReencryptStudentDocumentsResult> {
  @override
  final Iterable<Type> types = const [ReencryptStudentDocumentsResult, _$ReencryptStudentDocumentsResult];

  @override
  final String wireName = r'ReencryptStudentDocumentsResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ReencryptStudentDocumentsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
    yield r'reencrypted';
    yield serializers.serialize(
      object.reencrypted,
      specifiedType: const FullType(int),
    );
    yield r'alreadyEncrypted';
    yield serializers.serialize(
      object.alreadyEncrypted,
      specifiedType: const FullType(int),
    );
    yield r'failed';
    yield serializers.serialize(
      object.failed,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ReencryptStudentDocumentsResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ReencryptStudentDocumentsResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'reencrypted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.reencrypted = valueDes;
          break;
        case r'alreadyEncrypted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.alreadyEncrypted = valueDes;
          break;
        case r'failed':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.failed = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ReencryptStudentDocumentsResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ReencryptStudentDocumentsResultBuilder();
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

