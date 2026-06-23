import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../services/private_account_store.dart';
import '../../services/totp_service.dart';

/// In-app authenticator for the connected private-mode school. Schuly acts as
/// the TOTP client: it generates the current code from the vaulted seed and
/// refreshes it every second, with a countdown and tap-to-copy — so the code is
/// available for use elsewhere, not just for Schuly's own re-login.
class AuthenticatorScreen extends StatefulWidget {
  const AuthenticatorScreen({super.key});

  @override
  State<AuthenticatorScreen> createState() => _AuthenticatorScreenState();
}

class _AuthenticatorScreenState extends State<AuthenticatorScreen> {
  Timer? _timer;
  bool _loading = true;
  TotpConfig? _config;
  String _title = 'Authenticator';
  TotpCode? _code;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final account = await PrivateAccountStore.instance.load();
    final config = TotpConfig.tryParse(account?.totpSecret);
    if (!mounted) return;
    setState(() {
      _config = config;
      _title = account?.displayName ?? 'Authenticator';
      _code = config == null ? null : TotpService.generate(config);
      _loading = false;
    });
    if (config != null) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
  }

  void _tick() {
    final config = _config;
    if (config == null) return;
    setState(() => _code = TotpService.generate(config));
  }

  Future<void> _copy() async {
    final code = _code?.code;
    if (code == null) return;
    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;
    showFToast(context: context, title: const Text('Code copied'));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// `123456` → `123 456` for readability; leaves other lengths untouched.
  String _format(String code) {
    if (code.length != 6) return code;
    return '${code.substring(0, 3)} ${code.substring(3)}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return FScaffold(
      header: FHeader.nested(
        title: const Text('Authenticator'),
        prefixes: [
          FHeaderAction.back(onPress: () => Navigator.of(context).pop()),
        ],
      ),
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _config == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No authenticator secret is stored for this connection. '
                      'Reconnect and scan or enter your TOTP code to enable it.',
                      textAlign: TextAlign.center,
                      style: typography.sm
                          .copyWith(color: colors.mutedForeground),
                    ),
                  ),
                )
              : _content(context),
    );
  }

  Widget _content(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final code = _code;
    final fraction = code?.fraction ?? 0;
    final low = (code?.secondsRemaining ?? 0) <= 5;
    final accent = low ? colors.destructive : colors.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _title,
            textAlign: TextAlign.center,
            style: typography.lg.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            'Tap the code to copy',
            textAlign: TextAlign.center,
            style: typography.sm.copyWith(color: colors.mutedForeground),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _copy,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: colors.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                code == null ? '------' : _format(code.code),
                textAlign: TextAlign.center,
                style: typography.xl4.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 6,
              backgroundColor: colors.muted,
              valueColor: AlwaysStoppedAnimation(accent),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Refreshes in ${code?.secondsRemaining ?? 0}s',
            textAlign: TextAlign.center,
            style: typography.sm.copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
