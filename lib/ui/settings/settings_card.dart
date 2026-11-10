import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../core/theme/schuly_theme.dart';

/// A settings section as on the web: a card with a heading, an optional line below it, and its rows as a tile group
/// with hairlines. [danger] tints the border and the heading for the danger zone.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.title, this.description, this.header, required this.children, this.danger = false});

  final String title;
  final String? description;

  /// Content between the heading and the rows, such as the accent swatches.
  final Widget? header;
  final List<FTileMixin> children;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final border = danger ? Color.lerp(colors.destructive, colors.border, 0.65)! : colors.border;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: context.tokens.card, border: Border.all(color: border), borderRadius: BorderRadius.circular(SchulyRadii.card)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: typography.lg.copyWith(fontWeight: FontWeight.w600, color: danger ? colors.destructive : null)),
                  if (description != null) Padding(padding: const EdgeInsets.only(top: 1), child: Text(description!, style: typography.sm.copyWith(color: colors.mutedForeground))),
                ],
              ),
            ),
            ?header,
            if (children.isNotEmpty)
              FTileGroup(
                divider: FItemDivider.full,
                style: (s) => s.copyWith(decoration: const BoxDecoration()),
                children: children,
              ),
          ],
        ),
      ),
    );
  }
}

/// A small uppercase group label inside a settings card, with a hairline above.
FTile settingsGroupLabel(BuildContext context, String text) => FTile.raw(
      style: (s) => s.copyWith(rawItemContentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 4))),
      child: Text(text.toUpperCase(), style: context.theme.typography.xs.copyWith(fontWeight: FontWeight.w600, color: context.theme.colors.mutedForeground, letterSpacing: 0.5)),
    );
