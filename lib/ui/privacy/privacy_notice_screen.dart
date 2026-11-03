import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../services/app_mode_service.dart';
import '../../services/privacy_notice_service.dart';

/// The sign-up notice with its policy link. Same words as the web app (`PRIVACY_NOTICE` in SchulyServer's `core/privacy-notice.ts`).
class PrivacyNoticeText extends StatelessWidget {
  final String url;
  final TextAlign textAlign;
  const PrivacyNoticeText({super.key, this.url = kPrivacyPolicyUrl, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: [
        Text(
          AppModeService.instance.isPrivate ? t.privacyPrivateNotice : t.privacySignUpNotice,
          textAlign: textAlign,
          style: typography.xs.copyWith(color: colors.mutedForeground),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
          child: Text(
            t.privacyPolicyLink,
            textAlign: textAlign,
            style: typography.xs.copyWith(color: colors.foreground, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}

/// Asked once after sign-in or connecting, and again when the policy version changes.
class PrivacyNoticeScreen extends StatefulWidget {
  final PrivacyNoticeInfo info;
  final VoidCallback onAccepted;
  final VoidCallback onSignOut;
  final PrivacyNoticeService? service;
  const PrivacyNoticeScreen({super.key, required this.info, required this.onAccepted, required this.onSignOut, this.service});

  @override
  State<PrivacyNoticeScreen> createState() => _PrivacyNoticeScreenState();
}

class _PrivacyNoticeScreenState extends State<PrivacyNoticeScreen> {
  bool _swissConfirmed = false;
  bool _busy = false;
  String? _error;

  bool get _canContinue => !_busy && (!widget.info.swissSchoolConfirmationRequired || _swissConfirmed);

  Future<void> _accept() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await (widget.service ?? PrivacyNoticeService.instance).accept(widget.info, swissSchoolConfirmed: _swissConfirmed);
      widget.onAccepted();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = AppLocalizations.of(context)!.privacyNoticeFailed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return FScaffold(
      header: FHeader(title: Text(t.privacyNoticeTitle)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            PrivacyNoticeText(url: widget.info.url),
            if (widget.info.swissSchoolConfirmationRequired)
              FCheckbox(
                label: Text(t.swissSchoolConfirmation),
                value: _swissConfirmed,
                onChange: (value) => setState(() => _swissConfirmed = value),
              ),
            if (_error != null) Text(_error!, style: context.theme.typography.sm.copyWith(color: context.theme.colors.destructive)),
            FButton(onPress: _canContinue ? _accept : null, child: Text(t.privacyNoticeContinue)),
            FButton(style: FButtonStyle.ghost(), onPress: _busy ? null : widget.onSignOut, child: Text(t.privacyNoticeSignOut)),
          ],
        ),
      ),
    );
  }
}
