import 'package:otp/otp.dart';

/// A parsed TOTP descriptor. Built from either a bare base32 secret or a full
/// `otpauth://totp/...` URI (as encoded in an authenticator QR code).
class TotpConfig {
  /// Normalized base32 secret - no spaces/dashes, upper-case.
  final String secret;
  final int digits;
  final int period; // seconds
  final Algorithm algorithm;
  final String? issuer;
  final String? account;

  const TotpConfig({
    required this.secret,
    this.digits = 6,
    this.period = 30,
    this.algorithm = Algorithm.SHA1,
    this.issuer,
    this.account,
  });

  /// Parses [raw], which may be a bare base32 secret or an `otpauth://` URI.
  /// Returns null when no usable secret can be extracted.
  static TotpConfig? tryParse(String? raw) {
    final input = raw?.trim() ?? '';
    if (input.isEmpty) return null;

    if (input.toLowerCase().startsWith('otpauth://')) {
      final uri = Uri.tryParse(input);
      if (uri == null) return null;
      final secret = normalizeSecret(uri.queryParameters['secret'] ?? '');
      if (secret.isEmpty) return null;

      // Label is `Issuer:Account` (issuer optional); `issuer` query param wins.
      String? issuer = uri.queryParameters['issuer'];
      String? account =
          uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      if (account != null && account.contains(':')) {
        final parts = account.split(':');
        issuer ??= parts.first.trim();
        account = parts.sublist(1).join(':').trim();
      }

      return TotpConfig(
        secret: secret,
        digits: int.tryParse(uri.queryParameters['digits'] ?? '') ?? 6,
        period: int.tryParse(uri.queryParameters['period'] ?? '') ?? 30,
        algorithm: _algorithm(uri.queryParameters['algorithm']),
        issuer: (issuer?.isEmpty ?? true) ? null : issuer,
        account: (account?.isEmpty ?? true) ? null : account,
      );
    }

    final secret = normalizeSecret(input);
    return secret.isEmpty ? null : TotpConfig(secret: secret);
  }

  /// Strips spaces/dashes and upper-cases - accepts the way authenticators
  /// display seeds (grouped, lower-case) as well as the raw form.
  static String normalizeSecret(String s) =>
      s.replaceAll(RegExp(r'[\s-]'), '').toUpperCase();

  static Algorithm _algorithm(String? a) {
    switch ((a ?? '').toUpperCase()) {
      case 'SHA256':
        return Algorithm.SHA256;
      case 'SHA512':
        return Algorithm.SHA512;
      default:
        return Algorithm.SHA1;
    }
  }
}

/// A generated code together with how long it stays valid.
class TotpCode {
  final String code;
  final int secondsRemaining;
  final int period;
  const TotpCode({
    required this.code,
    required this.secondsRemaining,
    required this.period,
  });

  /// 1.0 right after a rollover → 0.0 just before the next one.
  double get fraction => period <= 0 ? 0 : secondsRemaining / period;
}

/// On-device TOTP (RFC 6238). Lets Schuly act as the authenticator: it both
/// powers the in-app code display and lets private-mode re-authenticate from a
/// vaulted seed without the user re-typing a 6-digit code.
class TotpService {
  TotpService._();

  /// Current code for [config] at [at] (defaults to now), or null if the secret
  /// can't be used (e.g. invalid base32).
  static TotpCode? generate(TotpConfig config, {DateTime? at}) {
    final now = at ?? DateTime.now();
    final period = config.period <= 0 ? 30 : config.period;
    try {
      final code = OTP.generateTOTPCodeString(
        config.secret,
        now.millisecondsSinceEpoch,
        length: config.digits,
        interval: period,
        algorithm: config.algorithm,
        isGoogle: true,
      );
      final epochSeconds = now.millisecondsSinceEpoch ~/ 1000;
      final remaining = period - (epochSeconds % period);
      return TotpCode(code: code, secondsRemaining: remaining, period: period);
    } catch (_) {
      return null;
    }
  }

  /// The base32 secret extracted from a stored seed/URI (what the backend
  /// `/login` expects), or null when none can be parsed.
  static String? secretOf(String? secretOrUri) =>
      TotpConfig.tryParse(secretOrUri)?.secret;

  /// Convenience: current code string for a stored seed/URI, or null.
  static String? codeFor(String? secretOrUri, {DateTime? at}) {
    final config = TotpConfig.tryParse(secretOrUri);
    return config == null ? null : generate(config, at: at)?.code;
  }
}
