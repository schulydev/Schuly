import 'package:firebase_core/firebase_core.dart';

/// Firebase project used only for push notifications. The four values are baked
/// in at build time via `--dart-define` (see `package.json` / the release
/// workflow), so no `google-services.json` / `GoogleService-Info.plist` lives in
/// the repo. When any value is missing (e.g. a local dev build without the
/// defines), push is simply unavailable - [isConfigured] is false and nothing
/// in `lib/services/push_service.dart` attempts to touch Firebase.
class FirebaseConfig {
  FirebaseConfig._();

  static const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const senderId = String.fromEnvironment('FIREBASE_SENDER_ID');
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

  static bool get isConfigured => apiKey.isNotEmpty && appId.isNotEmpty && senderId.isNotEmpty && projectId.isNotEmpty;

  static FirebaseOptions get options => FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: senderId, projectId: projectId);
}
