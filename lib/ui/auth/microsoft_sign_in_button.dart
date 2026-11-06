import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth_service.dart';

/// Microsoft providers get the branded button. The server names their icon `/sso-icons/microsoft.svg`
/// (older servers `.png`).
bool isMicrosoftProvider(SignInProvider provider) {
  final path = Uri.tryParse(provider.iconUrl ?? '')?.path.toLowerCase() ?? '';
  return provider.key.toLowerCase() == 'microsoft' || path.endsWith('/sso-icons/microsoft.svg') || path.endsWith('/sso-icons/microsoft.png');
}

/// The "Sign in with Microsoft" button as Microsoft's branding guidelines specify it
/// (learn.microsoft.com/entra/identity-platform/howto-add-branding-in-apps): the official logo SVG at 21,
/// 41 high, 12 padding and 12 between logo and text, Segoe UI 15 weight 600, square corners.
/// Light: #FFFFFF with a 1 #8C8C8C border and #5E5E5E text. Dark: #2F2F2F with #FFFFFF text.
class MicrosoftSignInButton extends StatelessWidget {
  const MicrosoftSignInButton({super.key, required this.onPress});

  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    final dark = context.theme.colors.brightness == Brightness.dark;
    final background = dark ? const Color(0xFF2F2F2F) : const Color(0xFFFFFFFF);
    final border = dark ? const Color(0xFF2F2F2F) : const Color(0xFF8C8C8C);
    final text = dark ? const Color(0xFFFFFFFF) : const Color(0xFF5E5E5E);
    final label = AppLocalizations.of(context)!.signInWithMicrosoft;

    return Center(
      child: Semantics(
        button: true,
        enabled: onPress != null,
        label: label,
        excludeSemantics: true,
        child: Opacity(
          opacity: onPress == null ? 0.6 : 1,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPress,
            child: Container(
              height: 41,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: background, border: Border.all(color: border)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/sso/microsoft.svg', width: 21, height: 21),
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(fontFamily: 'Segoe UI', fontFamilyFallback: const ['Roboto', '.SF UI Text'], fontSize: 15, fontWeight: FontWeight.w600, color: text, height: 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
