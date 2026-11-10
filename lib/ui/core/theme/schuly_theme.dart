
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// The six accents a student can pick. The accent marks what is active (the running lesson, the active tab, the
/// selected day, primary buttons, switches, the chosen radio, the average tick, the now line and "Done" in sheets).
/// Status colours (good, warn, bad) and calendar colours never follow it.
///
/// [primary] fills buttons and selected states, [primaryForeground] is the text on it, and [ink] is the accent as
/// text or line on the page background. Dark values come from the approved mockup, light values from Forui's light
/// accent themes.
enum AppAccent {
  zinc(
    dark: (primary: Color(0xFFE5E5E5), primaryForeground: Color(0xFF171717), ink: Color(0xFFFAFAFA)),
    light: (primary: Color(0xFF18181B), primaryForeground: Color(0xFFFAFAFA), ink: Color(0xFF18181B)),
    darkSwatch: Color(0xFFE4E4E7),
    lightSwatch: Color(0xFF18181B),
  ),
  blue(
    dark: (primary: Color(0xFF3B82F6), primaryForeground: Color(0xFF0F172A), ink: Color(0xFF60A5FA)),
    light: (primary: Color(0xFF2563EB), primaryForeground: Color(0xFFF8FAFC), ink: Color(0xFF2563EB)),
    darkSwatch: Color(0xFF2563EB),
    lightSwatch: Color(0xFF2563EB),
  ),
  violet(
    dark: (primary: Color(0xFF7C3AED), primaryForeground: Color(0xFFF8FAFC), ink: Color(0xFFA78BFA)),
    light: (primary: Color(0xFF7C3AED), primaryForeground: Color(0xFFF8FAFC), ink: Color(0xFF7C3AED)),
    darkSwatch: Color(0xFF7C3AED),
    lightSwatch: Color(0xFF7C3AED),
  ),
  green(
    dark: (primary: Color(0xFF22C55E), primaryForeground: Color(0xFF052E16), ink: Color(0xFF4ADE80)),
    light: (primary: Color(0xFF16A34A), primaryForeground: Color(0xFFF0FDF4), ink: Color(0xFF16A34A)),
    darkSwatch: Color(0xFF16A34A),
    lightSwatch: Color(0xFF16A34A),
  ),
  orange(
    dark: (primary: Color(0xFFEA580C), primaryForeground: Color(0xFFFAFAF9), ink: Color(0xFFFB923C)),
    light: (primary: Color(0xFFEA580C), primaryForeground: Color(0xFFFAFAF9), ink: Color(0xFFEA580C)),
    darkSwatch: Color(0xFFEA580C),
    lightSwatch: Color(0xFFEA580C),
  ),
  rose(
    dark: (primary: Color(0xFFE11D48), primaryForeground: Color(0xFFFFF1F2), ink: Color(0xFFFB7185)),
    light: (primary: Color(0xFFE11D48), primaryForeground: Color(0xFFFFF1F2), ink: Color(0xFFE11D48)),
    darkSwatch: Color(0xFFE11D48),
    lightSwatch: Color(0xFFE11D48),
  );

  const AppAccent({required this.dark, required this.light, required this.darkSwatch, required this.lightSwatch});

  final AccentColors dark;
  final AccentColors light;
  final Color darkSwatch;
  final Color lightSwatch;

  AccentColors colors(Brightness brightness) => brightness == Brightness.dark ? dark : light;

  Color swatch(Brightness brightness) => brightness == Brightness.dark ? darkSwatch : lightSwatch;

  /// The check mark on the selected swatch: dark on the light zinc swatch, white on the others.
  Color swatchCheck(Brightness brightness) => this == AppAccent.zinc && brightness == Brightness.dark ? const Color(0xFF18181B) : const Color(0xFFFFFFFF);

  static AppAccent fromName(String? name) => AppAccent.values.firstWhere((a) => a.name == name, orElse: () => AppAccent.zinc);
}

typedef AccentColors = ({Color primary, Color primaryForeground, Color ink});

/// Radii from the web app (`--radius: 0.625rem`) and the mockup.
abstract final class SchulyRadii {
  static const double sm = 6;
  static const double md = 8;
  static const double button = 9;
  static const double base = 10;
  static const double list = 12;
  static const double card = 14;
  static const double sheet = 20;
}

