import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../theme/schuly_theme.dart';

/// Opens a bottom sheet in the mockup's style: grab handle, title with an optional line below and a "Done" (or other)
/// action on the right in the accent, a scrolling body and an optional footer above the home indicator.
Future<T?> showSchulySheet<T>(BuildContext context, {required WidgetBuilder builder, bool useRootNavigator = true}) => showFSheet<T>(
      context: context,
      side: FLayout.btt,
      mainAxisMaxRatio: null,
      useRootNavigator: useRootNavigator,
      builder: builder,
    );

class SchulySheet extends StatelessWidget {
  const SchulySheet({super.key, required this.title, this.subtitle, this.action, this.onAction, this.body, this.footer, this.bodyPadding = const EdgeInsets.fromLTRB(18, 4, 18, 12)});

  final String title;
  final String? subtitle;

  /// The text action at the top right, such as "Done" or "Cancel". Closes the sheet unless [onAction] is given.
  final String? action;
  final VoidCallback? onAction;
  final Widget? body;
  final Widget? footer;
  final EdgeInsetsGeometry bodyPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final tokens = context.tokens;
    final typography = context.theme.typography;
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    final bottomInset = media.viewPadding.bottom;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: media.size.height - media.viewPadding.top - 24),
      child: Container(
        decoration: BoxDecoration(
          color: tokens.card,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(SchulyRadii.sheet)),
          border: Border(top: BorderSide(color: tokens.input)),
          boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 40, offset: Offset(0, -12))],
        ),
        padding: EdgeInsets.only(bottom: keyboard),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 22,
              child: Center(child: Container(width: 36, height: 5, decoration: BoxDecoration(color: colors.foreground.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(3)))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 2, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: typography.xl.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.18)),
                          if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(subtitle!, style: typography.sm.copyWith(color: colors.mutedForeground))),
                        ],
                      ),
                    ),
                  ),
                  if (action != null)
                    FButton(
                      onPress: onAction ?? () => Navigator.of(context).pop(),
                      mainAxisSize: MainAxisSize.min,
                      style: FButtonStyle.ghost((s) => s.copyWith(
                            contentStyle: (c) => c.copyWith(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              textStyle: FWidgetStateMap.all(typography.base.copyWith(fontWeight: FontWeight.w500, color: tokens.ink, height: 1)),
                            ),
                          )),
                      child: Text(action!),
                    ),
                ],
              ),
            ),
            if (body != null) Flexible(child: SingleChildScrollView(padding: bodyPadding, child: body)),
            if (footer != null)
              Container(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
                padding: EdgeInsets.fromLTRB(18, 10, 18, 14 + (keyboard > 0 ? 0 : bottomInset)),
                child: footer,
              )
            else
              SizedBox(height: 20 + (keyboard > 0 ? 0 : bottomInset)),
          ],
        ),
      ),
    );
  }
}

/// Two buttons side by side in a sheet footer.
class SheetButtons extends StatelessWidget {
  const SheetButtons({super.key, required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: left), const SizedBox(width: 8), Expanded(child: right)]);
}
