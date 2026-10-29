import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/email_verification.dart';

void main() {
  group('EmailVerificationChallenge.tryParse', () {
    test('parses a code challenge', () {
      final c = EmailVerificationChallenge.tryParse({
        'email_verification_required': true,
        'challenge': 'abc',
        'expires_in': 3600,
        'method': 'code',
        'email': 'a***@example.com',
      });
      expect(c, isNotNull);
      expect(c!.challenge, 'abc');
      expect(c.email, 'a***@example.com');
      expect(c.expiresIn, 3600);
      expect(c.isCode, isTrue);
    });

    test('a non-code method is not a code', () {
      final c = EmailVerificationChallenge.tryParse({'email_verification_required': true, 'challenge': 'abc', 'method': 'link'});
      expect(c!.isCode, isFalse);
      expect(c.email, '');
    });

    test('returns null for token responses and malformed bodies', () {
      expect(EmailVerificationChallenge.tryParse({'access_token': 'x'}), isNull);
      expect(EmailVerificationChallenge.tryParse({'email_verification_required': true}), isNull);
      expect(EmailVerificationChallenge.tryParse(null), isNull);
      expect(EmailVerificationChallenge.tryParse('nope'), isNull);
    });
  });

  group('mapEmailCodeError', () {
    test('reads the error field', () {
      expect(mapEmailCodeError(400, '{"error":"invalid_code"}').kind, EmailCodeErrorKind.invalidCode);
      expect(mapEmailCodeError(400, '{"error":"code_expired"}').kind, EmailCodeErrorKind.codeExpired);
      expect(mapEmailCodeError(401, '{"error":"invalid_grant"}').kind, EmailCodeErrorKind.invalidGrant);
    });

    test('reads the errors array', () {
      expect(mapEmailCodeError(400, '{"errors":["invalid_code"]}').kind, EmailCodeErrorKind.invalidCode);
    });

    test('falls back to the status code', () {
      expect(mapEmailCodeError(401, '').kind, EmailCodeErrorKind.invalidGrant);
      expect(mapEmailCodeError(502, 'oops').kind, EmailCodeErrorKind.notificationFailed);
      expect(mapEmailCodeError(500, '{}').kind, EmailCodeErrorKind.other);
    });

    test('429 uses Retry-After, defaulting to 60 s', () {
      expect(mapEmailCodeError(429, '', retryAfterHeader: '42').retryAfter, const Duration(seconds: 42));
      expect(mapEmailCodeError(429, '').retryAfter, const Duration(seconds: 60));
      expect(mapEmailCodeError(429, '', retryAfterHeader: 'soon').retryAfter, const Duration(seconds: 60));
      expect(mapEmailCodeError(429, '').kind, EmailCodeErrorKind.rateLimited);
    });
  });
}
