import 'dart:async';

import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../../l10n/app_localizations.dart';
import '../../../services/active_account_service.dart';
import '../../../services/app_mode_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/linked_accounts_controller.dart';
import '../../../services/onboarding_service.dart';
import '../../../services/privacy_notice_service.dart';
import '../../../services/private_account_store.dart';
import '../../../services/private_linked_account_store.dart';
import '../../../services/push_service.dart';
import '../../../services/school_data_service.dart';
import '../../../services/secure_store.dart';
import '../../auth/sign_in_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../privacy/privacy_notice_screen.dart';
import '../../private/private_connect_flow.dart';
import '../../update/check_for_updates.dart';

/// Full sign-out: clears tokens, the active school, cached school data, and
/// any on-disk private-mode credentials, then drops the app back to account
/// mode. Shared by the sign-out action and account deletion.
Future<void> signOutAndClear() async {
  if (AppModeService.instance.isPrivate) {
    await PrivateAccountStore.instance.clear();
    await PrivateLinkedAccountStore.instance.clear();
    await PrivacyNoticeService.clearDeviceRecord();
    await AppModeService.instance.setMode(AppMode.account);
  } else {
    // Delete the device on the backend before signing out, while the access
    // token is still valid.
    await PushService.instance.onSignOut();
    await AuthService.signOut();
    await ActiveAccountService.instance.clear();
    LinkedAccountsController.instance.clear();
  }
  SchoolDataService.instance.clear();
  await SchoolDataService.instance.clearCache();
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  /// The longest the startup session check may take. After that the app shows
  /// the sign-in screen instead of a spinner, whatever is still pending.
  static Duration bootstrapTimeout = const Duration(seconds: 15);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool? _ready; // signed in (account) or connected (private)
  bool _onboarded = true; // assume seen until loaded, to avoid a flash
  bool _busy = false;
  String? _error;

  /// The privacy notice still to confirm. Checked in the background, so no network call decides whether the app starts.
  PrivacyNoticeInfo? _openNotice;

  /// Shown above the sign-in buttons when startup had to give up on the stored session.
  String? _notice;

  @override
  void initState() {
    super.initState();
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

  /// Decides between the dashboard and the sign-in screen. Bounded by
  /// [RootScreen.bootstrapTimeout]: a keystore or plugin that never answers
  /// ends on the sign-in screen with a notice, never on an endless spinner.
  Future<void> _refresh() async {
    bool ready;
    try {
      ready = await _resolveSession().timeout(RootScreen.bootstrapTimeout);
    } catch (e) {
      debugPrint('RootScreen: startup session check failed ($e)');
      ready = false;
      SecureStore.wasReset.value = true;
    }
    if (!mounted) return;
    // Say it once: the next sign-out is an ordinary one.
    final lostSession = !ready && SecureStore.wasReset.value;
    SecureStore.wasReset.value = false;
    setState(() {
      _ready = ready;
      _notice = lostSession ? 'Please sign in again.' : null;
    });
    if (ready && !AppModeService.instance.isPrivate) unawaited(_announceSignedIn());
    if (ready) {
      unawaited(_checkPrivacyNotice());
    } else if (_openNotice != null) {
      setState(() => _openNotice = null);
    }
  }

  /// Reads only the device: no network call decides whether the app starts.
  Future<bool> _resolveSession() async {
    if (AppModeService.instance.isPrivate) {
      final account = await PrivateAccountStore.instance.load();
      if (account == null) SchoolDataService.instance.clear();
      return account != null;
    }
    // A stored refresh token is a session even while the server is out of
    // reach - the dashboard shows its own offline state, and a session the
    // server ended comes back as a 401 that signs out. Without one, only a
    // still-valid cached access token counts (that lookup needs no network).
    final signedIn = await AuthService.hasSession() || await AuthService.getAccessToken() != null;
    if (!signedIn) {
      await ActiveAccountService.instance.clear();
      SchoolDataService.instance.clear();
    }
    return signedIn;
  }

  Future<void> _checkPrivacyNotice() async {
    final open = await PrivacyNoticeService.instance.pending();
    if (mounted) setState(() => _openNotice = open);
  }

  Future<void> _announceSignedIn() async {
    try {
      final token = await AuthService.getAccessToken();
      if (token != null) await PushService.instance.onSignedIn();
    } catch (e) {
      debugPrint('RootScreen: push registration skipped ($e)');
    }
  }

  Future<void> _signIn({bool register = false}) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final signedIn = await Navigator.of(context).push<bool>(MaterialPageRoute(builder: (_) => SignInScreen(register: register)));
      if (signedIn == true) await _refresh();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _connectPrivate() async {
    final ok = await runPrivateConnectFlow(context);
    if (ok) await _refresh();
  }

  Future<void> _onboardWithAccount() async {
    await OnboardingService.markSeen();
    if (mounted) setState(() => _onboarded = true);
    await AppModeService.instance.setMode(AppMode.account);
    await _signIn(register: true);
  }

  Future<void> _onboardWithPrivate() async {
    await OnboardingService.markSeen();
    if (mounted) setState(() => _onboarded = true);
    await AppModeService.instance.setMode(AppMode.private);
    await _connectPrivate();
  }

  Future<void> _signOut() async {
    await signOutAndClear();
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
      final notice = _openNotice;
      if (notice != null) {
        return PrivacyNoticeScreen(
          info: notice,
          onAccepted: () => setState(() => _openNotice = null),
          onSignOut: _signOut,
        );
      }
      return DashboardScreen(onSignOut: _signOut);
    }
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
            if (_notice != null)
              Text(
                _notice!,
                textAlign: TextAlign.center,
                style: context.theme.typography.sm.copyWith(color: colors.mutedForeground),
              ),
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
                child: Text(t.signIn),
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
            const CheckForUpdatesLink(),
          ],
        ),
      ),
    );
  }
}
