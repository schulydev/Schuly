import 'package:flutter/foundation.dart';

/// A cross-screen flag set when the user has been sent to the external
/// Keycloak avatar page (Settings -> Profile picture), so the dashboard
/// knows to force a claims refresh - with cache-busting on the picture URL -
/// the next time the app resumes, instead of waiting for the normal
/// staleness window.
class ProfileRefreshRequests {
  ProfileRefreshRequests._();

  static final ValueNotifier<bool> pending = ValueNotifier<bool>(false);

  static void request() => pending.value = true;

  static void clear() => pending.value = false;
}