/// The design tokens Forui's [FColors] has no slot for: surfaces, the accent ink, status and calendar colours.
@immutable
class SchulyTokens extends ThemeExtension<SchulyTokens> {
  const SchulyTokens({
    required this.card,
    required this.input,
    required this.ink,
    required this.good,
    required this.goodBackground,
    required this.ok,
    required this.warn,
    required this.warnBackground,
    required this.bad,
    required this.badBackground,
    required this.calendarTest,
    required this.calendarEvent,
    required this.calendarHoliday,
    required this.calendarLesson,
    required this.idCardTop,
    required this.idCardBottom,
  });

  /// Raised surfaces: lists, cards and sheets.
  final Color card;

  /// Field borders, a step stronger than [FColors.border].
  final Color input;

  /// The accent as text, lines and dots.
  final Color ink;
  final Color good;
  final Color goodBackground;

  /// A passing grade that is neither good nor a warning.
  final Color ok;
  final Color warn;
  final Color warnBackground;
  final Color bad;
  final Color badBackground;
  final Color calendarTest;
  final Color calendarEvent;
  final Color calendarHoliday;
  final Color calendarLesson;
  final Color idCardTop;
  final Color idCardBottom;

  /// The accent, faint, behind the "Now" tag and the running lesson's halo.
  Color get soft => ink.withValues(alpha: 0.16);

  static SchulyTokens build(Brightness brightness, AppAccent accent) {
    final ink = accent.colors(brightness).ink;
    return brightness == Brightness.dark
        ? SchulyTokens(
            card: const Color(0xFF171717),
            input: const Color(0x26FFFFFF),
            ink: ink,
            good: const Color(0xFF63D18F),
            goodBackground: const Color(0xFF173523),
            ok: const Color(0xFFD1D1D1),
            warn: const Color(0xFFEBBD57),
            warnBackground: const Color(0xFF3C2E0F),
            bad: const Color(0xFFFD736D),
            badBackground: const Color(0xFF4E201E),
            calendarTest: const Color(0xFFFD736D),
            calendarEvent: const Color(0xFFBC98F9),
            calendarHoliday: const Color(0xFFEBBD57),
            calendarLesson: const Color(0xFF64C897),
            idCardTop: const Color(0xFF242424),
            idCardBottom: const Color(0xFF141414),
          )
        : SchulyTokens(
            card: const Color(0xFFFFFFFF),
            input: const Color(0xFFD4D4D4),
            ink: ink,
            good: const Color(0xFF00884B),
            goodBackground: const Color(0xFFD5F9E0),
            ok: const Color(0xFF484848),
            warn: const Color(0xFFB77610),
            warnBackground: const Color(0xFFFFF0C5),
            bad: const Color(0xFFDE2024),
            badBackground: const Color(0xFFFFE5E1),
            calendarTest: const Color(0xFFDE2024),
            calendarEvent: const Color(0xFF8254C4),
            calendarHoliday: const Color(0xFFB77610),
            calendarLesson: const Color(0xFF118659),
            idCardTop: const Color(0xFFF7F7F7),
            idCardBottom: const Color(0xFFEAEAEA),
          );
  }

  @override
  SchulyTokens copyWith({Color? ink}) => SchulyTokens(
        card: card,
        input: input,
        ink: ink ?? this.ink,
        good: good,
        goodBackground: goodBackground,
        ok: ok,
        warn: warn,
        warnBackground: warnBackground,
        bad: bad,
        badBackground: badBackground,
        calendarTest: calendarTest,
        calendarEvent: calendarEvent,
        calendarHoliday: calendarHoliday,
        calendarLesson: calendarLesson,
        idCardTop: idCardTop,
        idCardBottom: idCardBottom,
      );

  @override
  SchulyTokens lerp(SchulyTokens? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return SchulyTokens(
      card: l(card, other.card),
      input: l(input, other.input),
      ink: l(ink, other.ink),
      good: l(good, other.good),
      goodBackground: l(goodBackground, other.goodBackground),
      ok: l(ok, other.ok),
      warn: l(warn, other.warn),
      warnBackground: l(warnBackground, other.warnBackground),
      bad: l(bad, other.bad),
      badBackground: l(badBackground, other.badBackground),
      calendarTest: l(calendarTest, other.calendarTest),
      calendarEvent: l(calendarEvent, other.calendarEvent),
      calendarHoliday: l(calendarHoliday, other.calendarHoliday),
      calendarLesson: l(calendarLesson, other.calendarLesson),
      idCardTop: l(idCardTop, other.idCardTop),
      idCardBottom: l(idCardBottom, other.idCardBottom),
    );
  }
}

extension SchulyThemeContext on BuildContext {
  /// The Schuly tokens of the current theme. Falls back to the zinc tokens for a theme built without them (tests).
  SchulyTokens get tokens {
    final theme = this.theme;
    for (final e in theme.extensions) {
      if (e is SchulyTokens) return e;
    }
    return SchulyTokens.build(theme.colors.brightness, AppAccent.zinc).copyWith(ink: theme.colors.primary);
  }
}

