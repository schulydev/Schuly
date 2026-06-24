import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

/// First-run onboarding: three intro pages explaining what Schuly shows,
/// followed by the Account-vs-Private mode choice. Forui has no carousel
/// widget, so the swipe is a plain [PageView]; everything else is Forui.
///
/// The two mode buttons on the last page are the only exits - both should mark
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
                    body: 'Your grades, timetable, agenda, and absences - '
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

/// The decision page: account vs private. Each card is itself the action
/// (tappable), so there are no separate buttons. Content is centered.
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

    // Centre the content vertically, but stay scrollable on short screens.
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How do you want to use Schuly?',
                textAlign: TextAlign.center,
                style: typography.xl2.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 28),
              _ModeCard(
                icon: FIcons.cloud,
                title: 'Schuly account',
                tag: 'Recommended',
                highlighted: true,
                body: 'Notifications, web access, and sync across devices. '
                    'Secured with a passkey.',
                onTap: busy ? null : onAccount,
              ),
              const SizedBox(height: 14),
              _ModeCard(
                icon: FIcons.shieldCheck,
                title: 'Private mode',
                body: 'No account - everything stays on your device. '
                    'No notifications, web, or sync.',
                onTap: busy ? null : onPrivate,
              ),
              const SizedBox(height: 20),
              Text(
                'You can switch modes later by signing out.',
                textAlign: TextAlign.center,
                style: typography.xs.copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tappable mode card with centered content; the recommended one gets a
/// primary-coloured border.
class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String? tag;
  final bool highlighted;
  final VoidCallback? onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.body,
    this.tag,
    this.highlighted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final radius = BorderRadius.circular(14);

    return Material(
      color: colors.secondary,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: highlighted ? colors.primary : colors.border,
              width: highlighted ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 30, color: colors.primary),
              const SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    title,
                    style: typography.base.copyWith(fontWeight: FontWeight.w700),
                  ),
                  if (tag != null)
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
              ),
              const SizedBox(height: 6),
              Text(
                body,
                textAlign: TextAlign.center,
                style: typography.sm.copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
