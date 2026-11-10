import '../core/ui/auth_image.dart';
import 'dart:math' as math;

import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart' show EagerGestureRecognizer, OneSequenceGestureRecognizer;
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/app_mode_service.dart';
import '../../services/student_id_card_service.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';

/// What the Lernendenausweis shows. Filled from the school profile; programme, validity and the student number come
/// once the school connection provides them (after mydrift's `StudentIdCard.fromProfile`).
class StudentId {
  const StudentId({
    required this.firstName,
    required this.lastName,
    required this.schoolName,
    this.email,
    this.since,
    this.photoUrl,
  });

  factory StudentId.fromProfile(
    SchoolUserDto me, {
    String? schoolName,
    String? photoUrl,
  }) => StudentId(
    firstName: me.firstName,
    lastName: me.lastName,
    schoolName: schoolName ?? me.schoolName ?? '',
    email: me.email.isEmpty ? null : me.email,
    since: me.entryDate == null
        ? null
        : DateTime(me.entryDate!.year, me.entryDate!.month, me.entryDate!.day),
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

/// Opens the Lernendenausweis. [fallback] is the self-built card, shown only when the school does not offer the official one.
Future<void> openStudentId(BuildContext context, StudentId? fallback) =>
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => StudentIdPage(fallback: fallback),
      ),
    );

/// Only the card itself may load in the WebView: it comes as an HTML string (about:blank) with `data:` images.
bool studentIdCardAllowsNavigation(String url) {
  final scheme = Uri.tryParse(url)?.scheme.toLowerCase();
  return scheme == 'data' || scheme == 'about';
}

/// Full brightness and no screen lock while the card is shown, so a QR reader at the door can scan it; both are put back on exit.
class StudentIdScreen {
  const StudentIdScreen();

  Future<bool> enter() async {
    var wasAwake = false;
    try {
      wasAwake = await WakelockPlus.enabled;
      await WakelockPlus.enable();
    } catch (_) {}
    try {
      await ScreenBrightness.instance.setApplicationScreenBrightness(1.0);
    } catch (_) {}
    return wasAwake;
  }

  Future<void> leave({required bool wasAwake}) async {
    try {
      await ScreenBrightness.instance.resetApplicationScreenBrightness();
    } catch (_) {}
    try {
      if (!wasAwake) await WakelockPlus.disable();
    } catch (_) {}
  }
}

/// The official Lernendenausweis as Schulnetz renders it, unchanged, in a WebView without JavaScript. The saved copy shows
/// at once and is refreshed in the background; pulling down asks Schulnetz again. Only a school that does not offer the
/// card gets the self-built [fallback], marked as not the official one.
class StudentIdPage extends StatefulWidget {
  const StudentIdPage({
    super.key,
    this.fallback,
    this.service,
    this.target,
    this.screen = const StudentIdScreen(),
    this.cardView,
  });

  final StudentId? fallback;
  final StudentIdCardService? service;

  /// Where the card comes from; resolved from the app mode and the active school when not given.
  final StudentIdCardTarget? target;
  final StudentIdScreen screen;

  /// Draws the card HTML; the WebView by default (widget tests have no platform WebView).
  final Widget Function(String html)? cardView;

  @override
  State<StudentIdPage> createState() => _StudentIdPageState();
}

class _StudentIdPageState extends State<StudentIdPage> {
  StudentIdCardService get _service =>
      widget.service ?? StudentIdCardService.instance;

  StudentIdCardTarget? _target;
  StudentIdCard? _card;
  StudentIdCardFailure? _failure;
  bool _loading = true;
  late final Future<bool> _entered;

  @override
  void initState() {
    super.initState();
    _entered = widget.screen.enter();
    _start();
  }

  @override
  void dispose() {
    _entered.then((wasAwake) => widget.screen.leave(wasAwake: wasAwake));
    super.dispose();
  }

  Future<void> _start() async {
    final target =
        widget.target ??
        await _service.resolveTarget(
          isPrivate: AppModeService.instance.isPrivate,
          active: ActiveAccountService.instance.active,
        );
    if (!mounted) return;
    if (target == null) {
      setState(() {
        _loading = false;
        _failure = StudentIdCardFailure.notOffered;
      });
      return;
    }
    _target = target;
    final cached = await _service.cached(target);
    if (!mounted) return;
    if (cached != null) setState(() => _card = cached);
    await _refresh();
  }

