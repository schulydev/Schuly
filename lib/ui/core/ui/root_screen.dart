import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../l10n/app_localizations.dart';
import '../../../services/active_account_service.dart';
import '../../../services/app_mode_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/onboarding_service.dart';
import '../../../services/private_account_store.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../private/private_connect_flow.dart';

/// Tier-1 gate. In **account** mode the user signs in with Pocket ID; in
/// **private** mode they connect a school directly (no account) and the creds
/// live only on-device. Once past the gate, [DashboardScreen] owns the rest.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool? _ready; // signed in (account) or connected (private)
  bool _onboarded = true; // assume seen until loaded, to avoid a flash
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // React to session changes (incl. a failed silent refresh) and mode switches.
    AuthService.sessionEpoch.addListener(_refresh);
    AppModeService.instance.addListener(_refresh);
    OnboardingService.seen().then((seen) {
      if (mounted) setState(() => _onboarded = seen);
    });
    _refresh();
  }

  @override
  void dispose() {
    AuthService.sessionEpoch.removeListener(_refresh);
    AppModeService.instance.removeListener(_refresh);
    super.dispose();
  }

  Future<void> _refresh() async {
    if (AppModeService.instance.isPrivate) {
      final account = await PrivateAccountStore.instance.load();
      if (mounted) setState(() => _ready = account != null);
      return;
    }
    final token = await AuthService.getAccessToken();
    if (token == null) {
      await ActiveAccountService.instance.clear();
    }
    if (mounted) setState(() => _ready = token != null);
  }

  Future<void> _signIn({bool register = false}) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await AuthService.signIn(register: register);
      await _refresh();
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _connectPrivate() async {
    final ok = await runPrivateConnectFlow(context);
    if (ok) await _refresh();
  }

  // Onboarding mode choice: mark it seen, select the mode, then run the
  // matching gate flow. If the user backs out of sign-in/connect they land on
  // the normal gate (onboarding won't show again).
  Future<void> _onboardWithAccount() async {
    await OnboardingService.markSeen();
    if (mounted) setState(() => _onboarded = true);
    await AppModeService.instance.setMode(AppMode.account);
    // New users coming through onboarding start on the registration screen.
    await _signIn(register: true);
  }

  Future<void> _onboardWithPrivate() async {
    await OnboardingService.markSeen();
    if (mounted) setState(() => _onboarded = true);
    await AppModeService.instance.setMode(AppMode.private);
    await _connectPrivate();
  }

  Future<void> _signOut() async {
    if (AppModeService.instance.isPrivate) {
      await PrivateAccountStore.instance.clear();
      await AppModeService.instance.setMode(AppMode.account);
    } else {
      await AuthService.signOut();
      await ActiveAccountService.instance.clear();
    }
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final ready = _ready;

    if (ready == null) {
      return const FScaffold(child: Center(child: FCircularProgress()));
    }
    if (ready) {
      return DashboardScreen(onSignOut: _signOut);
    }
    // First run: explain the app and let the user pick a mode.
    if (!_onboarded) {
      return OnboardingScreen(
        onChooseAccount: _onboardWithAccount,
        onChoosePrivate: _onboardWithPrivate,
      );
    }

    final colors = context.theme.colors;
    final isPrivate = AppModeService.instance.isPrivate;

    return FScaffold(
      header: const FHeader(title: Text('Schuly')),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            if (isPrivate) ...[
              const Text(
                'Private mode - no account, nothing stored on a server.',
                textAlign: TextAlign.center,
              ),
              FButton(
                onPress: _busy ? null : _connectPrivate,
                child: const Text('Connect a school'),
              ),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => AppModeService.instance.setMode(AppMode.account),
                child: const Text('Use an account instead'),
              ),
            ] else ...[
              const Text(
                'Sign in to your Schuly account to continue.',
                textAlign: TextAlign.center,
              ),
              FButton(
                onPress: _busy ? null : _signIn,
                child: Text(_busy ? 'Waiting for browser…' : t.signIn),
              ),
              FButton(
                style: FButtonStyle.outline(),
                onPress: () => AppModeService.instance.setMode(AppMode.private),
                child: const Text('Use without an account'),
              ),
            ],
            if (_error != null)
              SelectableText(_error!,
                  style: TextStyle(color: colors.destructive)),
          ],
        ),
      ),
    );
  }
}
