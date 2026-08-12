import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../services/totp_service.dart';
import '../../services/totp_vault.dart';

/// Shown the moment an authenticator is added. Whoever issued the QR code
/// usually asks for a code straight away to confirm the new device, so the
/// first code is put in front of the user here rather than leaving them to
/// find the new entry in the list.
Future<void> showTotpAddedSheet(BuildContext context, TotpEntry entry) {
  final config = TotpConfig.tryParse(entry.secretOrUri);
  if (config == null) return Future.value();
  return showFSheet<void>(
    context: context,
    side: FLayout.btt,
    builder: (context) => _TotpAddedSheet(entry: entry, config: config),
  );
}

class _TotpAddedSheet extends StatefulWidget {
  final TotpEntry entry;
  final TotpConfig config;

  const _TotpAddedSheet({required this.entry, required this.config});

  @override
  State<_TotpAddedSheet> createState() => _TotpAddedSheetState();
}

class _TotpAddedSheetState extends State<_TotpAddedSheet> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(String code) => code.length == 6 ? '${code.substring(0, 3)} ${code.substring(3)}' : code;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final code = TotpService.generate(widget.config);
    final remaining = code?.secondsRemaining ?? 0;
    final expiring = remaining <= 5;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          Text(widget.entry.title, style: typography.lg.copyWith(fontWeight: FontWeight.w700)),
          if ((widget.entry.subtitle ?? '').isNotEmpty)
            Text(widget.entry.subtitle!, style: typography.sm.copyWith(color: colors.mutedForeground)),
          Text(
            'Enter this code where you scanned the QR code to confirm the new device.',
            style: typography.sm.copyWith(color: colors.mutedForeground),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                code == null ? '------' : _format(code.code),
                style: typography.xl2.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                '${remaining}s',
                style: typography.sm.copyWith(color: expiring ? colors.destructive : colors.mutedForeground),
              ),
            ],
          ),
          FButton(
            prefix: const Icon(FIcons.copy),
            onPress: code == null
                ? null
                : () async {
                    await Clipboard.setData(ClipboardData(text: code.code));
                    if (context.mounted) showFToast(context: context, title: const Text('Code copied'));
                  },
            child: const Text('Copy code'),
          ),
          FButton(
            style: FButtonStyle.outline(),
            onPress: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
