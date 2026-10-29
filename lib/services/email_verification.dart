import 'dart:convert';

/// A pending "confirm your email" step: the server mailed a code (or link) and
/// answered with this instead of tokens.
class EmailVerificationChallenge {
  const EmailVerificationChallenge({required this.challenge, required this.email, required this.method, this.expiresIn});

  final String challenge;

  /// The masked address the code went to, e.g. `a***@example.com`.
  final String email;

  /// `code` when the user types a 6-digit code; anything else is a link.
  final String method;
  final int? expiresIn;

  bool get isCode => method == 'code';

  /// Reads a register / login response body; null when it isn't a verification request.
  static EmailVerificationChallenge? tryParse(Object? body) {
    if (body is! Map || body['email_verification_required'] != true) return null;
    final challenge = body['challenge'];
    if (challenge is! String || challenge.isEmpty) return null;
    final method = body['method'];
    final email = body['email'];
    final expiresIn = body['expires_in'];
    return EmailVerificationChallenge(
      challenge: challenge,
      email: email is String ? email : '',
      method: method is String && method.isNotEmpty ? method : 'code',
      expiresIn: expiresIn is num ? expiresIn.toInt() : null,
    );
  }
}

enum EmailCodeErrorKind {
  /// Wrong code: let the user try again.
  invalidCode,

  /// The code ran out: offer a resend.
  codeExpired,

  /// The challenge is gone: back to sign in.
  invalidGrant,

  /// Too many requests: wait [EmailCodeException.retryAfter].
  rateLimited,

  /// The server could not send the mail.
  notificationFailed,
  other,
}

class EmailCodeException implements Exception {
  const EmailCodeException(this.kind, {this.retryAfter, this.statusCode});

  final EmailCodeErrorKind kind;
  final Duration? retryAfter;
  final int? statusCode;

  @override
  String toString() => 'EmailCodeException($kind)';
}

const _defaultRetryAfter = Duration(seconds: 60);

/// Maps a failed verify / resend response to an [EmailCodeException]. Reads the
/// `error` field or the `errors` array defensively, falling back to the status code.
EmailCodeException mapEmailCodeError(int statusCode, String body, {String? retryAfterHeader}) {
  final codes = <String>[];
  try {
    final decoded = jsonDecode(body);
    if (decoded is Map) {
      final error = decoded['error'];
      if (error is String) codes.add(error);
      final errors = decoded['errors'];
      if (errors is List) codes.addAll(errors.whereType<String>());
    }
  } catch (_) {}

  if (statusCode == 429) {
    final seconds = int.tryParse((retryAfterHeader ?? '').trim());
    return EmailCodeException(EmailCodeErrorKind.rateLimited, retryAfter: seconds != null && seconds > 0 ? Duration(seconds: seconds) : _defaultRetryAfter, statusCode: statusCode);
  }
  bool has(String code) => codes.any((c) => c.contains(code));
  final kind = has('invalid_code')
      ? EmailCodeErrorKind.invalidCode
      : has('code_expired')
          ? EmailCodeErrorKind.codeExpired
          : has('notification_failed') || statusCode == 502
              ? EmailCodeErrorKind.notificationFailed
              : has('invalid_grant') || statusCode == 401
                  ? EmailCodeErrorKind.invalidGrant
                  : EmailCodeErrorKind.other;
  return EmailCodeException(kind, statusCode: statusCode);
}
