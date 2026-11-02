package com.schuly.app

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.schuly.app/installer")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "install" -> result.success(installApk(call.argument<String>("path")))
                    "openInstallSettings" -> {
                        openInstallSettings()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun canInstall(): Boolean =
        Build.VERSION.SDK_INT < Build.VERSION_CODES.O || packageManager.canRequestPackageInstalls()

    private fun openInstallSettings() {
        val intent = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:$packageName"))
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    }

    private fun installApk(path: String?): String {
        if (path == null) return "failed"
        val file = File(path)
        // Only files the updater itself wrote (<cache>/updates/*.apk) may be installed.
        val updatesDir = File(cacheDir, "updates").canonicalFile
        val canonical = file.canonicalFile
        if (canonical.parentFile != updatesDir || canonical.extension != "apk" || !canonical.exists()) return "failed"
        if (!canInstall()) return "needsPermission"
        return try {
            val uri = FileProvider.getUriForFile(this, "$packageName.updates", canonical)
            val intent = Intent(Intent.ACTION_VIEW)
                .setDataAndType(uri, "application/vnd.android.package-archive")
                .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            "started"
        } catch (e: Exception) {
            "failed"
        }
    }

    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        // FCM's default_notification_channel_id meta-data (AndroidManifest.xml) needs
        // this channel to exist before a notification can be posted to it.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                getString(R.string.default_notification_channel_id),
                getString(R.string.default_notification_channel_name),
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager?.createNotificationChannel(channel)
        }
    }
}
