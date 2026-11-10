import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/theme_service.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';

const _hues = [Color(0xFFFF0000), Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF), Color(0xFF0000FF), Color(0xFFFF00FF), Color(0xFFFF0000)];

/// The seventh swatch: a rainbow ring that opens the colour wheel, with the picked colour inside once it is the accent.
class RainbowSwatch extends StatelessWidget {
  const RainbowSwatch({super.key, required this.selected, required this.label, required this.onPress});

  final bool selected;
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    final picked = AppAccent.customColor;
    return FTappable(
      onPress: onPress,
      selected: selected,
      semanticsLabel: label,
      builder: (context, states, _) => SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Container(
            width: selected ? 34 : 26,
            height: selected ? 34 : 26,
            padding: EdgeInsets.all(selected ? 4 : 0),
            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: SweepGradient(colors: _hues)),
            child: selected
                ? Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: picked, border: Border.all(color: context.tokens.card, width: 2)),
                    child: Icon(FIcons.check, size: 12, color: readableOn(picked)),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

/// Opens the colour wheel; the colour taken becomes the accent.
Future<void> showAccentWheel(BuildContext context) => showSchulySheet<void>(context, builder: (_) => const _AccentWheelSheet());

class _AccentWheelSheet extends StatefulWidget {
  const _AccentWheelSheet();

  @override
  State<_AccentWheelSheet> createState() => _AccentWheelSheetState();
}

class _AccentWheelSheetState extends State<_AccentWheelSheet> {
  late HSVColor _hsv = HSVColor.fromColor(ThemeService.instance.customColor);

  static const double _size = 240;

  void _pickOnWheel(Offset p) {
    const r = _size / 2;
    final d = p - const Offset(r, r);
    final hue = (math.atan2(d.dy, d.dx) * 180 / math.pi + 360) % 360;
    final sat = (d.distance / r).clamp(0.0, 1.0);
    setState(() => _hsv = _hsv.withHue(hue).withSaturation(sat));
  }

  void _pickValue(double x, double width) => setState(() => _hsv = _hsv.withValue((x / width).clamp(0.15, 1.0)));

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final color = _hsv.toColor();
    final angle = _hsv.hue * math.pi / 180;
    final knob = Offset(_size / 2 + math.cos(angle) * _hsv.saturation * _size / 2, _size / 2 + math.sin(angle) * _hsv.saturation * _size / 2);
    final hex = '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
    final accent = customAccentColors(color, colors.brightness);

    return SchulySheet(
      title: t.accentCustom,
      action: t.cancel,
      footer: FButton(
        style: blockButton(FButtonStyle.primary),
        onPress: () {
          ThemeService.instance.setCustomColor(color);
          Navigator.of(context).pop();
        },
        child: Text(t.accentUse),
      ),
      body: Column(
        spacing: 18,
        children: [
          GestureDetector(
            onPanDown: (d) => _pickOnWheel(d.localPosition),
            onPanUpdate: (d) => _pickOnWheel(d.localPosition),
            child: SizedBox(
              width: _size,
              height: _size,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Hue round the circle, white towards the middle, darkened by the value below.
                  Container(decoration: const BoxDecoration(shape: BoxShape.circle, gradient: SweepGradient(colors: _hues))),
                  Container(decoration: const BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)]))),
                  Container(decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF000000).withValues(alpha: 1 - _hsv.value))),
                  Positioned(
                    left: knob.dx - 12,
                    top: knob.dy - 12,
                    child: Container(width: 24, height: 24, decoration: BoxDecoration(shape: BoxShape.circle, color: color, border: Border.all(color: const Color(0xFFFFFFFF), width: 3), boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 4)])),
                  ),
                ],
              ),
            ),
          ),
          LayoutBuilder(builder: (context, c) {
            final w = c.maxWidth;
            return GestureDetector(
              onPanDown: (d) => _pickValue(d.localPosition.dx, w),
              onPanUpdate: (d) => _pickValue(d.localPosition.dx, w),
              child: SizedBox(
                height: 28,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(height: 12, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), gradient: LinearGradient(colors: [const Color(0xFF000000), _hsv.withValue(1).toColor()]))),
                    Positioned(left: (_hsv.value * w - 11).clamp(0, w - 22), child: Container(width: 22, height: 22, decoration: BoxDecoration(shape: BoxShape.circle, color: color, border: Border.all(color: const Color(0xFFFFFFFF), width: 3), boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 4)]))),
                  ],
                ),
              ),
            );
          }),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(color: accent.primary, borderRadius: BorderRadius.circular(SchulyRadii.button)),
                child: Text(t.accentPreview, style: typography.sm.copyWith(color: accent.primaryForeground, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(width: 14),
              Text(t.accentPreview, style: typography.sm.copyWith(color: accent.ink, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text(hex, style: typography.sm.copyWith(color: colors.mutedForeground, fontFeatures: kTabularFigures)),
            ],
          ),
        ],
      ),
    );
  }
}
