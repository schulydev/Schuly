import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../services/private_account_store.dart';
import '../../services/totp_service.dart';
import '../../services/totp_vault.dart';
import 'add_totp_screen.dart';

class _Row {
  final String? id;
  final String title;
  final String? subtitle;
  final TotpConfig config;
  const _Row({required this.id, required this.title, required this.config, this.subtitle});
}

class AuthenticatorVaultScreen extends StatefulWidget {
  const AuthenticatorVaultScreen({super.key});

  @override
  State<AuthenticatorVaultScreen> createState() => _AuthenticatorVaultScreenState();
}

class _AuthenticatorVaultScreenState extends State<AuthenticatorVaultScreen> {
  Timer? _timer;
  bool _loading = true;
  List<_Row> _rows = [];

  @override
  void initState() {
    super.initState();
    _load();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _rows.isNotEmpty) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final entries = await TotpVault.instance.load();
    final private = await PrivateAccountStore.instance.load();
    final rows = <_Row>[];

    final privateConfig = TotpConfig.tryParse(private?.totpSecret);
    if (privateConfig != null) {
      rows.add(_Row(id: null, title: private!.displayName, subtitle: 'Linked school', config: privateConfig));
    }

    for (final e in entries) {
      final config = TotpConfig.tryParse(e.secretOrUri);
      if (config == null) continue;
      rows.add(_Row(id: e.id, title: e.title, subtitle: e.subtitle, config: config));
    }

    if (!mounted) return;
    setState(() {
      _rows = rows;
      _loading = false;
    });
  }

  Future<void> _add() async {
    final added = await Navigator.of(context).push<TotpEntry>(
      MaterialPageRoute(builder: (_) => const AddTotpScreen()),
    );
    if (added != null) await _load();
  }

  Future<void> _copy(String? code) async {
    if (code == null) return;
    await Clipboard.setData(ClipboardData(text: code));
    if (!mounted) return;
    showFToast(context: context, title: const Text('Code copied'));
  }

  Future<void> _confirmDelete(_Row row) async {
    final id = row.id;
    if (id == null) return; // pinned rows aren't deletable
    final confirmed = await showFDialog<bool>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: const Text('Remove authenticator?'),
        body: Text('This deletes the saved 2FA secret for "${row.title}" from this device.'),
        actions: [
          FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          FButton(style: FButtonStyle.destructive(), onPress: () => Navigator.of(ctx).pop(true), child: const Text('Remove')),
        ],
      ),
    );
    if (confirmed != true) return;
    await TotpVault.instance.remove(id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader.nested(
        title: const Text('Authenticator'),
        prefixes: [FHeaderAction.back(onPress: () => Navigator.of(context).pop())],
        suffixes: [FHeaderAction(icon: const Icon(FIcons.plus), onPress: _add)],
      ),
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _rows.isEmpty
              ? _empty(context)
              : ListView.separated(
                  itemCount: _rows.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _CodeCard(
                    row: _rows[i],
                    onCopy: _copy,
                    onDelete: () => _confirmDelete(_rows[i]),
                  ),
                ),
    );
  }

  Widget _empty(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FIcons.keyRound, size: 48, color: colors.mutedForeground),
            const SizedBox(height: 16),
            Text(
              'No authenticators yet',
              style: typography.lg.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a 2FA account to generate its codes here. Scan the QR code shown '
              'when you set up two-factor authentication, or enter the setup key.',
              textAlign: TextAlign.center,
              style: typography.sm.copyWith(color: colors.mutedForeground),
            ),
            const SizedBox(height: 24),
            FButton(prefix: const Icon(FIcons.plus), onPress: _add, child: const Text('Add authenticator')),
          ],
        ),
      ),
    );
  }
}

class _CodeCard extends StatelessWidget {
  final _Row row;
  final Future<void> Function(String? code) onCopy;
  final VoidCallback onDelete;

  const _CodeCard({required this.row, required this.onCopy, required this.onDelete});

  String _format(String code) {
    if (code.length != 6) return code;
    return '${code.substring(0, 3)} ${code.substring(3)}';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final code = TotpService.generate(row.config);
    final fraction = code?.fraction ?? 0;
    final low = (code?.secondsRemaining ?? 0) <= 5;
    final accent = low ? colors.destructive : colors.primary;

    return FTappable(
      onPress: () => onCopy(code?.code),
      onLongPress: row.id == null ? null : onDelete,
      child: FCard(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: typography.base.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (row.subtitle != null)
                          Text(
                            row.subtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: typography.sm.copyWith(color: colors.mutedForeground),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${code?.secondsRemaining ?? 0}s',
                    style: typography.sm.copyWith(color: accent, fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                code == null ? '------' : _format(code.code),
                style: typography.xl3.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: fraction,
                  minHeight: 4,
                  backgroundColor: colors.muted,
                  valueColor: AlwaysStoppedAnimation(accent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