  Future<void> _refresh() async {
    final target = _target;
    if (target == null) return;
    setState(() => _loading = true);
    try {
      final card = await _service.fetch(target);
      if (!mounted) return;
      setState(() {
        _card = card;
        _failure = null;
      });
    } on StudentIdCardException catch (e) {
      if (!mounted) return;
      setState(() {
        _failure = e.kind;
        if (e.kind == StudentIdCardFailure.notOffered) _card = null;
      });
    } catch (_) {
      if (mounted) setState(() => _failure = StudentIdCardFailure.unavailable);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final dates = Dates(context);
    final card = _card;
    // The card gets all the height the page has left below the title and above the "As of" row, so the page itself
    // does not scroll; a card taller than that scrolls inside the WebView.
    final media = MediaQuery.of(context);
    double line(TextStyle style) => media.textScaler.scale(style.fontSize ?? 14) * (style.height ?? 1.2);
    final chrome = 48 + 6 + 16 + line(typography.xl2) + 10 + 12 + line(typography.sm) + 24;
    final height = math.max(320.0, media.size.height - media.viewPadding.top - media.viewPadding.bottom - chrome);

    final List<Widget> body;
    if (card != null) {
      body = [
        Container(
          key: const ValueKey('student-id-official'),
          height: height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(SchulyRadii.card),
          ),
          child: (widget.cardView ?? (html) => _OfficialCard(html: html))(
            card.html,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  t.studentIdAsOf(
                    '${dates.full(card.fetchedAt)} ${dates.hm(card.fetchedAt)}',
                  ),
                  style: typography.sm.copyWith(color: colors.mutedForeground),
                ),
              ),
              if (_loading)
                SizedBox.square(
                  dimension: 14,
                  child: FCircularProgress(
                    style: (s) => s.copyWith(
                      iconStyle: s.iconStyle.copyWith(size: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_failure == StudentIdCardFailure.signInExpired)
          Callout(
            title: t.studentIdSignInExpired,
            text: t.studentIdSavedCopy,
            bad: true,
          ),
        if (_failure == StudentIdCardFailure.unavailable)
          Callout(title: t.studentIdUnavailable, text: t.studentIdSavedCopy),
      ];
    } else if (_failure == StudentIdCardFailure.notOffered) {
      final fallback = widget.fallback;
      body = [
        Callout(
          title: t.studentIdNotOfficialTitle,
          text: t.studentIdNotOfficialBody,
        ),
        const SizedBox(height: 14),
        if (fallback != null)
          _SelfBuiltCard(card: fallback)
        else
          EmptyNote(t.studentIdNotOfficialTitle),
      ];
    } else if (_loading) {
      body = [
        SizedBox(
          height: height,
          child: const Center(child: FCircularProgress()),
        ),
      ];
    } else {
      body = [
        Callout(
          title: _failure == StudentIdCardFailure.signInExpired
              ? t.studentIdSignInExpired
              : t.studentIdUnavailable,
          text: t.studentIdPullToRetry,
          bad: true,
        ),
      ];
    }

    return SubPage(
      backLabel: t.tabAccount,
      title: t.studentIdTitle,
      onRefresh: _refresh,
      children: body,
    );
  }
}

/// The Schulnetz HTML, untouched: JavaScript off, white background, and no way to navigate anywhere.
class _OfficialCard extends StatefulWidget {
  const _OfficialCard({required this.html});

  final String html;

  @override
  State<_OfficialCard> createState() => _OfficialCardState();
}

class _OfficialCardState extends State<_OfficialCard> {
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..setBackgroundColor(const Color(0xFFFFFFFF))
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (request) =>
            studentIdCardAllowsNavigation(request.url)
            ? NavigationDecision.navigate
            : NavigationDecision.prevent,
      ),
    )
    ..loadHtmlString(widget.html);

  @override
  void didUpdateWidget(covariant _OfficialCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.html != widget.html) _controller.loadHtmlString(widget.html);
  }

  @override
  Widget build(BuildContext context) => WebViewWidget(
    controller: _controller,
    // Drags on the card scroll the card, not the page, so a card taller than its box can be scrolled to its end.
    gestureRecognizers: {
      Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
    },
  );
}

/// The card Schuly draws itself from the school profile; tap or "Turn over" flips it.
class _SelfBuiltCard extends StatefulWidget {
  const _SelfBuiltCard({required this.card});

  final StudentId card;

  @override
  State<_SelfBuiltCard> createState() => _SelfBuiltCardState();
}

class _SelfBuiltCardState extends State<_SelfBuiltCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flip = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  void _turn() =>
      _flip.status == AnimationStatus.completed ||
          _flip.status == AnimationStatus.forward
      ? _flip.reverse()
      : _flip.forward();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      key: const ValueKey('student-id-self-built'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
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
                    child: showBack
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: _Back(card: widget.card),
                          )
                        : _Front(card: widget.card),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        FButton(
          style: blockButton(FButtonStyle.outline),
          prefix: const Icon(FIcons.rotateCcw),
          onPress: _turn,
          child: Text(t.studentIdTurn),
        ),
      ],
    );
  }
}

class _Face extends StatelessWidget {
  const _Face({
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 14),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tokens.input),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tokens.idCardTop, tokens.idCardBottom],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -90,
            top: -110,
            child: Container(
              width: 300,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    tokens.ink.withValues(alpha: 0.16),
                    tokens.ink.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(padding: padding, child: child),
          ),
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
      Text(
        label.toUpperCase(),
        style: typography.xs.copyWith(
          fontSize: 9.5,
          letterSpacing: 0.6,
          color: context.theme.colors.mutedForeground,
          height: 1.3,
        ),
      ),
      Text(
        value?.isNotEmpty == true ? value! : '-',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: typography.sm.copyWith(
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
      ),
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
              Expanded(
                child: Text(
                  t.studentIdTitle.toUpperCase(),
                  style: typography.xs.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.9,
                    color: colors.mutedForeground,
                  ),
                ),
              ),
              Text(
                '$startYear/${(startYear + 1) % 100}',
                style: typography.xs.copyWith(
                  fontSize: 11,
                  color: colors.mutedForeground,
                ),
              ),
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
                        ? Image(
                            image: AuthImage(card.photoUrl!),
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                ColoredBox(color: colors.muted),
                          )
                        : ColoredBox(
                            color: colors.muted,
                            child: Center(
                              child: Text(
                                card.fullName.isEmpty
                                    ? '?'
                                    : card.fullName.characters.first,
                                style: typography.xl3.copyWith(
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _field(
                              context,
                              t.studentIdLastName,
                              card.lastName,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _field(
                              context,
                              t.studentIdFirstName,
                              card.firstName,
                            ),
                          ),
                        ],
                      ),
                      _field(context, t.studentIdSchool, card.schoolName),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (card.since != null)
            Text(
              t.studentIdSince(Dates(context).full(card.since!)),
              style: typography.xs.copyWith(
                fontSize: 11,
                color: colors.mutedForeground,
              ),
            ),
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
                  Text(
                    t.studentIdBackNote,
                    style: context.theme.typography.xs.copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
