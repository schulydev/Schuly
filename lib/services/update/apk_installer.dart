import 'dart:io';

import 'package:flutter/services.dart';

enum InstallLaunch { started, needsPermission, failed }

/// Android-only bridge to the system package installer (see MainActivity.kt).
class ApkInstaller {
  const ApkInstaller();

  static const _channel = MethodChannel('com.schuly.app/installer');

  bool get supported => Platform.isAndroid;

  /// Opens the system installer for the APK at [path].
  Future<InstallLaunch> install(String path) async {
    try {
      final result = await _channel.invokeMethod<String>('install', {'path': path});
      return switch (result) {
        'started' => InstallLaunch.started,
        'needsPermission' => InstallLaunch.needsPermission,
        _ => InstallLaunch.failed,
      };
    } on PlatformException {
      return InstallLaunch.failed;
    } on MissingPluginException {
      return InstallLaunch.failed;
    }
  }

  /// Opens the "Install unknown apps" screen for this app.
  Future<void> openInstallSettings() async {
    try {
      await _channel.invokeMethod<void>('openInstallSettings');
    } on PlatformException {
      // Nothing to do: the user is told the path in words as well.
    }
  }
}
