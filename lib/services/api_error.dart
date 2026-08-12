import 'package:dio/dio.dart';

/// Turns whatever the backend (or a plugin) returned into one sentence a person
/// can act on. Screens render this; nobody should be shown a raw response body.
class ApiError {
  ApiError._();

  static String describe(Object error) {
    if (error is DioException) {
      final fromBody = _fromBody(error.response?.data);
      if (fromBody != null) return fromBody;
      if (error.response?.statusCode != null) return _fromStatus(error.response!.statusCode!);
      return "Couldn't reach the server. Check your connection and try again.";
    }
    return _tidy(error.toString());
  }

  static String? _fromBody(Object? data) {
    if (data is Map) {
      for (final key in const ['message', 'detail', 'title', 'error_description', 'error']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) return _tidy(value);
      }
    }
    if (data is String && data.trim().isNotEmpty && !data.trimLeft().startsWith('<')) {
      return _tidy(data);
    }
    return null;
  }

  static String _fromStatus(int status) => switch (status) {
    400 => "That didn't work. Check the details you entered and try again.",
    401 => 'Your session has expired. Sign in again.',
    403 => "You don't have access to this.",
    404 => "We couldn't find that.",
    408 || 504 => 'The server took too long to answer. Try again.',
    429 => 'Too many attempts. Wait a moment and try again.',
    >= 500 => 'The server ran into a problem. Try again shortly.',
    _ => 'Something went wrong (error $status).',
  };

  /// Backends sometimes prefix a message with a heading it already contains,
  /// giving "MFA required: MFA required but ...". Collapse that, plus the
  /// doubled punctuation and whitespace it leaves behind.
  static String _tidy(String raw) {
    var s = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (s.startsWith('Exception: ')) s = s.substring(11);

    final colon = s.indexOf(': ');
    if (colon > 0) {
      final head = s.substring(0, colon).trim();
      final tail = s.substring(colon + 2).trim();
      if (tail.toLowerCase().startsWith(head.toLowerCase())) s = tail;
    }

    s = s.replaceAll(RegExp(r'\.{2,}'), '.').replaceAll(' .', '.').trim();
    if (s.isNotEmpty && !s.endsWith('.') && !s.endsWith('!') && !s.endsWith('?')) s = '$s.';
    return s.isEmpty ? 'Something went wrong.' : s;
  }
}