const String kFontFamily = 'Geist';
const String kMonoFontFamily = 'GeistMono';

/// Numbers line up in columns everywhere (grades, times, dates).
const List<FontFeature> kTabularFigures = [FontFeature.tabularFigures()];

FColors _colors(Brightness brightness, AppAccent accent) {
  final a = accent.colors(brightness);
  return brightness == Brightness.dark
      ? FColors(
          brightness: Brightness.dark,
          systemOverlayStyle: FThemes.zinc.dark.colors.systemOverlayStyle,
          barrier: const Color(0x8C000000),
          background: const Color(0xFF0A0A0A),
          foreground: const Color(0xFFFAFAFA),
          primary: a.primary,
          primaryForeground: a.primaryForeground,
          secondary: const Color(0xFF262626),
          secondaryForeground: const Color(0xFFFAFAFA),
          muted: const Color(0xFF262626),
          mutedForeground: const Color(0xFFA1A1A1),
          destructive: const Color(0xFFFF6467),
          destructiveForeground: const Color(0xFF1C1C1C),
          error: const Color(0xFFFF6467),
          errorForeground: const Color(0xFF1C1C1C),
          border: const Color(0x1AFFFFFF),
        )
      : FColors(
          brightness: Brightness.light,
          systemOverlayStyle: FThemes.zinc.light.colors.systemOverlayStyle,
          barrier: const Color(0x4D000000),
          background: const Color(0xFFFAFAFA),
          foreground: const Color(0xFF0A0A0A),
          primary: a.primary,
          primaryForeground: a.primaryForeground,
          secondary: const Color(0xFFF0F0F0),
          secondaryForeground: const Color(0xFF171717),
          muted: const Color(0xFFF0F0F0),
          mutedForeground: const Color(0xFF737373),
          destructive: const Color(0xFFE7000B),
          destructiveForeground: const Color(0xFFFAFAFA),
          error: const Color(0xFFE7000B),
          errorForeground: const Color(0xFFFAFAFA),
          border: const Color(0xFFE5E5E5),
        );
}

FTypography _typography(FColors colors) {
  TextStyle s(double size, double height) => TextStyle(color: colors.foreground, fontFamily: kFontFamily, fontSize: size, height: height, fontFeatures: kTabularFigures);
  // base is the body text (14 px, as on the web); sm and xs carry secondary lines.
  return FTypography(
    defaultFontFamily: kFontFamily,
    xs: s(12, 1.3),
    sm: s(13, 1.4),
    base: s(14, 1.45),
    lg: s(15, 1.4),
    xl: s(18, 1.3),
    xl2: s(26, 1.15),
    xl3: s(30, 1.2),
    xl4: s(36, 1.2),
    xl5: s(48, 1),
    xl6: s(56, 1),
    xl7: s(72, 1),
    xl8: s(96, 1),
  );
}

