import 'dart:convert';
import 'dart:io';

import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schuly_api/schuly_api.dart';

class SchoolDataSnapshot {
  final SchoolUserDto? me;
  final List<ExamDto> exams;
  final List<AgendaEntryDto> agenda;
  final List<AbsenceDto> absences;
  final List<ClassDto> classes;
  final List<SemesterReportDto> reports;
  final List<TeacherDto> teachers;
  final List<StudentDocumentDto> documents;

  const SchoolDataSnapshot({required this.me, required this.exams, required this.agenda, required this.absences, required this.classes, required this.reports, required this.teachers, required this.documents});

  /// Builds the disk representation. A single unserialisable exam, grade, etc.
  /// must never blank the whole cache: each section (and [me]) is encoded
  /// independently, so one bad item is dropped (and logged) instead of taking
  /// the rest of the snapshot down with it. (Non-finite doubles such as
  /// `classAverage` are not a risk here: built_value's own [DoubleSerializer]
  /// already turns `NaN`/`Infinity` into the sentinel strings `'NaN'`/`'INF'`
  /// before `jsonEncode` ever sees a raw double, and reverses that on decode.)
  Map<String, dynamic> toJson() => <String, dynamic>{
        'version': 1,
        'me': me == null ? null : _encodeOne(me!, SchoolUserDto.serializer, 'me'),
        'exams': _encode(exams, ExamDto.serializer, 'exams'),
        'agenda': _encode(agenda, AgendaEntryDto.serializer, 'agenda'),
        'absences': _encode(absences, AbsenceDto.serializer, 'absences'),
        'classes': _encode(classes, ClassDto.serializer, 'classes'),
        'reports': _encode(reports, SemesterReportDto.serializer, 'reports'),
        'teachers': _encode(teachers, TeacherDto.serializer, 'teachers'),
        'documents': _encode(documents, StudentDocumentDto.serializer, 'documents'),
      };

  static SchoolDataSnapshot? fromJson(Map<String, dynamic> json) {
    if (json['version'] != 1) return null;
    try {
      final rawMe = json['me'] as Map<String, dynamic>?;
      SchoolUserDto? me;
      if (rawMe != null) {
        try {
          me = standardSerializers.deserializeWith(SchoolUserDto.serializer, rawMe);
        } catch (e, st) {
          debugPrint('SchoolDataSnapshot.fromJson: failed to decode me, dropping: $e\n$st');
        }
      }
      return SchoolDataSnapshot(
        me: me,
        exams: _list(json['exams'], ExamDto.serializer, 'exams'),
        agenda: _list(json['agenda'], AgendaEntryDto.serializer, 'agenda'),
        absences: _list(json['absences'], AbsenceDto.serializer, 'absences'),
        classes: _list(json['classes'], ClassDto.serializer, 'classes'),
        reports: _list(json['reports'], SemesterReportDto.serializer, 'reports'),
        teachers: _list(json['teachers'], TeacherDto.serializer, 'teachers'),
        documents: _list(json['documents'], StudentDocumentDto.serializer, 'documents'),
      );
    } catch (e, st) {
      debugPrint('SchoolDataSnapshot.fromJson: malformed snapshot, discarding: $e\n$st');
      return null;
    }
  }

  static Object? _encodeOne<T>(T item, Serializer<T> serializer, String label) {
    try {
      return standardSerializers.serializeWith(serializer, item);
    } catch (e, st) {
      debugPrint('SchoolDataSnapshot.toJson: failed to encode $label, dropping: $e\n$st');
      return null;
    }
  }

  static List<Object?> _encode<T>(List<T> items, Serializer<T> serializer, String label) {
    final out = <Object?>[];
    for (final item in items) {
      try {
        out.add(standardSerializers.serializeWith(serializer, item));
      } catch (e, st) {
        debugPrint('SchoolDataSnapshot.toJson: failed to encode a $label item, skipping: $e\n$st');
      }
    }
    return out;
  }

  static List<T> _list<T>(Object? raw, Serializer<T> serializer, String label) {
    final out = <T>[];
    for (final item in raw as List<dynamic>) {
      try {
        final decoded = standardSerializers.deserializeWith(serializer, item as Map<String, dynamic>);
        if (decoded != null) out.add(decoded);
      } catch (e, st) {
        debugPrint('SchoolDataSnapshot.fromJson: failed to decode a $label item, skipping: $e\n$st');
      }
    }
    return out;
  }
}

class SchoolDataSnapshotStore {
  SchoolDataSnapshotStore._();
  static final SchoolDataSnapshotStore instance = SchoolDataSnapshotStore._();

  Future<Directory> _dir() async {
    final support = await getApplicationSupportDirectory();
    return Directory('${support.path}/school_data');
  }

  File _fileFor(Directory dir, String key) {
    final sanitised = key.replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');
    return File('${dir.path}/$sanitised.json');
  }

  Future<SchoolDataSnapshot?> load(String key) async {
    try {
      final file = _fileFor(await _dir(), key);
      final raw = await file.readAsString();
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return SchoolDataSnapshot.fromJson(json);
    } catch (e, st) {
      debugPrint('SchoolDataSnapshotStore.load failed for "$key": $e\n$st');
      return null;
    }
  }

  Future<void> save(String key, SchoolDataSnapshot snapshot) async {
    try {
      final dir = await _dir();
      await dir.create(recursive: true);
      final file = _fileFor(dir, key);
      await file.writeAsString(jsonEncode(snapshot.toJson()));
    } catch (e, st) {
      debugPrint('SchoolDataSnapshotStore.save failed for "$key": $e\n$st');
    }
  }

  Future<void> clear() async {
    try {
      final dir = await _dir();
      if (await dir.exists()) await dir.delete(recursive: true);
    } catch (_) {}
  }
}
