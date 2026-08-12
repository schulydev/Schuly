import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

Color gradeColor(BuildContext context, num grade) {
  final colors = context.theme.colors;
  if (grade >= 5) return const Color(0xFF22C55E); // green
  if (grade >= 4) return const Color(0xFFF59E0B); // amber
  return colors.destructive;
}

bool isGraded(num? score) => score != null && score > 0;

String formatGrade(num grade) {
  final s = grade.toStringAsFixed(2);
  return s.endsWith('00')
      ? grade.toStringAsFixed(0)
      : (s.endsWith('0') ? grade.toStringAsFixed(1) : s);
}

class GradePill extends StatelessWidget {
  final num? score;
  const GradePill(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    if (!isGraded(score)) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.muted,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('-', style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w700)),
      );
    }
    final c = gradeColor(context, score!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8)),
      child: Text(formatGrade(score!), style: TextStyle(color: c, fontWeight: FontWeight.w700)),
    );
  }
}
