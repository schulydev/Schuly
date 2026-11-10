import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/ui/auth_image.dart';

bool isSvgUrl(String url) => Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') ?? false;

/// True when [bytes] start like an SVG document.
bool looksLikeSvg(Uint8List bytes) {
  final head = utf8.decode(bytes.take(256).toList(), allowMalformed: true).trimLeft();
  return head.startsWith('<svg') || head.startsWith('<?xml');
}

/// An icon the server names by URL, which may be a raster image or an SVG. The bytes come through
/// [fetchImageBytes], so a Schuly server URL is fetched with the account's token, never anonymously; the format is
/// read from the path or the content. Draws nothing until loaded or when it fails.
class RemoteIcon extends StatelessWidget {
  const RemoteIcon(this.url, {super.key, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    final empty = SizedBox(width: size, height: size);
    return FutureBuilder<Uint8List>(
      future: fetchImageBytes(url),
      builder: (context, snap) {
        final bytes = snap.data;
        if (bytes == null) return empty;
        if (isSvgUrl(url) || looksLikeSvg(bytes)) return SvgPicture.memory(bytes, width: size, height: size, errorBuilder: (_, _, _) => empty);
        return Image.memory(bytes, width: size, height: size, errorBuilder: (_, _, _) => empty);
      },
    );
  }
}
