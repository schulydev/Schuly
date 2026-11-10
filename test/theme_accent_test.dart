import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/theme_service.dart';
import 'package:schuly/ui/core/theme/schuly_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

SchulyTokens _tokens(Brightness b, AppAccent a) => buildSchulyTheme(b, a).extensions.whereType<SchulyTokens>().single;

void main() {
  test('there are six accents, zinc first', () {
    expect(AppAccent.values.map((a) => a.name), ['zinc', 'blue', 'violet', 'green', 'orange', 'rose']);
    expect(AppAccent.fromName(null), AppAccent.zinc);
    expect(AppAccent.fromName('nope'), AppAccent.zinc);
    expect(AppAccent.fromName('rose'), AppAccent.rose);
  });

  test('the accent drives primary and ink, as in the mockup', () {
    final expected = {
      AppAccent.zinc: (0xFFE5E5E5, 0xFF171717, 0xFFFAFAFA),
      AppAccent.blue: (0xFF3B82F6, 0xFF0F172A, 0xFF60A5FA),
      AppAccent.violet: (0xFF7C3AED, 0xFFF8FAFC, 0xFFA78BFA),
      AppAccent.green: (0xFF22C55E, 0xFF052E16, 0xFF4ADE80),
      AppAccent.orange: (0xFFEA580C, 0xFFFAFAF9, 0xFFFB923C),
      AppAccent.rose: (0xFFE11D48, 0xFFFFF1F2, 0xFFFB7185),
    };
    for (final MapEntry(key: accent, value: (primary, fg, ink)) in expected.entries) {
      final theme = buildSchulyTheme(Brightness.dark, accent);
      expect(theme.colors.primary, Color(primary), reason: accent.name);
      expect(theme.colors.primaryForeground, Color(fg), reason: accent.name);
      expect(_tokens(Brightness.dark, accent).ink, Color(ink), reason: accent.name);
    }
  });

  test('status and calendar colours never follow the accent', () {
    for (final b in Brightness.values) {
      final base = _tokens(b, AppAccent.zinc);
      for (final a in AppAccent.values) {
        final t = _tokens(b, a);
        expect([t.good, t.warn, t.bad, t.goodBackground, t.warnBackground, t.badBackground], [base.good, base.warn, base.bad, base.goodBackground, base.warnBackground, base.badBackground], reason: '${b.name} ${a.name}');
        expect([t.calendarTest, t.calendarEvent, t.calendarHoliday, t.calendarLesson], [base.calendarTest, base.calendarEvent, base.calendarHoliday, base.calendarLesson], reason: '${b.name} ${a.name}');
        expect(buildSchulyTheme(b, a).colors.background, buildSchulyTheme(b, AppAccent.zinc).colors.background);
      }
    }
  });

  test('the dark theme uses the web tokens', () {
    final theme = buildSchulyTheme(Brightness.dark, AppAccent.zinc);
    expect(theme.colors.background, const Color(0xFF0A0A0A));
    expect(theme.colors.border, const Color(0x1AFFFFFF));
    expect(_tokens(Brightness.dark, AppAccent.zinc).card, const Color(0xFF171717));
    expect(theme.typography.defaultFontFamily, kFontFamily);
    expect(theme.typography.base.fontFeatures, kTabularFigures);
  });

  test('the accent is saved per device', () async {
    SharedPreferences.setMockInitialValues({});
    await ThemeService.instance.load();
    expect(ThemeService.instance.accent, AppAccent.zinc);
    await ThemeService.instance.setAccent(AppAccent.violet);
    expect((await SharedPreferences.getInstance()).getString('settings.theme_accent'), 'violet');
    await ThemeService.instance.setAccent(AppAccent.zinc);
    SharedPreferences.setMockInitialValues({'settings.theme_accent': 'green', 'settings.theme_mode': 'dark'});
    await ThemeService.instance.load();
    expect(ThemeService.instance.accent, AppAccent.green);
    expect(ThemeService.instance.mode, ThemeMode.dark);
  });
}
