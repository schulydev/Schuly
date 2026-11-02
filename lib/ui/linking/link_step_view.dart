import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/school_system.dart';
import '../../services/linking_service.dart';
import '../authenticator/totp_field_picker.dart';
import '../widgets/suggestion_picker.dart';

/// Renders one [LinkStep] with Forui widgets. It owns no network state: the flow screen hands it
/// the step and reacts to the callbacks.
class LinkStepView extends StatelessWidget {
  final LinkStep step;
  final bool busy;
  final String? error;
  final Future<void> Function(Map<String, String> values) onSubmit;
  final Future<void> Function(String actionId) onAction;
  final Future<void> Function(LinkOption option) onPickOption;
  final VoidCallback onOpenRedirect;
  final VoidCallback onClose;

  const LinkStepView({required this.step, required this.busy, required this.error, required this.onSubmit, required this.onAction, required this.onPickOption, required this.onOpenRedirect, required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final message = error ?? step.error;
    final body = switch (step.kind) {
      LinkStepKind.form => LinkFormStep(key: ValueKey(step.id), step: step, busy: busy, onSubmit: onSubmit),
      LinkStepKind.otp => LinkOtpStep(key: ValueKey(step.id), step: step, busy: busy, onSubmit: onSubmit),
      LinkStepKind.pushCode => LinkPushStep(key: ValueKey(step.id), step: step),
      LinkStepKind.deviceCode => LinkDeviceStep(key: ValueKey(step.id), step: step),
      LinkStepKind.redirect => _RedirectStep(step: step, busy: busy, onOpen: onOpenRedirect),
      LinkStepKind.select => _SelectStep(step: step, busy: busy, onPick: onPickOption),
      LinkStepKind.done => const Center(child: FCircularProgress()),
      LinkStepKind.error => _ErrorStep(step: step, onClose: onClose),
    };
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          if (step.description != null && step.kind != LinkStepKind.error) Text(step.description!, style: typography.sm.copyWith(color: colors.mutedForeground)),
          body,
          if (message != null && step.kind != LinkStepKind.error) SelectableText(message, style: typography.sm.copyWith(color: colors.destructive)),
          if (step.kind != LinkStepKind.error && step.kind != LinkStepKind.done)
            for (final action in step.actions) FButton(style: FButtonStyle.secondary(), onPress: busy ? null : () => onAction(action.id), child: Text(action.label)),
        ],
      ),
    );
  }
}

/// A form step: text/email/password/url/select fields and the totp secret picker.
class LinkFormStep extends StatefulWidget {
  final LinkStep step;
  final bool busy;
  final Future<void> Function(Map<String, String> values) onSubmit;
  const LinkFormStep({required this.step, required this.busy, required this.onSubmit, super.key});

  @override
  State<LinkFormStep> createState() => _LinkFormStepState();
}