/// The Forui theme for a brightness and accent, with the web app's tokens applied to every Forui widget.
FThemeData buildSchulyTheme(Brightness brightness, AppAccent accent) {
  final colors = _colors(brightness, accent);
  final typography = _typography(colors);
  final tokens = SchulyTokens.build(brightness, accent);
  final base = FStyle.inherit(colors: colors, typography: typography);
  final style = FStyle(
    formFieldStyle: base.formFieldStyle,
    focusedOutlineStyle: FFocusedOutlineStyle(color: tokens.ink, borderRadius: BorderRadius.circular(SchulyRadii.base)),
    iconStyle: IconThemeData(color: colors.foreground, size: 20),
    tappableStyle: base.tappableStyle,
    borderRadius: BorderRadius.circular(SchulyRadii.base),
    shadow: const [],
  );
  final theme = FThemeData(
    debugLabel: 'Schuly ${brightness.name} ${accent.name}',
    colors: colors,
    typography: typography,
    style: style,
    tileStyle: _tileStyle(colors, typography, style, tokens, outlined: true),
    tileGroupStyle: _tileGroupStyle(colors, typography, style, tokens),
    buttonStyles: _buttonStyles(colors, typography, style, tokens),
    tabsStyle: FTabsStyle(
      decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(SchulyRadii.base)),
      selectedLabelTextStyle: typography.sm.copyWith(fontWeight: FontWeight.w500, color: colors.foreground),
      unselectedLabelTextStyle: typography.sm.copyWith(fontWeight: FontWeight.w500, color: colors.mutedForeground),
      indicatorDecoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(SchulyRadii.md),
        boxShadow: const [BoxShadow(color: Color(0x4D000000), blurRadius: 2, offset: Offset(0, 1))],
      ),
      focusedOutlineStyle: style.focusedOutlineStyle,
      padding: const EdgeInsets.all(3),
      height: 34,
      spacing: 0,
    ),
    bottomNavigationBarStyle: FBottomNavigationBarStyle(
      decoration: BoxDecoration(color: colors.background, border: Border(top: BorderSide(color: colors.border))),
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
      itemStyle: FBottomNavigationBarItemStyle(
        iconStyle: FWidgetStateMap({
          WidgetState.selected: IconThemeData(color: tokens.ink, size: 22),
          WidgetState.any: IconThemeData(color: colors.mutedForeground, size: 22),
        }),
        textStyle: FWidgetStateMap({
          WidgetState.selected: typography.xs.copyWith(color: tokens.ink, fontSize: 11, fontWeight: FontWeight.w500),
          WidgetState.any: typography.xs.copyWith(color: colors.mutedForeground, fontSize: 11, fontWeight: FontWeight.w500),
        }),
        tappableStyle: style.tappableStyle,
        focusedOutlineStyle: style.focusedOutlineStyle,
        padding: const EdgeInsets.only(bottom: 6),
        spacing: 3,
      ),
    ),
    extensions: [tokens],
  );
  final offThumb = brightness == Brightness.dark ? const Color(0xFFFAFAFA) : const Color(0xFFFFFFFF);
  return _neutralFields(theme).copyWith(
    switchStyle: (s) => s.copyWith(
      focusColor: tokens.ink,
      trackColor: FWidgetStateMap({
        WidgetState.disabled & WidgetState.selected: colors.disable(colors.primary),
        WidgetState.disabled: brightness == Brightness.dark ? colors.muted : const Color(0xFFE5E5E5),
        WidgetState.selected: colors.primary,
        WidgetState.any: brightness == Brightness.dark ? colors.muted : const Color(0xFFD4D4D4),
      }),
      thumbColor: FWidgetStateMap({
        WidgetState.disabled: offThumb.withValues(alpha: 0.45),
        WidgetState.selected: colors.primaryForeground,
        WidgetState.any: offThumb,
      }),
    ),
  );
}

/// A row: 14 px sides, medium title, muted line below, muted details and chevrons on the right.
FItemContentStyle _rowContent(FColors colors, FTypography typography) => FItemContentStyle(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
      prefixIconStyle: FWidgetStateMap.all(IconThemeData(color: colors.foreground, size: 18)),
      titleTextStyle: FWidgetStateMap({
        WidgetState.disabled: typography.base.copyWith(fontWeight: FontWeight.w500, color: colors.disable(colors.foreground)),
        WidgetState.any: typography.base.copyWith(fontWeight: FontWeight.w500),
      }),
      subtitleTextStyle: FWidgetStateMap.all(typography.sm.copyWith(color: colors.mutedForeground)),
      detailsTextStyle: FWidgetStateMap.all(typography.sm.copyWith(color: colors.mutedForeground)),
      suffixIconStyle: FWidgetStateMap.all(IconThemeData(color: colors.mutedForeground, size: 16)),
      prefixIconSpacing: 12,
      titleSpacing: 1,
      middleSpacing: 12,
      suffixIconSpacing: 4,
    );

/// Tiles sit on the raised card surface; an outlined tile carries its own border and radius, a tile in a group
/// leaves both to the group.
FTileStyle _tileStyle(FColors colors, FTypography typography, FStyle style, SchulyTokens tokens, {required bool outlined}) {
  BoxDecoration deco(Color color) => outlined
      ? BoxDecoration(color: color, border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(SchulyRadii.list))
      : BoxDecoration(color: color);
  return FTileStyle(
    backgroundColor: FWidgetStateMap.all(outlined ? const Color(0x00000000) : tokens.card),
    decoration: FWidgetStateMap({
      WidgetState.disabled: deco(tokens.card),
      WidgetState.pressed: deco(colors.muted),
      WidgetState.any: deco(tokens.card),
    }),
    contentStyle: _rowContent(colors, typography),
    rawItemContentStyle: FRawItemContentStyle(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
      prefixIconStyle: FWidgetStateMap.all(IconThemeData(color: colors.foreground, size: 18)),
      childTextStyle: FWidgetStateMap.all(typography.base),
      prefixIconSpacing: 12,
    ),
    tappableStyle: style.tappableStyle.copyWith(motion: (_) => FTappableMotion.none, pressedEnterDuration: Duration.zero, pressedExitDuration: const Duration(milliseconds: 25)),
    focusedOutlineStyle: style.focusedOutlineStyle,
  );
}

