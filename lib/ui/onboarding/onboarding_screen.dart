import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import '../../config/backend_config.dart';

/// First-run onboarding: three intro slides, then a server step (hosted vs
/// self-hosted), then the Account-vs-Private mode choice. Forui has no carousel
/// widget, so the swipe is a plain [PageView]; everything else is Forui.
///
/// All selection state lives here so a single bottom "Next" button drives every
/// page: intro -> next, server -> validate + next, mode -> commit.
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

enum _Server { hosted, custom }

enum _Mode { account, private }

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pageCount = 5;
  static const _serverPage = 3;
  static const _modePage = 4;

  final _controller = PageController();
  final _urlCtrl = TextEditingController();
  int _page = 0;

  _Server _server = _Server.hosted;
  String? _serverError;
  String? _serverOk;
  bool _probing = false;

  _Mode _mode = _Mode.account;
  bool _busy = false; // sign-in / connect in flight

  @override
  void initState() {
    super.initState();
    // Editing the URL invalidates a prior probe, so re-lock until re-verified.
    _urlCtrl.addListener(() {
      if (_serverOk != null || _serverError != null) {
        setState(() {
          _serverOk = null;
          _serverError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _urlCtrl.dispose();
    super.dispose();
  }

  void _next() => _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  /// Server step: hosted continues immediately; self-hosted is validated and
  /// probed (parsing the backend version) before continuing.
  Future<void> _confirmServer() async {
    if (_probing) return;
    if (_server == _Server.hosted) {
      await BackendConfig.setUrl(null);
      _next();
      return;
    }
    final raw = _urlCtrl.text.trim();
    final uri = Uri.tryParse(raw);
    final valid = raw.isNotEmpty &&
        uri != null &&
        (uri.isScheme('http') || uri.isScheme('https')) &&
        uri.host.isNotEmpty;
    if (!valid) {
      setState(() {
        _serverError =
            'Enter a valid http(s) URL, e.g. https://schuly.example.com';
        _serverOk = null;
      });
      return;
    }
    setState(() {
      _probing = true;
      _serverError = null;
      _serverOk = null;
    });
    final version = await BackendConfig.probe(raw);
    if (!mounted) return;
    if (version == null) {
      setState(() {
        _probing = false;
        _serverError = "Couldn't reach a Schuly backend at this URL. "
            'Check the address and that the server is running.';
      });
      return;
    }
    await BackendConfig.setUrl(raw);
    if (!mounted) return;
    setState(() {
      _probing = false;
      _serverOk = 'Connected - Schuly v$version';
    });
    // Briefly show the version, then continue to the mode choice.
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) _next();
  }

  Future<void> _commitMode() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await (_mode == _Mode.account
          ? widget.onChooseAccount()
          : widget.onChoosePrivate());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String get _buttonLabel {
    if (_page == _serverPage && _probing) return 'Checking...';
    if (_page == _modePage && _busy) return 'Please wait...';
    return 'Next';
  }

  VoidCallback? get _buttonAction {
    if (_probing || _busy) return null;
    if (_page == _serverPage) return _confirmServer;
    if (_page == _modePage) return _commitMode;
    return _next;
  }

  // Block swiping past the server page until a self-hosted URL is verified;
  // the Next button still advances (it probes first).
  bool get _serverLocked =>
      _page == _serverPage && _server == _Server.custom && _serverOk == null;

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
                physics: _serverLocked
                    ? const NeverScrollableScrollPhysics()
                    : null,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  const _IntroPage(
                    asset: 'assets/cropped_schuly_icon.png',
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
                  _ServerPage(
                    selected: _server,
                    urlController: _urlCtrl,
                    error: _serverError,
                    okMessage: _serverOk,
                    onSelect: (s) => setState(() {
                      _server = s;
                      _serverError = null;
                      _serverOk = null;
                    }),
                  ),
                  _ModeChoicePage(
                    selected: _mode,
                    onSelect: (m) => setState(() => _mode = m),
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
            // One bottom button drives every page.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: SizedBox(
                width: double.infinity,
                child: FButton(
                  onPress: _buttonAction,
                  child: Text(_buttonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single intro slide: a large badge, a title, and a short blurb.
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
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: colors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                asset!,
                height: 64,
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
            style: typography.xl3.copyWith(fontWeight: FontWeight.w700, height: 1.1),
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

/// The server step: hosted Schuly Cloud (default) or a self-hosted backend URL.
/// Pure UI - the parent owns the selection and the Next button validates it.
class _ServerPage extends StatelessWidget {
  final _Server selected;
  final TextEditingController urlController;
  final String? error;
  final String? okMessage;
  final ValueChanged<_Server> onSelect;

  const _ServerPage({
    required this.selected,
    required this.urlController,
    required this.error,
    required this.okMessage,
    required this.onSelect,
  });

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
                style: typography.xl2
                    .copyWith(fontWeight: FontWeight.w700, height: 1.1),
              ),
              const SizedBox(height: 28),
              _ModeCard(
                icon: FIcons.cloud,
                title: 'Schuly Cloud',
                tag: 'Recommended',
                body: 'The official Schuly server - the right choice for '
                    'most people.',
                selected: selected == _Server.hosted,
                onTap: () => onSelect(_Server.hosted),
              ),
              const SizedBox(height: 14),
              _ModeCard(
                icon: FIcons.server,
                title: 'Self-hosted',
                body: 'Connect to your own Schuly backend instance.',
                selected: selected == _Server.custom,
                onTap: () => onSelect(_Server.custom),
              ),
              if (selected == _Server.custom) ...[
                const SizedBox(height: 14),
                FTextField(
                  control: FTextFieldControl.managed(controller: urlController),
                  label: const Text('Backend URL'),
                  hint: 'https://schuly.example.com',
                  autocorrect: false,
                ),
              ],
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(
                  error!,
                  textAlign: TextAlign.center,
                  style: typography.sm.copyWith(color: colors.error),
                ),
              ],
              if (okMessage != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FIcons.circleCheck, size: 16, color: colors.primary),
                    const SizedBox(width: 6),
                    Text(
                      okMessage!,
                      style: typography.sm.copyWith(color: colors.primary),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The decision page: account vs private, as a selectable toggle. Pure UI - the
/// parent owns the selection and the Next button commits it.
class _ModeChoicePage extends StatelessWidget {
  final _Mode selected;
  final ValueChanged<_Mode> onSelect;

  const _ModeChoicePage({required this.selected, required this.onSelect});

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
                'How do you want to use Schuly?',
                textAlign: TextAlign.center,
                style: typography.xl2
                    .copyWith(fontWeight: FontWeight.w700, height: 1.1),
              ),
              const SizedBox(height: 28),
              _ModeCard(
                icon: FIcons.cloud,
                title: 'Schuly account',
                tag: 'Recommended',
                body: 'Notifications, web access, and sync across devices. '
                    'Secured with a passkey.',
                selected: selected == _Mode.account,
                onTap: () => onSelect(_Mode.account),
              ),
              const SizedBox(height: 14),
              _ModeCard(
                icon: FIcons.shieldCheck,
                title: 'Private mode',
                body: 'No account - everything stays on your device. '
                    'No notifications, web, or sync.',
                selected: selected == _Mode.private,
                onTap: () => onSelect(_Mode.private),
              ),
              const SizedBox(height: 16),
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

/// A selectable card: centered content with a radio indicator in the corner;
/// the selected one gets a primary border and a tinted background.
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
