import 'package:flutter/material.dart';

import '../../services/microsoft_service.dart';
import 'microsoft_login_screen.dart';

/// Runs the whole Microsoft link: ask the backend for the authorize URL, show the WebView, then
/// finish with the captured code. Returns the linked account, or null if the student backed out.
/// Throws if the link failed. The caller shows the result.
Future<MicrosoftAccount?> linkMicrosoftAccount(BuildContext context) async {
  final start = await MicrosoftService.instance.startLink();
  if (!context.mounted) return null;

  final redirect = await Navigator.of(context).push<MicrosoftRedirect>(MaterialPageRoute(
    builder: (_) => MicrosoftLoginScreen(authorizeUrl: start.authorizeUrl, redirectUri: start.redirectUri),
  ));
  if (redirect == null) return null;

  final code = redirect.code;
  if (code == null || code.isEmpty) throw StateError(redirect.error ?? 'Microsoft sign-in failed');
  return MicrosoftService.instance.completeLink(code);
}
