import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import 'api_error.dart';

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

  /// Errors carry the destructive colour and stay longer: they are read, not glanced at.
  /// A toast is a glance, so the text is clipped here - a screen that can show the
  /// full message inline should do that instead of relying on this.
  static void error(String title, [Object? detail]) => _show(
    title,
    detail == null ? null : _clip(ApiError.describe(detail)),
    FIcons.circleAlert,
    severity: _Severity.error,
    duration: const Duration(seconds: 8),
  );

  static String _clip(String s) => s.length > 140 ? '${s.substring(0, 139)}…' : s;

  static void success(String title, [String? description]) =>
      _show(title, description, FIcons.circleCheck, severity: _Severity.success);

  static void info(String title, [String? description]) =>
      _show(title, description, FIcons.info, severity: _Severity.info);

  static void _show(String title, String? description, IconData icon, {required _Severity severity, Duration? duration}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final colors = context.theme.colors;
    showFToast(
      context: context,
      icon: Icon(icon),
      title: Text(title),
      description: description == null || description.isEmpty ? null : Text(description),
      duration: duration ?? const Duration(seconds: 5),
      style: (style) => switch (severity) {
        _Severity.error => style.copyWith(
          decoration: style.decoration.copyWith(
            color: colors.destructive,
            border: Border.all(color: colors.destructive),
          ),
          iconStyle: style.iconStyle.copyWith(color: colors.destructiveForeground),
          titleTextStyle: style.titleTextStyle.copyWith(color: colors.destructiveForeground),
          descriptionTextStyle: style.descriptionTextStyle.copyWith(color: colors.destructiveForeground),
        ),
        _ => style,
      },
    );
  }
}

enum _Severity { error, success, info }
