import 'package:flutter/material.dart' show OutlineInputBorder, RefreshIndicator;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../domain/grade_math.dart';
import '../theme/schuly_theme.dart';

/// Small helpers around Forui's own widgets for the redesigned screens. Lists are [FTileGroup]s and [FTile]s, buttons
/// [FButton]s, tags and grade pills [FBadge]s, segmented controls [FTabs], pictures [FAvatar]s; the theme in
/// `schuly_theme.dart` gives them the mockup's look. Only what Forui has no widget for is drawn here.

/// Every list on Home shows at most this many items; the rest lives on its own tab.
const int kHomeMaxItems = 3;

/// The horizontal page gutter.
const double kGutter = 16;

/// A scrolling page body: pull to refresh, the gutter, and room at the bottom.
class PageList extends StatelessWidget {
  const PageList({super.key, required this.onRefresh, required this.children, this.bottom = 24});

  final Future<void> Function() onRefresh;
  final List<Widget> children;
  final double bottom;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: onRefresh,
        color: context.tokens.ink,
        backgroundColor: context.tokens.card,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(kGutter, 0, kGutter, bottom),
          children: children,
        ),
      );
}

/// The big page title, with an optional line below and a control on the right.
class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {super.key, this.subtitle, this.trailing, this.bottom = 16});

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, bottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: typography.xl2.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.52)),
                if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(subtitle!, style: typography.sm.copyWith(color: context.theme.colors.mutedForeground))),
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );
  }
}

/// A section heading with an optional text link on the right.
class SectionHead extends StatelessWidget {
  const SectionHead(this.title, {super.key, this.link, this.onLink, this.top = 26});

  final String title;
  final String? link;
  final VoidCallback? onLink;
  final double top;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: top, bottom: 8),
        child: Row(
          children: [
            Expanded(child: Text(title, style: context.theme.typography.lg.copyWith(fontWeight: FontWeight.w600))),
            if (link != null) TextLink(link!, onPress: onLink),
          ],
        ),
      );
}

/// A ghost [FButton] in muted text, for "All grades", "Switch" and the like.
class TextLink extends StatelessWidget {
  const TextLink(this.text, {super.key, this.onPress});

  final String text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return FButton(
      onPress: onPress,
      mainAxisSize: MainAxisSize.min,
      style: FButtonStyle.ghost((s) => s.copyWith(
            contentStyle: (c) => c.copyWith(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              textStyle: FWidgetStateMap.all(context.theme.typography.sm.copyWith(color: colors.mutedForeground, height: 1)),
            ),
          )),
      child: Text(text),
    );
  }
}

/// A full-width, 48 px tall button for sheet footers and forms.
FBaseButtonStyle Function(FButtonStyle) blockButton(FBaseButtonStyle Function(FButtonStyle) Function([FButtonStyle Function(FButtonStyle)?]) variant, {Color? text}) => variant((s) => s.copyWith(
      decoration: s.decoration.map((d) => d.copyWith(borderRadius: BorderRadius.circular(SchulyRadii.list))),
      contentStyle: (c) => c.copyWith(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        textStyle: c.textStyle.map((t) => t.copyWith(fontSize: 15, color: text ?? t.color)),
      ),
    ));

/// An outlined button with the label in the destructive colour.
FBaseButtonStyle Function(FButtonStyle) dangerOutline(BuildContext context) =>
    FButtonStyle.outline((s) => s.copyWith(contentStyle: (c) => c.copyWith(textStyle: c.textStyle.map((t) => t.copyWith(color: context.theme.colors.destructive)))));

/// A tile group drawn as the larger profile card (radius 14).
FTileGroupStyle cardGroup(FTileGroupStyle s) => s.copyWith(decoration: s.decoration.copyWith(borderRadius: BorderRadius.circular(SchulyRadii.card)));

/// A small uppercase label.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text.toUpperCase(), style: context.theme.typography.xs.copyWith(fontWeight: FontWeight.w600, color: context.theme.colors.mutedForeground, letterSpacing: 0.5));
}

/// The chevron on a row that opens something.
Widget chevron() => const Icon(FIcons.chevronRight);

