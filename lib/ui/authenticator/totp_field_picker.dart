import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/totp_vault.dart';
import 'add_totp_screen.dart';

/// Login-form control for a `totp` field. Instead of typing a raw secret, the
/// user picks a saved authenticator from the [TotpVault] or adds a new one
/// (scanning a QR or entering a key) - the same vault the in-app authenticator
/// uses. The chosen entry's normalized base32 secret is written into
/// [controller] so the connect flow submits it unchanged. Provider-agnostic:
/// rendered for any system that advertises a `totp` field.
class TotpFieldPicker extends StatefulWidget {
  final TextEditingController controller;
  final SchoolSystemLoginField field;

  const TotpFieldPicker({required this.controller, required this.field, super.key});

  @override
  State<TotpFieldPicker> createState() => _TotpFieldPickerState();
}

class _TotpFieldPickerState extends State<TotpFieldPicker> {
  List<TotpEntry> _entries = [];
  TotpEntry? _selected;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final entries = await TotpVault.instance.load();
    if (!mounted) return;
    setState(() {
      _entries = entries;
      // Re-resolve the current selection against the (possibly changed) vault by
      // matching the secret already in the controller.
      final current = widget.controller.text.trim();
      _selected = current.isEmpty ? null : entries.where((e) => e.secret == current).firstOrNull;
    });
  }

  void _select(TotpEntry? entry) {
    setState(() {
      _selected = entry;
      widget.controller.text = entry?.secret ?? '';
    });
  }

  Future<void> _openMenu() async {
    final action = await showFDialog<_PickerAction>(
      context: context,
      builder: (ctx, style, animation) => FDialog(
        animation: animation,
        title: Text(widget.field.label),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FTile(
              prefix: const Icon(FIcons.ban),
              title: const Text('None'),
              suffix: _selected == null ? const Icon(FIcons.check) : null,
              onPress: () => Navigator.of(ctx).pop(const _PickerAction.none()),
            ),
            for (final e in _entries)
              FTile(
                prefix: const Icon(FIcons.keyRound),
                title: Text(e.title),
                subtitle: e.subtitle == null ? null : Text(e.subtitle!),
                suffix: _selected?.id == e.id ? const Icon(FIcons.check) : null,
                onPress: () => Navigator.of(ctx).pop(_PickerAction.select(e)),
              ),
            FTile(
              prefix: const Icon(FIcons.plus),
              title: const Text('Add new authenticator'),
              onPress: () => Navigator.of(ctx).pop(const _PickerAction.add()),
            ),
          ],
        ),
        actions: [
          FButton(style: FButtonStyle.outline(), onPress: () => Navigator.of(ctx).pop(), child: const Text('Close')),
        ],
      ),
    );
    if (action == null || !mounted) return;

    switch (action.kind) {
      case _PickerKind.none:
        _select(null);
      case _PickerKind.select:
        _select(action.entry);
      case _PickerKind.add:
        final added = await Navigator.of(context).push<TotpEntry>(
          MaterialPageRoute(builder: (_) => const AddTotpScreen()),
        );
        if (added == null || !mounted) return;
        await _load();
        _select(added);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final selected = _selected;
    final subtitle = selected == null
        ? 'Not set — tap to choose'
        : [selected.title, if (selected.subtitle != null) selected.subtitle].join(' · ');
    return FCard(
      child: FTile(
        prefix: const Icon(FIcons.shieldCheck),
        title: Text(widget.field.label),
        subtitle: Text(subtitle, style: selected == null ? TextStyle(color: colors.mutedForeground) : null),
        suffix: const Icon(FIcons.chevronRight),
        onPress: _openMenu,
      ),
    );
  }
}

enum _PickerKind { none, select, add }

/// Result of the picker menu - which action the user chose.
class _PickerAction {
  final _PickerKind kind;
  final TotpEntry? entry;
  const _PickerAction.none() : kind = _PickerKind.none, entry = null;
  const _PickerAction.add() : kind = _PickerKind.add, entry = null;
  const _PickerAction.select(this.entry) : kind = _PickerKind.select;
}
