import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../l10n/app_localizations.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';

/// What the Lernendenausweis shows. Filled from the school profile; programme, validity and the student number come
/// once the school connection provides them (after mydrift's `StudentIdCard.fromProfile`).
class StudentId {
  const StudentId({required this.firstName, required this.lastName, required this.schoolName, this.email, this.since, this.photoUrl});

  factory StudentId.fromProfile(SchoolUserDto me, {String? schoolName, String? photoUrl}) => StudentId(
        firstName: me.firstName,
        lastName: me.lastName,
        schoolName: schoolName ?? me.schoolName ?? '',
        email: me.email.isEmpty ? null : me.email,
        since: me.entryDate == null ? null : DateTime(me.entryDate!.year, me.entryDate!.month, me.entryDate!.day),
        photoUrl: photoUrl,
      );

  final String firstName;
  final String lastName;
  final String schoolName;
  final String? email;
  final DateTime? since;
  final String? photoUrl;

  String get fullName => '$firstName $lastName'.trim();
}

Future<void> showStudentId(BuildContext context, StudentId card) => showSchulySheet<void>(context, builder: (_) => _StudentIdSheet(card: card));

class _StudentIdSheet extends StatefulWidget {
  const _StudentIdSheet({required this.card});

  final StudentId card;

  @override
  State<_StudentIdSheet> createState() => _StudentIdSheetState();
}

class _StudentIdSheetState extends State<_StudentIdSheet> with SingleTickerProviderStateMixin {
  late final AnimationController _flip = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  void _turn() => _flip.status == AnimationStatus.completed || _flip.status == AnimationStatus.forward ? _flip.reverse() : _flip.forward();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SchulySheet(
      title: t.studentIdTitle,
      subtitle: t.studentIdHint,
      action: t.done,
      body: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 14),
        child: Semantics(
          button: true,
          label: t.studentIdTurn,
          child: GestureDetector(
            onTap: _turn,
            child: AspectRatio(
              aspectRatio: 1.586,
              child: AnimatedBuilder(
                animation: _flip,
                builder: (context, _) {
                  final v = Curves.easeOutCubic.transform(_flip.value);
                  final angle = v * math.pi;
                  final showBack = angle > math.pi / 2;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0008)
                      ..rotateY(angle),
                    child: showBack ? Transform(alignment: Alignment.center, transform: Matrix4.rotationY(math.pi), child: _Back(card: widget.card)) : _Front(card: widget.card),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      footer: FButton(style: blockButton(FButtonStyle.outline), prefix: const Icon(FIcons.rotateCcw), onPress: _turn, child: Text(t.studentIdTurn)),
    );
  }
}

class _Face extends StatelessWidget {
  const _Face({required this.child, this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 14)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tokens.input),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [tokens.idCardTop, tokens.idCardBottom]),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -60,
            top: -60,
            child: Container(width: 200, height: 160, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [tokens.ink.withValues(alpha: 0.16), tokens.ink.withValues(alpha: 0)]))),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

Widget _field(BuildContext context, String label, String? value) {
  final typography = context.theme.typography;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label.toUpperCase(), style: typography.xs.copyWith(fontSize: 9.5, letterSpacing: 0.6, color: context.theme.colors.mutedForeground, height: 1.3)),
      Text(value?.isNotEmpty == true ? value! : '-', maxLines: 2, overflow: TextOverflow.ellipsis, style: typography.sm.copyWith(fontWeight: FontWeight.w600, height: 1.25)),
    ],
  );
}

class _Front extends StatelessWidget {
  const _Front({required this.card});

  final StudentId card;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final now = DateTime.now();
    final startYear = now.month >= 8 ? now.year : now.year - 1;
    return _Face(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(t.studentIdTitle.toUpperCase(), style: typography.xs.copyWith(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.9, color: colors.mutedForeground))),
              Text('$startYear/${(startYear + 1) % 100}', style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(SchulyRadii.md),
                  child: SizedBox(
                    width: 74,
                    height: 98,
                    child: card.photoUrl?.isNotEmpty == true
                        ? Image.network(card.photoUrl!, fit: BoxFit.cover, errorBuilder: (_, _, _) => ColoredBox(color: colors.muted))
                        : ColoredBox(color: colors.muted, child: Center(child: Text(card.fullName.isEmpty ? '?' : card.fullName.characters.first, style: typography.xl3.copyWith(color: colors.mutedForeground)))),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Row(children: [Expanded(child: _field(context, t.studentIdLastName, card.lastName)), const SizedBox(width: 10), Expanded(child: _field(context, t.studentIdFirstName, card.firstName))]),
                      _field(context, t.studentIdSchool, card.schoolName),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (card.since != null)
            Text(t.studentIdSince(Dates(context).full(card.since!)), style: typography.xs.copyWith(fontSize: 11, color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

class _Back extends StatelessWidget {
  const _Back({required this.card});

  final StudentId card;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    return _Face(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 14),
          Container(height: 30, color: const Color(0xFF030303)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  _field(context, t.studentIdEmail, card.email),
                  Text(t.studentIdBackNote, style: context.theme.typography.xs.copyWith(color: colors.mutedForeground)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