/// A tinted [FBadge]: grade pills and the "Now", "Test" and "Event" tags.
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, required this.color, required this.background, this.large = false, this.minWidth = 0});

  final String text;
  final Color color;
  final Color background;
  final bool large;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: FBadge(
        style: (_) => FBadgeStyle(
          decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(large ? SchulyRadii.list : (minWidth > 0 ? SchulyRadii.md : SchulyRadii.sm))),
          contentStyle: FBadgeContentStyle(
            labelTextStyle: large
                ? typography.xl2.copyWith(color: color, fontWeight: FontWeight.w600, height: 1.2)
                : typography.xs.copyWith(color: color, fontWeight: FontWeight.w600, fontSize: minWidth > 0 ? 13 : 11, height: minWidth > 0 ? 1.4 : 1.35),
            padding: large ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8) : (minWidth > 0 ? const EdgeInsets.symmetric(horizontal: 9, vertical: 3) : const EdgeInsets.symmetric(horizontal: 7, vertical: 1)),
          ),
        ),
        child: Center(widthFactor: 1, child: Text(text)),
      ),
    );
  }
}

/// A grade pill: green from 5, neutral from 4.5, amber from 4, red below.
class GradePill extends StatelessWidget {
  const GradePill(this.grade, {super.key, this.large = false});

  final num? grade;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final colors = context.theme.colors;
    final g = grade;
    final graded = isGradedScore(g);
    final (fg, bg) = !graded
        ? (colors.mutedForeground, colors.muted)
        : switch (gradeTone(g!)) {
            GradeTone.good => (t.good, t.goodBackground),
            GradeTone.ok => (t.ok, colors.muted),
            GradeTone.warn => (t.warn, t.warnBackground),
            GradeTone.bad => (t.bad, t.badBackground),
          };
    return Tag(graded ? gradeLabel(g!) : '-', color: fg, background: bg, large: large, minWidth: large ? 84 : 46);
  }
}

/// The colour of a grade dot on the 1 to 6 line.
Color gradeDotColor(BuildContext context, num grade) {
  final t = context.tokens;
  return switch (gradeTone(grade)) {
    GradeTone.good => t.good,
    GradeTone.ok => t.ok,
    GradeTone.warn => t.warn,
    GradeTone.bad => t.bad,
  };
}

/// A status in words with a dot before it.
class StatusLabel extends StatelessWidget {
  const StatusLabel(this.text, {super.key, required this.color, this.dot});

  final String text;
  final Color color;

  /// The dot's colour when it differs from the text's.
  final Color? dot;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: dot ?? color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Flexible(child: Text(text, style: context.theme.typography.sm.copyWith(color: color, fontWeight: FontWeight.w500))),
        ],
      );
}

/// The day of the week over the day of the month, as on a calendar page.
class DateTile extends StatelessWidget {
  const DateTile({super.key, required this.weekday, required this.day});

  final String weekday;
  final int day;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(SchulyRadii.base)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(weekday.toUpperCase(), style: typography.xs.copyWith(fontSize: 10, height: 1.1, color: colors.mutedForeground, letterSpacing: 0.4)),
          Text('$day', style: typography.base.copyWith(fontSize: 17, height: 1.1, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// A segmented control: Forui's [FTabs] with no content below.
class Segmented<T> extends StatelessWidget {
  const Segmented({super.key, required this.segments, required this.value, required this.onChange, this.width});

  final List<(T, String)> segments;
  final T value;
  final ValueChanged<T> onChange;

  /// The control's width; null fills the row.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final index = segments.indexWhere((s) => s.$1 == value);
    final tabs = FTabs(
      control: FTabControl.lifted(index: index < 0 ? 0 : index, onChange: (i) => onChange(segments[i].$1)),
      // One line always: a label that would wrap ("Verspätungen" in a third of a phone) shrinks a little instead.
      children: [for (final s in segments) FTabEntry(label: FittedBox(fit: BoxFit.scaleDown, child: Text(s.$2, maxLines: 1, softWrap: false)), child: const SizedBox.shrink())],
    );
    return SizedBox(width: width, child: tabs);
  }
}

/// A round picture with an initial when there is none, and an optional ring.
class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.url, required this.name, required this.size, this.ring});

  final String? url;
  final String? name;
  final double size;
  final Color? ring;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final initial = (name?.trim().isNotEmpty ?? false) ? name!.trim().characters.first.toUpperCase() : '?';
    final fallback = Text(initial, style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600, fontSize: size * 0.4));
    final avatar = (url == null || url!.isEmpty) ? FAvatar.raw(size: size, child: fallback) : FAvatar(size: size, image: NetworkImage(url!), fallback: fallback);
    if (ring == null) return avatar;
    return Container(padding: const EdgeInsets.all(1.5), decoration: BoxDecoration(shape: BoxShape.circle, color: ring), child: avatar);
  }
}

