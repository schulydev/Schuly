import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

import '../../config/backend_config.dart';
import '../widgets/remote_icon.dart';

/// Real logos bundled with the app, by provider or school system id. Bundled, so they also show before sign-in.
const _bundled = <String, String>{
  'schulnetz': 'assets/schoolsystems/schulnetz.webp',
  'odaorg': 'assets/schoolsystems/odaorg.webp',
  'microsoft': 'assets/providers/microsoft.svg',
};

/// The Lucide icons a provider may name, as the web's `provider-icons.ts` registers them; anything else is a link.
IconData lucideIcon(String? name) => switch (name) {
      'backpack' => FIcons.backpack,
      'book-open' => FIcons.bookOpen,
      'briefcase' => FIcons.briefcase,
      'building' => FIcons.building,
      'building-2' => FIcons.building2,
      'calendar' => FIcons.calendar,
      'calendar-days' => FIcons.calendarDays,
      'chart-column' => FIcons.chartColumn,
      'cloud' => FIcons.cloud,
      'file-text' => FIcons.fileText,
      'folder' => FIcons.folder,
      'globe' => FIcons.globe,
      'graduation-cap' => FIcons.graduationCap,
      'hard-drive' => FIcons.hardDrive,
      'key-round' => FIcons.keyRound,
      'layout-grid' => FIcons.layoutGrid,
      'library' => FIcons.library,
      'mail' => FIcons.mail,
      'message-square' => FIcons.messageSquare,
      'messages-square' => FIcons.messagesSquare,
      'notebook' => FIcons.notebook,
      'notebook-pen' => FIcons.notebookPen,
      'school' => FIcons.school,
      'shield-check' => FIcons.shieldCheck,
      'user-x' => FIcons.userX,
      'users' => FIcons.users,
      _ => FIcons.link,
    };

/// A provider's logo: the bundled real logo when the app has one, else the sanitized SVG the server hosts (fetched
/// with the account's token), else its Lucide icon.
class ProviderIcon extends StatelessWidget {
  const ProviderIcon({super.key, required this.id, this.lucide, this.svgUrl, this.size = 20});

  final String id;
  final String? lucide;
  final String? svgUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final fallback = Icon(lucideIcon(lucide), size: size);
    final asset = _bundled[id];
    if (asset != null) {
      return asset.endsWith('.svg')
          ? SvgPicture.asset(asset, width: size, height: size)
          : Image.asset(asset, width: size, height: size, fit: BoxFit.contain, errorBuilder: (_, _, _) => fallback);
    }
    final url = BackendConfig.resolveUrl(svgUrl);
    if (url != null) return RemoteIcon(url, size: size);
    return fallback;
  }
}

/// True when the app bundles a logo for [id].
bool hasBundledLogo(String id) => _bundled.containsKey(id);
