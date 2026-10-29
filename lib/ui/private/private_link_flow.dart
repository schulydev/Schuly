import 'package:flutter/widgets.dart' show BuildContext, Navigator;
import 'package:flutter/material.dart' show MaterialPageRoute;

import '../../services/private_link_service.dart';
import '../../services/private_linked_account_store.dart';
import '../linking/capture_browser_screen.dart';

/// Private mode: links the account [provider] (named by the school's login method) in the capture
/// browser and keeps it on the device. Returns null if the person backed out; throws with the
/// real reason if the link failed.
Future<PrivateLinkedAccount?> linkPrivateAccount(BuildContext context, String provider) async {
  final service = PrivateLinkService.instance;
  final start = await service.start(provider);
  if (!context.mounted) return null;
  final captured = await Navigator.of(context).push<CaptureResult>(MaterialPageRoute(
    builder: (_) => CaptureBrowserScreen(url: start.authorizeUrl, callbackPrefix: start.redirectUri, cookieDomains: privateCaptureCookieHosts, title: 'Sign in'),
  ));
  if (captured == null) return null;
  final redirect = privateLinkRedirect(captured.callbackUrl, start.redirectUri);
  final code = redirect?.code;
  if (code == null || code.isEmpty) throw StateError(redirect?.error ?? 'Sign-in failed');
  return service.complete(provider, start, code, captured.cookies);
}
