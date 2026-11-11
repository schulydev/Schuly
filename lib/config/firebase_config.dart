import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Firebase project used only for push notifications. The four values are baked
/// in at build time via `--dart-define` (see `package.json` / the release
/// workflow), so no `google-services.json` / `GoogleService-Info.plist` lives in
/// the repo. When any value is missing (e.g. a local dev build without the
/// defines), push is simply unavailable - [isConfigured] is false and nothing
/// in `lib/services/push_service.dart` attempts to touch Firebase.
class FirebaseConfig {
  FirebaseConfig._();

  static const _androidApiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const _androidAppId = String.fromEnvironment('FIREBASE_APP_ID');
  static const _iosApiKey = String.fromEnvironment('FIREBASE_IOS_API_KEY');
  static const _iosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');

  // iOS is its own app in the Firebase project, with its own id and key.
  static String get apiKey => !kIsWeb && Platform.isIOS ? _iosApiKey : _androidApiKey;
  static String get appId => !kIsWeb && Platform.isIOS ? _iosAppId : _androidAppId;
  static const senderId = String.fromEnvironment('FIREBASE_SENDER_ID');
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

  static bool get isConfigured => apiKey.isNotEmpty && appId.isNotEmpty && senderId.isNotEmpty && projectId.isNotEmpty;

  static FirebaseOptions get options => FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: senderId, projectId: projectId);
}
