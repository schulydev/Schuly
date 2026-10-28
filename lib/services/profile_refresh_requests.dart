import 'package:flutter/foundation.dart';

/// A cross-screen flag set when the user has been sent to the web app's
/// settings (Settings -> Profile picture), so the dashboard re-reads the
/// profile the next time the app resumes.
class ProfileRefreshRequests {
  ProfileRefreshRequests._();

  static final ValueNotifier<bool> pending = ValueNotifier<bool>(false);

  static void request() => pending.value = true;

  static void clear() => pending.value = false;
}
