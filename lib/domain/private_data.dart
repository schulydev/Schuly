// Typed responses from the backend's stateless Schulware proxy
// (`/api/plugins/schulware/stateless/*`), used by private mode. Field names
// mirror the plugin's flat DTOs (camelCase JSON).

class PrivateAuthorizeUrl {
  final String? authorizationUrl;
  final String? codeVerifier;
  const PrivateAuthorizeUrl(this.authorizationUrl, this.codeVerifier);

  factory PrivateAuthorizeUrl.fromJson(Map<String, dynamic> j) =>
      PrivateAuthorizeUrl(j['authorizationUrl'] as String?, j['codeVerifier'] as String?);
}

class PrivateTokens {
  final String? accessToken;
  final String? refreshToken;
  const PrivateTokens(this.accessToken, this.refreshToken);

  factory PrivateTokens.fromJson(Map<String, dynamic> j) =>
      PrivateTokens(j['accessToken'] as String?, j['refreshToken'] as String?);
}

class PrivateRefreshResult {
  final bool success;
  final String? message;
  final String? accessToken;
  final String? refreshToken;
  final String? webSessionId;
  final String? webSessionUserId;
  final String? webSessionTransId;

  /// Rotated context_state as a JSON string (re-encoded from the returned object).
  final String? contextState;

  const PrivateRefreshResult({
    required this.success,
    this.message,
    this.accessToken,
    this.refreshToken,
    this.webSessionId,
    this.webSessionUserId,
    this.webSessionTransId,
    this.contextState,
  });
}

class PrivateGrade {
  final String? id;
  final String? examId;
  final String? subject;
  final double? score;
  final String? date;
  final String? comment;
  final double? points;
  const PrivateGrade({
    this.id,
    this.examId,
    this.subject,
    this.score,
    this.date,
    this.comment,
    this.points,
  });

  factory PrivateGrade.fromJson(Map<String, dynamic> j) => PrivateGrade(
        id: j['id'] as String?,
        examId: j['examId'] as String?,
        subject: j['subject'] as String?,
        score: (j['score'] as num?)?.toDouble(),
        date: j['date'] as String?,
        comment: j['comment'] as String?,
        points: (j['points'] as num?)?.toDouble(),
      );
}

class PrivateExam {
  final String? id;
  final String? name;
  final String? subject;
  final String? startDate;
  final String? endDate;
  final String? room;
  final String? comment;
  final String? type;
  const PrivateExam({
    this.id,
    this.name,
    this.subject,
    this.startDate,
    this.endDate,
    this.room,
    this.comment,
    this.type,
  });

  factory PrivateExam.fromJson(Map<String, dynamic> j) => PrivateExam(
        id: j['id'] as String?,
        name: j['name'] as String?,
        subject: j['subject'] as String?,
        startDate: j['startDate'] as String?,
        endDate: j['endDate'] as String?,
        room: j['room'] as String?,
        comment: j['comment'] as String?,
        type: j['type'] as String?,
      );
}

class PrivateAbsence {
  final String? id;
  final String? from;
  final String? to;
  final String? reason;
  final String? subject;
  final bool? excused;
  const PrivateAbsence({
    this.id,
    this.from,
    this.to,
    this.reason,
    this.subject,
    this.excused,
  });

  factory PrivateAbsence.fromJson(Map<String, dynamic> j) => PrivateAbsence(
        id: j['id'] as String?,
        from: j['from'] as String?,
        to: j['to'] as String?,
        reason: j['reason'] as String?,
        subject: j['subject'] as String?,
        excused: j['excused'] as bool?,
      );
}

class PrivateAgendaEvent {
  final String? id;
  final String? title;
  final String? startDate;
  final String? endDate;
  final String? room;
  final String? type;
  final String? comment;
  const PrivateAgendaEvent({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.room,
    this.type,
    this.comment,
  });

  factory PrivateAgendaEvent.fromJson(Map<String, dynamic> j) => PrivateAgendaEvent(
        id: j['id'] as String?,
        title: j['title'] as String?,
        startDate: j['startDate'] as String?,
        endDate: j['endDate'] as String?,
        room: j['room'] as String?,
        type: j['type'] as String?,
        comment: j['comment'] as String?,
      );
}

class PrivateUserInfo {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birthday;
  final String? entryDate;
  const PrivateUserInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.birthday,
    this.entryDate,
  });

  factory PrivateUserInfo.fromJson(Map<String, dynamic> j) => PrivateUserInfo(
        firstName: j['firstName'] as String?,
        lastName: j['lastName'] as String?,
        email: j['email'] as String?,
        birthday: j['birthday'] as String?,
        entryDate: j['entryDate'] as String?,
      );
}