class _LinkFormStepState extends State<LinkFormStep> {
  late final Map<String, TextEditingController> _controllers = {for (final f in widget.step.fields) f.key: TextEditingController(text: f.defaultValue ?? '')};
  String? _missing;

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    for (final f in widget.step.fields) {
      if (f.required && _controllers[f.key]!.text.trim().isEmpty) {
        setState(() => _missing = '${f.label} is required');
        return;
      }
    }
    setState(() => _missing = null);
    await widget.onSubmit({
      for (final f in widget.step.fields)
        if (_controllers[f.key]!.text.trim().isNotEmpty) f.key: f.secret || f.type == LinkFieldType.password || f.type == LinkFieldType.totpSecret ? _controllers[f.key]!.text : _controllers[f.key]!.text.trim(),
    });
  }

  static List<String> _hints(LinkField f) => switch (f.type) {
        LinkFieldType.password => const [AutofillHints.password],
        LinkFieldType.email => const [AutofillHints.username, AutofillHints.email],
        LinkFieldType.url => const [AutofillHints.url],
        _ => const [],
      };

  static TextInputType _keyboard(LinkField f) => switch (f.type) {
        LinkFieldType.url => TextInputType.url,
        LinkFieldType.email => TextInputType.emailAddress,
        _ => TextInputType.text,
      };

  Widget _field(LinkField f, int index, int count) {
    final controller = _controllers[f.key]!;
    final adapted = SchoolSystemLoginField(
      key: f.key,
      label: f.label,
      type: f.type == LinkFieldType.totpSecret ? 'totp' : 'text',
      placeholder: f.placeholder,
      required: f.required,
      suggestions: [for (final o in f.options) LoginFieldSuggestion(label: o.label, value: o.value)],
    );
    Widget text() => FTextField(
          control: FTextFieldControl.managed(controller: controller),
          label: Text(f.label),
          hint: f.placeholder,
          description: f.help == null ? null : Text(f.help!),
          obscureText: f.secret || f.type == LinkFieldType.password,
          maxLength: f.maxLength,
          keyboardType: _keyboard(f),
          textInputAction: index == count - 1 ? TextInputAction.done : TextInputAction.next,
          autofillHints: _hints(f),
          autocorrect: false,
        );
    if (f.type == LinkFieldType.totpSecret) return TotpFieldPicker(controller: controller, field: adapted);
    if (f.options.isNotEmpty && f.allowCustom) return SuggestionPicker(controller: controller, field: adapted, textField: text());
    if (f.options.isNotEmpty) return _OptionField(field: f, controller: controller);
    return text();
  }

  @override
  Widget build(BuildContext context) {
    final fields = widget.step.fields;
    final colors = context.theme.colors;
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          for (final (i, f) in fields.indexed) _field(f, i, fields.length),
          if (_missing != null) Text(_missing!, style: context.theme.typography.sm.copyWith(color: colors.destructive)),
          FButton(onPress: widget.busy ? null : _submit, child: Text(widget.busy ? 'Working...' : (widget.step.submitLabel ?? 'Continue'))),
        ],
      ),
    );
  }
}

/// A select field without free text: one outlined tile per option.
class _OptionField extends StatefulWidget {
  final LinkField field;
  final TextEditingController controller;
  const _OptionField({required this.field, required this.controller});

  @override
  State<_OptionField> createState() => _OptionFieldState();
}

class _OptionFieldState extends State<_OptionField> {
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        _Label(widget.field.label),
        for (final o in widget.field.options)
          FTile(
            title: Text(o.label),
            subtitle: o.detail == null ? null : Text(o.detail!),
            suffix: widget.controller.text == o.value ? Icon(FIcons.check, color: colors.primary) : null,
            onPress: () => setState(() => widget.controller.text = o.value),
          ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Text(text.toUpperCase(), style: context.theme.typography.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}

/// A one-time code of a fixed length.
class LinkOtpStep extends StatefulWidget {
  final LinkStep step;
  final bool busy;
  final Future<void> Function(Map<String, String> values) onSubmit;
  const LinkOtpStep({required this.step, required this.busy, required this.onSubmit, super.key});

  @override
  State<LinkOtpStep> createState() => _LinkOtpStepState();
}

class _LinkOtpStepState extends State<LinkOtpStep> {
  final _controller = TextEditingController();
  String? _problem;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _controller.text.trim();
    if (code.length != widget.step.otpLength) {
      setState(() => _problem = 'Enter the ${widget.step.otpLength}-digit code');
      return;
    }
    setState(() => _problem = null);
    await widget.onSubmit({'code': code});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        FTextField(
          control: FTextFieldControl.managed(controller: _controller),
          label: Text(widget.step.otpLabel ?? 'Code'),
          maxLength: widget.step.otpLength,
          keyboardType: widget.step.otpNumericOnly ? TextInputType.number : TextInputType.text,
          inputFormatters: [if (widget.step.otpNumericOnly) FilteringTextInputFormatter.digitsOnly],
          autofillHints: const [AutofillHints.oneTimeCode],
          autocorrect: false,
        ),
        if (_problem != null) Text(_problem!, style: context.theme.typography.sm.copyWith(color: colors.destructive)),
        FButton(onPress: widget.busy ? null : _submit, child: Text(widget.busy ? 'Working...' : (widget.step.submitLabel ?? 'Verify'))),
      ],
    );
  }
}

