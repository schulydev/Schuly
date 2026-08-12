import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/totp_service.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.border, width: 2),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: MobileScanner(onDetect: _onDetect),
                ),
              ),
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