/// A label and a value in a tile, as in the contact details.
FTile keyValueTile(BuildContext context, String label, String value) {
  final typography = context.theme.typography;
  return FTile.raw(
    child: Row(
      children: [
        SizedBox(width: 96, child: Text(label, style: typography.sm.copyWith(color: context.theme.colors.mutedForeground))),
        const SizedBox(width: 12),
        Expanded(child: Text(value, style: typography.base)),
      ],
    ),
  );
}

/// A short centred note for empty states.
class EmptyNote extends StatelessWidget {
  const EmptyNote(this.title, {super.key, this.detail});

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 4),
      child: Column(
        children: [
          Text(title, textAlign: TextAlign.center, style: typography.base.copyWith(fontWeight: FontWeight.w500)),
          if (detail != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(detail!, textAlign: TextAlign.center, style: typography.base.copyWith(color: context.theme.colors.mutedForeground))),
        ],
      ),
    );
  }
}

/// A note block without an icon: Forui's [FAlert], muted, or red for a warning.
class Callout extends StatelessWidget {
  const Callout({super.key, required this.title, this.text, this.bad = false});

  final String title;
  final String? text;
  final bool bad;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    return FAlert(
      icon: const SizedBox.shrink(),
      title: Text(title),
      subtitle: text == null ? null : Text(text!),
      style: (_) => FAlertStyle(
        decoration: BoxDecoration(color: bad ? t.badBackground : colors.muted, borderRadius: BorderRadius.circular(SchulyRadii.list)),
        iconStyle: const IconThemeData(size: 0),
        titleTextStyle: typography.sm.copyWith(fontWeight: FontWeight.w500, color: bad ? t.bad : colors.foreground),
        subtitleTextStyle: typography.sm.copyWith(color: bad ? Color.lerp(t.bad, colors.foreground, 0.3) : colors.mutedForeground),
        padding: const EdgeInsets.fromLTRB(6, 12, 14, 12),
      ),
    );
  }
}

/// A pushed page in the mockup's style: "‹ Back" at the top, the big title with an optional action, then the content.
class SubPage extends StatelessWidget {
  const SubPage({super.key, required this.backLabel, required this.title, this.action, required this.children, this.onRefresh});

  final String backLabel;
  final String title;
  final Widget? action;
  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final head = [
      SizedBox(
        height: 48,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Transform.translate(
            offset: const Offset(-8, 0),
            child: FButton(
              onPress: () => Navigator.of(context).maybePop(),
              mainAxisSize: MainAxisSize.min,
              style: FButtonStyle.ghost((s) => s.copyWith(
                    contentStyle: (c) => c.copyWith(
                      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                      spacing: 2,
                      textStyle: FWidgetStateMap.all(context.theme.typography.base.copyWith(color: colors.mutedForeground, fontWeight: FontWeight.w500, height: 1)),
                      iconStyle: FWidgetStateMap.all(IconThemeData(color: colors.mutedForeground, size: 20)),
                    ),
                  )),
              prefix: const Icon(FIcons.chevronLeft),
              child: Text(backLabel),
            ),
          ),
        ),
      ),
      PageTitle(title, trailing: action),
    ];
    return FScaffold(
      childPad: false,
      child: SafeArea(
        bottom: false,
        child: PageList(onRefresh: onRefresh ?? () async {}, bottom: 24 + MediaQuery.viewPaddingOf(context).bottom, children: [...head, ...children]),
      ),
    );
  }
}

/// A compact [FSelect] field (36 px, 13 px medium text) for pickers next to a page title.
FSelectStyle Function(FSelectStyle) compactSelect(BuildContext context) => (s) => s.copyWith(
      selectFieldStyle: (f) => f.copyWith(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        contentTextStyle: f.contentTextStyle.map((t) => t.copyWith(fontSize: 13, fontWeight: FontWeight.w500)),
        border: f.border.map((b) => b is OutlineInputBorder ? b.copyWith(borderRadius: BorderRadius.circular(SchulyRadii.button), borderSide: b.borderSide.copyWith(color: context.theme.colors.border)) : b),
        fillColor: context.tokens.card,
      ),
    );
