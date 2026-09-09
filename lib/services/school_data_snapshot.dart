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

  Map<String, dynamic> toJson() => {
        'version': 1,
        'me': me == null ? null : standardSerializers.serializeWith(SchoolUserDto.serializer, me!),
        'exams': _encode(exams, ExamDto.serializer),
        'agenda': _encode(agenda, AgendaEntryDto.serializer),
        'absences': _encode(absences, AbsenceDto.serializer),
        'classes': _encode(classes, ClassDto.serializer),
        'reports': _encode(reports, SemesterReportDto.serializer),
        'teachers': _encode(teachers, TeacherDto.serializer),
        'documents': _encode(documents, StudentDocumentDto.serializer),
      };

  static SchoolDataSnapshot? fromJson(Map<String, dynamic> json) {
    if (json['version'] != 1) return null;
    try {
      final rawMe = json['me'] as Map<String, dynamic>?;
      return SchoolDataSnapshot(
        me: rawMe == null ? null : standardSerializers.deserializeWith(SchoolUserDto.serializer, rawMe),
        exams: _list(json['exams'], ExamDto.serializer),
        agenda: _list(json['agenda'], AgendaEntryDto.serializer),
        absences: _list(json['absences'], AbsenceDto.serializer),
        classes: _list(json['classes'], ClassDto.serializer),
        reports: _list(json['reports'], SemesterReportDto.serializer),
        teachers: _list(json['teachers'], TeacherDto.serializer),
        documents: _list(json['documents'], StudentDocumentDto.serializer),
      );
    } catch (_) {
      return null;
    }
  }

  static List<Object?> _encode<T>(List<T> items, Serializer<T> serializer) => items.map((item) => standardSerializers.serializeWith(serializer, item)).toList(growable: false);

  static List<T> _list<T>(Object? raw, Serializer<T> serializer) => (raw as List<dynamic>).map((item) => standardSerializers.deserializeWith(serializer, item as Map<String, dynamic>)!).toList(growable: false);
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
