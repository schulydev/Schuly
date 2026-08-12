import 'package:flutter_test/flutter_test.dart';
import 'package:otp/otp.dart';
import 'package:schuly/services/totp_service.dart';

void main() {
  group('TotpConfig.tryParse', () {
    test('returns null for empty / null input', () {
      expect(TotpConfig.tryParse(null), isNull);
      expect(TotpConfig.tryParse('   '), isNull);
    });

    test('parses a bare base32 secret with defaults', () {
      final config = TotpConfig.tryParse('jbsw y3dp-ehpk 3pxp');
      expect(config, isNotNull);
      expect(config!.secret, 'JBSWY3DPEHPK3PXP');
      expect(config.digits, 6);
      expect(config.period, 30);
      expect(config.algorithm, Algorithm.SHA1);
    });

    test('parses a full otpauth URI including issuer/digits/period/algorithm', () {
      final config = TotpConfig.tryParse(
        'otpauth://totp/Example?secret=JBSWY3DPEHPK3PXP&issuer=Acme'
        '&digits=8&period=60&algorithm=SHA256',
      );
      expect(config, isNotNull);
      expect(config!.secret, 'JBSWY3DPEHPK3PXP');
      expect(config.digits, 8);
      expect(config.period, 60);
      expect(config.algorithm, Algorithm.SHA256);
      expect(config.issuer, 'Acme');
    });

    test('splits an Issuer:Account label when no issuer param is present', () {
      final config = TotpConfig.tryParse(
        'otpauth://totp/Schulnetz:alice@example.com?secret=JBSWY3DPEHPK3PXP',
      );
      expect(config!.issuer, 'Schulnetz');
      expect(config.account, 'alice@example.com');
    });

    test('returns null when the URI has no secret', () {
      expect(TotpConfig.tryParse('otpauth://totp/Example?issuer=Acme'), isNull);
    });
  });

  group('TotpService.generate', () {
    final config = TotpConfig.tryParse('JBSWY3DPEHPK3PXP')!;

    test('produces a code of the configured length, all digits', () {
      final result = TotpService.generate(config, at: DateTime.now());
      expect(result, isNotNull);
      expect(result!.code.length, 6);
      expect(RegExp(r'^\d+$').hasMatch(result.code), isTrue);
    });

    test('is deterministic for a fixed instant', () {
      final at = DateTime.fromMillisecondsSinceEpoch(1234567890000);
      expect(
        TotpService.generate(config, at: at)!.code,
        TotpService.generate(config, at: at)!.code,
      );
    });

    test('reports the seconds left in the current 30s window', () {
      final at = DateTime.fromMillisecondsSinceEpoch(59000);
      final result = TotpService.generate(config, at: at)!;
      expect(result.secondsRemaining, 1);
      expect(result.period, 30);
      expect(result.fraction, closeTo(1 / 30, 1e-9));
    });
  });

  group('TotpService.secretOf', () {
    test('extracts the base32 secret from an otpauth URI', () {
      expect(
        TotpService.secretOf(
          'otpauth://totp/X?secret=JBSWY3DPEHPK3PXP&issuer=Y',
        ),
        'JBSWY3DPEHPK3PXP',
      );
    });

    test('normalizes a spaced / lower-case bare secret', () {
      expect(TotpService.secretOf('jbsw y3dp'), 'JBSWY3DP');
    });
  });
}
