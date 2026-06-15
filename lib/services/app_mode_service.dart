import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// How the app runs:
/// - [account] — full mode: Pocket ID sign-in + the Schuly backend account.
/// - [private] — no account; data is proxied statelessly and kept only on-device.
enum AppMode { account, private }

/// Holds the selected [AppMode], persisted locally. Mirrors [ThemeService]:
/// a singleton [ChangeNotifier] loaded once at startup.
class AppModeService extends ChangeNotifier {
  AppModeService._();
  static final AppModeService instance = AppModeService._();

  static const _key = 'app.mode';

  AppMode _mode = AppMode.account;
  AppMode get mode => _mode;
  bool get isPrivate => _mode == AppMode.private;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _mode = prefs.getString(_key) == AppMode.private.name
        ? AppMode.private
        : AppMode.account;
    notifyListeners();
  }

  Future<void> setMode(AppMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }
}
