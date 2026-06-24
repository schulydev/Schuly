import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// First-run onboarding: three intro pages explaining what Schuly shows,
/// followed by the Account-vs-Private mode choice. Forui has no carousel
/// widget, so the swipe is a plain [PageView]; everything else is Forui.
///
/// The two mode buttons on the last page are the only exits — both should mark
/// onboarding as seen and start the matching gate flow (sign-in / connect).
class OnboardingScreen extends StatefulWidget {
  final Future<void> Function() onChooseAccount;
  final Future<void> Function() onChoosePrivate;

  const OnboardingScreen({
    super.key,
    required this.onChooseAccount,
    required this.onChoosePrivate,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pageCount = 4;
  static const _lastPage = _pageCount - 1;

  final _controller = PageController();
  int _page = 0;
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() => _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  void _skipToChoice() => _controller.animateToPage(
        _lastPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );

  Future<void> _choose(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return FScaffold(
      child: SafeArea(
        child: Column(
          children: [
            // Skip jumps straight to the mode choice (it never bypasses it).
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: AnimatedOpacity(
                  opacity: _page < _lastPage ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: FButton(
                    style: FButtonStyle.ghost(),
                    onPress: _page < _lastPage ? _skipToChoice : null,
                    child: const Text('Skip'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  const _IntroPage(
                    icon: FIcons.graduationCap,
                    title: 'Welcome to Schuly',
                    body: 'Your grades, timetable, agenda, and absences — '
                        'your whole school portal in one app.',
                  ),
                  const _IntroPage(
                    icon: FIcons.house,
                    title: 'Everything at a glance',
                    body: "The home screen shows today's lessons, upcoming "
                        'tests, the next holiday, your latest grades, and '
                        'recent absences.',
                  ),
                  const _IntroPage(
                    icon: FIcons.trendingUp,
                    title: 'Track your progress',
                    body: 'See your grades by semester or whole year with class '
                        'averages, and browse your timetable, agenda, and '
                        'absences.',
                  ),
                  _ModeChoicePage(
                    busy: _busy,
                    onAccount: () => _choose(widget.onChooseAccount),
                    onPrivate: () => _choose(widget.onChoosePrivate),
                  ),
                ],
              ),
            ),
            // Page indicator dots.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pageCount; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _page ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _page ? colors.primary : colors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
            // The last page carries its own CTAs; earlier pages get "Next".
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: _page < _lastPage
                  ? SizedBox(
                      width: double.infinity,
                      child: FButton(onPress: _next, child: const Text('Next')),
                    )
                  : const SizedBox(height: 8),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single intro slide: a large icon, a title, and a short blurb.
class _IntroPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _IntroPage({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 60, color: colors.primary),
          ),
          const SizedBox(height: 36),
          Text(
            title,
            textAlign: TextAlign.center,
            style: typography.xl3.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          Text(
            body,
            textAlign: TextAlign.center,
            style: typography.base.copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// The decision page: account vs private, with the trade-offs and the two CTAs.
class _ModeChoicePage extends StatelessWidget {
  final bool busy;
  final VoidCallback onAccount;
  final VoidCallback onPrivate;

  const _ModeChoicePage({
    required this.busy,
    required this.onAccount,
    required this.onPrivate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'How do you want to use Schuly?',
            textAlign: TextAlign.center,
            style: typography.xl2.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          _ModeCard(
            icon: FIcons.cloud,
            title: 'Schuly account',
            tag: 'Recommended',
            body: 'Notifications, web access, and sync across devices. '
                'Secured with a passkey.',
          ),
          const SizedBox(height: 12),
          _ModeCard(
            icon: FIcons.shieldCheck,
            title: 'Private mode',
            body: 'No account — everything stays on your device. '
                'No notifications, web, or sync.',
          ),
          const SizedBox(height: 24),
          FButton(
            onPress: busy ? null : onAccount,
            child: Text(busy ? 'Please wait…' : 'Continue with a Schuly account'),
          ),
          const SizedBox(height: 10),
          FButton(
            style: FButtonStyle.outline(),
            onPress: busy ? null : onPrivate,
            child: const Text('Use without an account'),
          ),
          const SizedBox(height: 8),
          Text(
            'You can switch modes later by signing out.',
            textAlign: TextAlign.center,
            style: typography.xs.copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String? tag;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.body,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: colors.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: typography.base.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    if (tag != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag!,
                          style: typography.xs.copyWith(
                            color: colors.primaryForeground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: typography.sm.copyWith(color: colors.mutedForeground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
