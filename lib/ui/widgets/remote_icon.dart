import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool isSvgUrl(String url) => Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') ?? false;

/// An icon the server names by URL, which may be a raster image or an SVG. `Image.network` cannot
/// draw SVG, so an `.svg` path goes straight to the SVG renderer, and an image that fails to decode
/// gets a second try there because a URL need not end in its format. Draws nothing when both fail.
class RemoteIcon extends StatelessWidget {
  const RemoteIcon(this.url, {super.key, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (isSvgUrl(url)) return _svg();
    return Image.network(url, width: size, height: size, errorBuilder: (_, _, _) => _svg());
  }

  Widget _svg() => SvgPicture.network(url, width: size, height: size, errorBuilder: (_, _, _) => SizedBox(width: size, height: size));
}
