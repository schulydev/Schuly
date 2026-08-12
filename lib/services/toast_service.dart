import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

/// App-wide toasts. [navigatorKey] is attached to the root `MaterialApp`, and the
/// root `FToaster` wraps the navigator - so its context can surface a toast from
/// anywhere, including services that have no `BuildContext`. Use this for errors
/// and notices the user would otherwise never see (silent fetch/sync failures).
///
/// Alignment is intentionally left to the root `FToaster` (top-anchored) so all
/// toasts share one position.
class ToastService {
  ToastService._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void error(String title, [Object? detail]) =>
      _show(title, _clean(detail), FIcons.circleAlert);

  static void success(String title, [String? description]) =>
      _show(title, description, FIcons.circleCheck);

  static void info(String title, [String? description]) =>
      _show(title, description, FIcons.info);

  static void _show(String title, String? description, IconData icon) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    showFToast(
      context: context,
      icon: Icon(icon),
      title: Text(title),
      description: description == null || description.isEmpty ? null : Text(description),
    );
  }

  static String? _clean(Object? detail) {
    if (detail == null) return null;
    var s = detail.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
    if (s.startsWith('Exception: ')) s = s.substring(11);
    return s.length > 140 ? '${s.substring(0, 139)}…' : s;
  }
}
