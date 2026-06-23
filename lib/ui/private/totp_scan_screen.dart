import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/totp_service.dart';

/// Scans an authenticator QR code and returns the raw payload (an
/// `otpauth://` URI, or a bare secret) to the caller. Only codes that parse as
/// a usable TOTP are accepted — other QR codes are ignored so the camera keeps
/// scanning. Pops with the scanned string, or null if cancelled.
///
/// The [MobileScanner] manages its own camera controller lifecycle.
class TotpScanScreen extends StatefulWidget {
  const TotpScanScreen({super.key});

  @override
  State<TotpScanScreen> createState() => _TotpScanScreenState();
}

class _TotpScanScreenState extends State<TotpScanScreen> {
  bool _handled = false;

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue;
      if (raw == null || TotpConfig.tryParse(raw) == null) continue;
      _handled = true;
      Navigator.of(context).pop(raw);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Scan TOTP code'),
        prefixes: [
          FHeaderAction.back(onPress: () => Navigator.of(context).pop()),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MobileScanner(onDetect: _onDetect),
            ),
          ),
          Text(
            'Point the camera at the authenticator QR code shown when you set '
            'up two-factor authentication.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
