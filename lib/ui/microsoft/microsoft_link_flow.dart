import 'package:flutter/material.dart';

import '../../services/microsoft_service.dart';
import 'microsoft_login_screen.dart';

/// Runs the whole Microsoft link: ask the backend for the authorize URL, show the WebView, then
/// finish with the captured code. Returns the linked account, or null if the student backed out
/// or it failed. The caller shows the result.
Future<MicrosoftAccount?> linkMicrosoftAccount(BuildContext context) async {
  final MicrosoftLinkStart start;
  try {
    start = await MicrosoftService.instance.startLink();
  } catch (_) {
    return null;
  }
  if (!context.mounted) return null;

  final code = await Navigator.of(context).push<String>(MaterialPageRoute(
    builder: (_) => MicrosoftLoginScreen(authorizeUrl: start.authorizeUrl, redirectUri: start.redirectUri),
  ));
  if (code == null || code.isEmpty) return null;

  try {
    return await MicrosoftService.instance.completeLink(code);
  } catch (_) {
    return null;
  }
}
