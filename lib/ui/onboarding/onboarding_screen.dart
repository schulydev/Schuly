import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../config/backend_config.dart';

/// First-run onboarding: three intro pages explaining what Schuly shows, then a
/// server step (hosted vs self-hosted), then the Account-vs-Private mode choice.
/// Forui has no carousel widget, so the swipe is a plain [PageView]; everything
/// else is Forui.
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
  static const _pageCount = 5;
  // Pages 0-2 are intro slides (with a Next button); pages 3 (server) and 4
  // (mode) carry their own Continue button.
  static const _introPages = 3;

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
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  const _IntroPage(
                    asset: 'assets/schuly_icon.png',
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
                  _ServerPage(busy: _busy, onContinue: _next),
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
            // Intro pages get a "Next"; the server and mode pages carry their
            // own Continue button.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: _page < _introPages
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
  final IconData? icon;
  final String? asset;
  final String title;
  final String body;

  const _IntroPage({
    this.icon,
    this.asset,
    required this.title,
    required this.body,
  }) : assert(icon != null || asset != null, 'provide an icon or an asset');

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    // Brand-mark pages (asset) get a solid primary disc with the white logo,
    // mirroring the app icon; plain feature pages get a faint disc + tinted icon.
    final Widget badge = asset != null
        ? Container(
            width: 188,
            height: 188,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(34),
              child: Image.asset(
                asset!,
                color: colors.primaryForeground,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          )
        : Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 60, color: colors.primary),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          badge,
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

enum _Server { hosted, custom }

/// The server step: the hosted Schuly Cloud (default) or a self-hosted backend
/// URL. Persists the choice to [BackendConfig] before continuing, so both
/// account and private mode talk to the chosen backend.
class _ServerPage extends StatefulWidget {
  final bool busy;
  final VoidCallback onContinue;

  const _ServerPage({required this.busy, required this.onContinue});

  @override
  State<_ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<_ServerPage> {
  _Server _selected = _Server.hosted;
  final _urlCtrl = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _urlCtrl.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (widget.busy || _saving) return;
    if (_selected == _Server.hosted) {
      await BackendConfig.setUrl(null);
      widget.onContinue();
      return;
    }
    final raw = _urlCtrl.text.trim();
    final uri = Uri.tryParse(raw);
    final valid = raw.isNotEmpty &&
        uri != null &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
    if (!valid) {
      setState(() => _error =
          'Enter a valid http(s) URL, e.g. https://schuly.example.com');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    await BackendConfig.setUrl(raw);
    if (!mounted) return;
    setState(() => _saving = false);
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

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
                'Which server?',
                textAlign: TextAlign.center,
                style: typography.xl2.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 28),
              _ModeCard(
                icon: FIcons.cloud,
                title: 'Schuly Cloud',
                tag: 'Recommended',
                body: 'The official Schuly server - the right choice for '
                    'most people.',
                selected: _selected == _Server.hosted,
                onTap: widget.busy
                    ? null
                    : () => setState(() {
                          _selected = _Server.hosted;
                          _error = null;
                        }),
              ),
              const SizedBox(height: 14),
              _ModeCard(
                icon: FIcons.server,
                title: 'Self-hosted',
                body: 'Connect to your own Schuly backend instance.',
                selected: _selected == _Server.custom,
                onTap: widget.busy
                    ? null
                    : () => setState(() => _selected = _Server.custom),
              ),
              if (_selected == _Server.custom) ...[
                const SizedBox(height: 14),
                FTextField(
                  control: FTextFieldControl.managed(controller: _urlCtrl),
                  label: const Text('Backend URL'),
                  hint: 'https://schuly.example.com',
                  autocorrect: false,
                ),
              ],
              if (_error != null) ...[
                const SizedBox(height: 8),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: typography.sm.copyWith(color: colors.error),
                ),
              ],
              const SizedBox(height: 24),
              FButton(
                onPress: (widget.busy || _saving) ? null : _continue,
                child: Text(_saving ? 'Saving...' : 'Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Mode { account, private }

/// The decision page: account vs private. The cards are a selectable toggle
/// (account preselected); a Continue button below commits the choice.
class _ModeChoicePage extends StatefulWidget {
  final bool busy;
  final VoidCallback onAccount;
  final VoidCallback onPrivate;

  const _ModeChoicePage({
    required this.busy,
    required this.onAccount,
    required this.onPrivate,
  });

  @override
  State<_ModeChoicePage> createState() => _ModeChoicePageState();
}

class _ModeChoicePageState extends State<_ModeChoicePage> {
  _Mode _selected = _Mode.account;

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
                body: 'Notifications, web access, and sync across devices. '
                    'Secured with a passkey.',
                selected: _selected == _Mode.account,
                onTap: widget.busy
                    ? null
                    : () => setState(() => _selected = _Mode.account),
              ),
              const SizedBox(height: 14),
              _ModeCard(
                icon: FIcons.shieldCheck,
                title: 'Private mode',
                body: 'No account - everything stays on your device. '
                    'No notifications, web, or sync.',
                selected: _selected == _Mode.private,
                onTap: widget.busy
                    ? null
                    : () => setState(() => _selected = _Mode.private),
              ),
              const SizedBox(height: 24),
              FButton(
                onPress: widget.busy
                    ? null
                    : () => _selected == _Mode.account
                        ? widget.onAccount()
                        : widget.onPrivate(),
                child: Text(widget.busy ? 'Please wait...' : 'Continue'),
              ),
              const SizedBox(height: 12),
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

/// A selectable mode card: centered content with a radio indicator in the
/// corner; the selected one gets a primary border and a tinted background.
class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String? tag;
  final bool selected;
  final VoidCallback? onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.body,
    this.tag,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final radius = BorderRadius.circular(14);

    return Material(
      color: selected ? colors.primary.withValues(alpha: 0.08) : colors.secondary,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: selected ? colors.primary : colors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: selected
                    ? Icon(FIcons.circleCheck, size: 22, color: colors.primary)
                    : Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.border, width: 2),
                        ),
                      ),
              ),
              SizedBox(
                width: double.infinity,
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
            ],
          ),
        ),
      ),
    );
  }
}
