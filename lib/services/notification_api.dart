import 'api_client.dart';

/// Which push notifications a user wants, and whether a grade notification may
/// include the mark itself. Missing/malformed fields fall back to the defaults
/// rather than failing the whole response, since the backend may add fields
/// this client doesn't know about yet.
class NotificationPreferences {
  const NotificationPreferences({this.grades = true, this.absences = true, this.agenda = true, this.includeGradeValue = false});

  final bool grades;
  final bool absences;
  final bool agenda;
  final bool includeGradeValue;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => NotificationPreferences(
    grades: json['grades'] is bool ? json['grades'] as bool : true,
    absences: json['absences'] is bool ? json['absences'] as bool : true,
    agenda: json['agenda'] is bool ? json['agenda'] as bool : true,
    includeGradeValue: json['includeGradeValue'] is bool ? json['includeGradeValue'] as bool : false,
  );

  Map<String, dynamic> toJson() => {'grades': grades, 'absences': absences, 'agenda': agenda, 'includeGradeValue': includeGradeValue};

  NotificationPreferences copyWith({bool? grades, bool? absences, bool? agenda, bool? includeGradeValue}) => NotificationPreferences(
    grades: grades ?? this.grades,
    absences: absences ?? this.absences,
    agenda: agenda ?? this.agenda,
    includeGradeValue: includeGradeValue ?? this.includeGradeValue,
  );

  @override
  bool operator ==(Object other) =>
      other is NotificationPreferences &&
      other.grades == grades &&
      other.absences == absences &&
      other.agenda == agenda &&
      other.includeGradeValue == includeGradeValue;

  @override
  int get hashCode => Object.hash(grades, absences, agenda, includeGradeValue);
}

/// Hand-written against SchulyBackend's `/api/notifications/*` routes because
/// its OpenAPI spec doesn't carry them yet (schulydev/SchulyBackend#273). Move
/// this to the generated `lib/api` client once `bun run apigen` picks them up.
class NotificationApi {
  const NotificationApi();

  Future<void> registerDevice({required String token, required String platform, required String locale}) async {
    await ApiClient.instance.dio.post<void>(
      '/api/notifications/devices',
      data: {'token': token, 'platform': platform, 'locale': locale},
      options: ApiClient.handled(),
    );
  }

  Future<void> deleteDevice(String token) async {
    await ApiClient.instance.dio.delete<void>('/api/notifications/devices/${Uri.encodeComponent(token)}', options: ApiClient.handled());
  }

  Future<NotificationPreferences> getPreferences() async {
    final res = await ApiClient.instance.dio.get<Map<String, dynamic>>('/api/notifications/preferences', options: ApiClient.handled());
    return NotificationPreferences.fromJson(res.data ?? const {});
  }

  Future<void> putPreferences(NotificationPreferences preferences) async {
    await ApiClient.instance.dio.put<void>('/api/notifications/preferences', data: preferences.toJson(), options: ApiClient.handled());
  }
}
