import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../services/auth_service.dart';

enum _Step { signIn, register, code, forgot }

/// Native sign-in against the Schuly server: sign in, create an account, the
/// two-factor code step and a password reset request. Pops with true once signed in.
class SignInScreen extends StatefulWidget {
  final bool register;

  const SignInScreen({this.register = false, super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late _Step _step = widget.register ? _Step.register : _Step.signIn;
  final _identifier = TextEditingController();
  final _userName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _code = TextEditingController();
  TwoFactorChallenge? _challenge;
  bool _rememberDevice = true;
  bool _usingRecoveryCode = false;
  bool _busy = false;
  String? _error;
  String? _notice;
  List<SignInProvider> _providers = const [];

  @override
  void initState() {
    super.initState();
    AuthService.providers().then((providers) {
      if (mounted) setState(() => _providers = providers);
    });
  }

  @override
  void dispose() {
    for (final c in [_identifier, _userName, _email, _password, _code]) {
      c.dispose();
    }
    super.dispose();
  }

  void _go(_Step step) => setState(() {
        _step = step;
        _error = null;
        _notice = null;
        _code.clear();
      });

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } catch (_) {
      if (mounted) setState(() => _error = 'Schuly is not reachable right now. Try again in a moment.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _submit() async {
    switch (_step) {
      case _Step.signIn:
        await _run(() async {
          final challenge = await AuthService.signIn(_identifier.text.trim(), _password.text);
          if (challenge == null) {
            if (mounted) Navigator.of(context).pop(true);
            return;
          }
          setState(() {
            _challenge = challenge;
            _step = _Step.code;
          });
        });
      case _Step.code:
        await _run(() async {
          try {
            await AuthService.verifyCode(_challenge!, _code.text.trim(), rememberDevice: _rememberDevice);
          } on AuthException catch (e) {
            _code.clear();
            if (e.statusCode == 429 || _usingRecoveryCode) rethrow;
            throw const AuthException("That code didn't work. Wait for the next code in your app and enter that one.");
          }
          if (mounted) Navigator.of(context).pop(true);
        });
      case _Step.register:
        await _run(() async {
          await AuthService.register(_userName.text.trim(), _email.text.trim(), _password.text);
          if (mounted) Navigator.of(context).pop(true);
        });
      case _Step.forgot:
        await _run(() async {
          await AuthService.requestPasswordReset(_email.text.trim());
          if (mounted) setState(() => _notice = 'If an account with a confirmed address exists for ${_email.text.trim()}, a reset link is on its way.');
        });
    }
  }

  Future<void> _signInWith(SignInProvider provider) => _run(() async {
        final challenge = await AuthService.signInWithProvider(provider.key);
        if (challenge == null) {
          if (mounted) Navigator.of(context).pop(true);
          return;
        }
        setState(() {
          _challenge = challenge;
          _step = _Step.code;
        });
      });

  String get _title => switch (_step) {
        _Step.signIn => 'Welcome back',
        _Step.register => 'Create your account',
        _Step.code => 'One more step',
        _Step.forgot => 'Forgot your password?',
      };

  String get _subtitle => switch (_step) {
        _Step.signIn => 'Sign in with your Schuly account.',
        _Step.register => 'We send a link to confirm your email.',
        _Step.code => _usingRecoveryCode ? 'Enter one of the recovery codes you saved when you set up two-factor.' : 'Enter the 6-digit code from your authenticator app.',
        _Step.forgot => 'We email you a link to choose a new one.',
      };

  String get _action => switch (_step) {
        _Step.signIn => 'Continue',
        _Step.register => 'Create account',
        _Step.code => 'Verify',
        _Step.forgot => 'Send reset link',
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Schuly'),
        prefixes: [FHeaderAction.back(onPress: () => _step == _Step.code || _step == _Step.forgot ? _go(_Step.signIn) : Navigator.of(context).pop(false))],
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            Text(_title, style: theme.typography.xl2.copyWith(fontWeight: FontWeight.w600, color: theme.colors.foreground)),
            const SizedBox(height: 6),
            Text(_subtitle, style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground)),
            const SizedBox(height: 24),
            AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  if (_step == _Step.signIn) ...[
                    FTextField(
                      control: FTextFieldControl.managed(controller: _identifier),
                      label: const Text('Username or email'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.username, AutofillHints.email],
                      autocorrect: false,
                    ),
                    FTextField(
                      control: FTextFieldControl.managed(controller: _password),
                      label: const Text('Password'),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onSubmit: (_) => _busy ? null : _submit(),
                    ),
                  ],
                  if (_step == _Step.register) ...[
                    FTextField(
                      control: FTextFieldControl.managed(controller: _userName),
                      label: const Text('Username'),
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.newUsername],
                      autocorrect: false,
                    ),
                    FTextField(
                      control: FTextFieldControl.managed(controller: _email),
                      label: const Text('Email'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      autocorrect: false,
                    ),
                    FTextField(
                      control: FTextFieldControl.managed(controller: _password),
                      label: const Text('Password'),
                      description: const Text('At least 8 characters.'),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                    ),
                  ],
                  if (_step == _Step.code) ...[
                    FTextField(
                      control: FTextFieldControl.managed(controller: _code),
                      label: Text(_usingRecoveryCode ? 'Recovery code' : 'Authentication code'),
                      keyboardType: _usingRecoveryCode ? TextInputType.text : TextInputType.number,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      autocorrect: false,
                      onSubmit: (_) => _busy ? null : _submit(),
                    ),
                    FCheckbox(
                      label: const Text('Remember this device for 30 days'),
                      value: _rememberDevice,
                      onChange: (value) => setState(() => _rememberDevice = value),
                    ),
                  ],
                  if (_step == _Step.forgot)
                    FTextField(
                      control: FTextFieldControl.managed(controller: _email),
                      label: const Text('Email'),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      autocorrect: false,
                    ),
                  if (_error != null) Text(_error!, style: theme.typography.sm.copyWith(color: theme.colors.destructive)),
                  if (_notice != null) Text(_notice!, style: theme.typography.sm.copyWith(color: theme.colors.foreground)),
                  FButton(
                    onPress: _busy ? null : _submit,
                    child: _busy ? const SizedBox(width: 16, height: 16, child: FCircularProgress()) : Text(_action),
                  ),
                  if (_step == _Step.signIn) ...[
                    for (final provider in _providers)
                      FButton(
                        style: FButtonStyle.outline(),
                        onPress: _busy ? null : () => _signInWith(provider),
                        prefix: provider.iconUrl == null ? null : Image.network(provider.iconUrl!, width: 18, height: 18, errorBuilder: (_, _, _) => const SizedBox.shrink()),
                        child: Text('Continue with ${provider.displayName}'),
                      ),
                    FButton(style: FButtonStyle.ghost(), onPress: () => _go(_Step.forgot), child: const Text('Forgot password?')),
                    FButton(style: FButtonStyle.outline(), onPress: () => _go(_Step.register), child: const Text('Create an account')),
                  ],
                  if (_step == _Step.register) FButton(style: FButtonStyle.ghost(), onPress: () => _go(_Step.signIn), child: const Text('I already have an account')),
                  if (_step == _Step.code)
                    FButton(
                      style: FButtonStyle.ghost(),
                      onPress: () => setState(() {
                        _usingRecoveryCode = !_usingRecoveryCode;
                        _code.clear();
                        _error = null;
                      }),
                      child: Text(_usingRecoveryCode ? 'Use your authenticator app' : 'Use a recovery code'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
