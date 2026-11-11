import 'dart:io' show Platform;

/// Builds for Google Play and the App Store (`--dart-define=STORE_BUILD=true`). The store updates the app there,
/// so the in-app updater is off and "please update" opens the store page instead of the GitHub release.
const storeBuild = bool.fromEnvironment('STORE_BUILD');

/// The App Store id of the app (the number in its apps.apple.com link), set once the app exists there.
const appStoreId = String.fromEnvironment('APP_STORE_ID');

/// The store page of this app, or null outside a store build.
Uri? get storePage {
  if (!storeBuild) return null;
  if (Platform.isAndroid) return Uri.parse('https://play.google.com/store/apps/details?id=com.schuly.app');
  if (Platform.isIOS && appStoreId.isNotEmpty) return Uri.parse('https://apps.apple.com/app/id$appStoreId');
  return null;
}
