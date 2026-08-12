import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  OnboardingService._();

  static const _key = 'onboarding.seen.v1';

  static Future<bool> seen() async =>
      (await SharedPreferences.getInstance()).getBool(_key) ?? false;

  static Future<void> markSeen() async =>
      (await SharedPreferences.getInstance()).setBool(_key, true);
}