/// A bordered list on the card surface with hairlines between rows, radius 12.
FTileGroupStyle _tileGroupStyle(FColors colors, FTypography typography, FStyle style, SchulyTokens tokens) {
  final base = FTileGroupStyle.inherit(colors: colors, typography: typography, style: style);
  return base.copyWith(
    decoration: BoxDecoration(color: tokens.card, border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(SchulyRadii.list)),
    tileStyle: (_) => _tileStyle(colors, typography, style, tokens, outlined: false),
    dividerColor: FWidgetStateMap.all(colors.border),
    labelTextStyle: FWidgetStateMap.all(typography.lg.copyWith(fontWeight: FontWeight.w600)),
  );
}

/// 36 px buttons with radius 9: the accent for primary, the card surface with a border for outline.
FButtonStyles _buttonStyles(FColors colors, FTypography typography, FStyle style, SchulyTokens tokens) {
  final base = FButtonStyles.inherit(
    colors: colors,
    typography: typography,
    style: FStyle(
      formFieldStyle: style.formFieldStyle,
      focusedOutlineStyle: style.focusedOutlineStyle,
      iconStyle: style.iconStyle,
      tappableStyle: style.tappableStyle,
      borderRadius: BorderRadius.circular(SchulyRadii.button),
      shadow: const [],
    ),
  );
  FButtonStyle sized(FButtonStyle s) => s.copyWith(
        contentStyle: (c) => c.copyWith(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          spacing: 6,
          iconStyle: c.iconStyle.map((i) => i.copyWith(size: 18)),
        ),
      );
  BoxDecoration outline(Color fill) => BoxDecoration(color: fill, border: Border.all(color: colors.border), borderRadius: BorderRadius.circular(SchulyRadii.button));
  return FButtonStyles(
    primary: sized(base.primary),
    secondary: sized(base.secondary),
    destructive: sized(base.destructive),
    outline: sized(base.outline.copyWith(
      decoration: FWidgetStateMap({
        WidgetState.disabled: outline(tokens.card),
        WidgetState.pressed: outline(colors.muted),
        WidgetState.any: outline(tokens.card),
      }),
    )),
    ghost: sized(base.ghost),
  );
}

/// Forui paints field text and the focused border in the primary colour, which turns every input and dropdown into
/// the accent once one is chosen. Fields stay neutral, on the page background with the stronger input border.
FThemeData _neutralFields(FThemeData theme) {
  final colors = theme.colors;
  final tokens = theme.extensions.whereType<SchulyTokens>().first;
  FTextFieldStyle neutral(FTextFieldStyle field) {
    final base = field.contentTextStyle.maybeResolve({}) ?? theme.typography.base;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
          borderSide: BorderSide(color: color, width: theme.style.borderWidth),
          borderRadius: BorderRadius.circular(SchulyRadii.list),
        );
    return field.copyWith(
      contentTextStyle: FWidgetStateMap({
        WidgetState.disabled: base.copyWith(color: colors.disable(colors.foreground), fontSize: 15),
        WidgetState.any: base.copyWith(color: colors.foreground, fontSize: 15),
      }),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      fillColor: colors.background,
      filled: true,
      border: FWidgetStateMap({
        WidgetState.error: border(colors.error),
        WidgetState.disabled: border(colors.disable(tokens.input)),
        WidgetState.focused: border(colors.mutedForeground),
        WidgetState.any: border(tokens.input),
      }),
    );
  }

  final itemText = FWidgetStateMap({
    WidgetState.disabled: theme.typography.base.copyWith(color: colors.disable(colors.foreground)),
    WidgetState.any: theme.typography.base.copyWith(color: colors.foreground),
  });

  return theme.copyWith(
    textFieldStyle: neutral,
    selectStyle: (s) => s.copyWith(
      selectFieldStyle: neutral,
      iconStyle: s.iconStyle.copyWith(color: colors.mutedForeground),
      contentStyle: (c) => c.copyWith(
        sectionStyle: (section) => section.copyWith(
          itemStyle: (item) => item.copyWith(
            contentStyle: (content) => content.copyWith(titleTextStyle: itemText),
            rawItemContentStyle: (raw) => raw.copyWith(childTextStyle: itemText),
          ),
        ),
      ),
    ),
    dateFieldStyle: (s) => s.copyWith(textFieldStyle: neutral),
    timeFieldStyle: (s) => s.copyWith(textFieldStyle: neutral),
  );
}
