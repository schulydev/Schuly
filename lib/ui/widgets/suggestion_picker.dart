import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';

/// A login field with known values: a tile that opens a searchable list and
/// fills the field, above the field itself so any other value can still be typed.
class SuggestionPicker extends StatefulWidget {
  final TextEditingController controller;
  final SchoolSystemLoginField field;
  final Widget textField;

  const SuggestionPicker({required this.controller, required this.field, required this.textField, super.key});

  @override
  State<SuggestionPicker> createState() => _SuggestionPickerState();
}

class _SuggestionPickerState extends State<SuggestionPicker> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_changed);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_changed);
    super.dispose();
  }

  void _changed() => setState(() {});

  LoginFieldSuggestion? get _selected {
    final value = widget.controller.text.trim().replaceAll(RegExp(r'/+$'), '').toLowerCase();
    for (final s in widget.field.suggestions) {
      if (s.value.toLowerCase() == value) return s;
    }
    return null;
  }

  Future<void> _pick() async {
    final picked = await showFSheet<LoginFieldSuggestion>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: 0.85,
      builder: (_) => _SuggestionSheet(suggestions: widget.field.suggestions),
    );
    if (picked != null) widget.controller.text = picked.value;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        FTile(
          prefix: const Icon(FIcons.school),
          title: Text(selected?.label ?? 'Choose your school'),
          subtitle: Text(selected == null ? 'Or enter the URL below' : 'Tap to choose another school'),
          suffix: const Icon(FIcons.chevronRight),
          onPress: _pick,
        ),
        widget.textField,
      ],
    );
  }
}

class _SuggestionSheet extends StatefulWidget {
  final List<LoginFieldSuggestion> suggestions;

  const _SuggestionSheet({required this.suggestions});

  @override
  State<_SuggestionSheet> createState() => _SuggestionSheetState();
}

class _SuggestionSheetState extends State<_SuggestionSheet> {
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<LoginFieldSuggestion> get _matches {
    final terms = _search.text.toLowerCase().split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
    return [
      for (final s in widget.suggestions)
        if (terms.every((t) => s.label.toLowerCase().contains(t) || s.value.toLowerCase().contains(t))) s,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final matches = _matches;
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: Border(top: BorderSide(color: theme.colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              Text('Choose your school', style: theme.typography.lg.copyWith(fontWeight: FontWeight.w600, color: theme.colors.foreground)),
              FTextField(
                control: FTextFieldControl.managed(controller: _search),
                hint: 'Search by name, canton or URL',
                autofocus: true,
                autocorrect: false,
              ),
              Flexible(
                child: matches.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text('No school matches. Close this and enter your school URL instead.', textAlign: TextAlign.center, style: theme.typography.sm.copyWith(color: theme.colors.mutedForeground)),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: matches.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final s = matches[index];
                          return FTile(
                            title: Text(s.label),
                            subtitle: Text(s.value),
                            onPress: () => Navigator.of(context).pop(s),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