/// Seconds left until [expiresAt], ticking once a second.
class _Countdown extends StatefulWidget {
  final DateTime? expiresAt;
  const _Countdown({required this.expiresAt});

  @override
  State<_Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<_Countdown> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.expiresAt != null) _timer = Timer.periodic(const Duration(seconds: 1), (_) => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final at = widget.expiresAt;
    if (at == null) return const SizedBox.shrink();
    final left = at.difference(DateTime.now());
    final secs = left.isNegative ? 0 : left.inSeconds;
    final text = secs == 0 ? 'Expired' : 'Expires in ${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')}';
    return Text(text, textAlign: TextAlign.center, style: context.theme.typography.sm.copyWith(color: context.theme.colors.mutedForeground));
  }
}

/// "Approve the sign-in and enter this number". The flow screen polls while this is shown.
class LinkPushStep extends StatelessWidget {
  final LinkStep step;
  const LinkPushStep({required this.step, super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        if (step.pushNumber != null) Text(step.pushNumber!, textAlign: TextAlign.center, style: typography.xl4.copyWith(fontWeight: FontWeight.w700, letterSpacing: 4)),
        _Countdown(expiresAt: step.expiresAt),
        const Center(child: FCircularProgress()),
      ],
    );
  }
}

/// A code to enter on another device, with a copy button and (https only) a link to open.
class LinkDeviceStep extends StatelessWidget {
  final LinkStep step;
  const LinkDeviceStep({required this.step, super.key});

  static bool _isHttps(String? uri) => uri != null && (Uri.tryParse(uri)?.isScheme('https') ?? false);

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typography;
    final code = step.deviceUserCode ?? '';
    final uri = step.deviceVerificationUri;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        Text(code, textAlign: TextAlign.center, style: typography.xl3.copyWith(fontWeight: FontWeight.w700, letterSpacing: 3)),
        FButton(style: FButtonStyle.outline(), prefix: const Icon(FIcons.copy), onPress: () => Clipboard.setData(ClipboardData(text: code)), child: const Text('Copy code')),
        if (_isHttps(uri)) FButton(prefix: const Icon(FIcons.externalLink), onPress: () => launchUrl(Uri.parse(uri!), mode: LaunchMode.externalApplication), child: const Text('Open sign-in page')),
        _Countdown(expiresAt: step.expiresAt),
        const Center(child: FCircularProgress()),
      ],
    );
  }
}

class _RedirectStep extends StatelessWidget {
  final LinkStep step;
  final bool busy;
  final VoidCallback onOpen;
  const _RedirectStep({required this.step, required this.busy, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final capture = step.redirect?.capture ?? false;
    return FButton(prefix: Icon(capture ? FIcons.logIn : FIcons.externalLink), onPress: busy ? null : onOpen, child: Text(step.submitLabel ?? (capture ? 'Open sign-in' : 'Continue in your browser')));
  }
}

class _SelectStep extends StatelessWidget {
  final LinkStep step;
  final bool busy;
  final Future<void> Function(LinkOption option) onPick;
  const _SelectStep({required this.step, required this.busy, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (final o in step.options)
          FTile(
            prefix: Icon(o.linkProviderId != null ? FIcons.plus : FIcons.userRound),
            title: Text(o.label),
            subtitle: o.detail == null ? null : Text(o.detail!),
            suffix: const Icon(FIcons.chevronRight),
            onPress: busy ? null : () => onPick(o),
          ),
      ],
    );
  }
}

class _ErrorStep extends StatelessWidget {
  final LinkStep step;
  final VoidCallback onClose;
  const _ErrorStep({required this.step, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Icon(FIcons.circleAlert, size: 40, color: colors.destructive),
        SelectableText(step.error ?? step.description ?? 'Something went wrong.', textAlign: TextAlign.center, style: context.theme.typography.base),
        FButton(onPress: onClose, child: const Text('Close')),
      ],
    );
  }
}
