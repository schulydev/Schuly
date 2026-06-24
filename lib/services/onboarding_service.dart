import 'package:shared_preferences/shared_preferences.dart';

/// Tracks whether the first-run onboarding has been completed, persisted
/// locally. The flag is versioned so a future revamp can re-show it by bumping
/// the key.
class OnboardingService {
  OnboardingService._();

  static const _key = 'onboarding.seen.v1';

  static Future<bool> seen() async =>
      (await SharedPreferences.getInstance()).getBool(_key) ?? false;

  static Future<void> markSeen() async =>
      (await SharedPreferences.getInstance()).setBool(_key, true);
}
