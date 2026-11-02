import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

/// Renders the small markdown subset used by release notes (headings, paragraphs,
/// bullet/numbered lists, bold, italic, code, links) with Forui typography - no Material.
class MarkdownText extends StatefulWidget {
  const MarkdownText(this.data, {super.key});

  final String data;

  @override
  State<MarkdownText> createState() => _MarkdownTextState();
}

class _MarkdownTextState extends State<MarkdownText> {
  final _recognizers = <TapGestureRecognizer>[];

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final nodes = md.Document(extensionSet: md.ExtensionSet.gitHubFlavored).parseLines(widget.data.replaceAll('\r\n', '\n').split('\n'));
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final base = typography.sm.copyWith(color: colors.foreground, height: 1.4);

    final blocks = <Widget>[];
    for (final node in nodes) {
      blocks.add(_block(node, base, colors, typography, 0));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: blocks);
  }

  Widget _block(md.Node node, TextStyle base, FColors colors, FTypography typography, int depth) {
    if (node is md.Text) return Text(node.text, style: base);
    final el = node as md.Element;
    switch (el.tag) {
      case 'h1':
      case 'h2':
      case 'h3':
      case 'h4':
        final style = el.tag == 'h1' ? typography.lg : typography.base;
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 4),
          child: Text.rich(_inline(el.children, style.copyWith(color: colors.foreground, fontWeight: FontWeight.w700), colors)),
        );
      case 'ul':
      case 'ol':
        final items = (el.children ?? []).whereType<md.Element>().toList();
        return Padding(
          padding: EdgeInsets.only(left: depth == 0 ? 0 : 14, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < items.length; i++) _listItem(items[i], el.tag == 'ol' ? '${i + 1}.' : '•', base, colors, typography, depth),
            ],
          ),
        );
      case 'hr':
        return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Container(height: 1, color: colors.border));
      case 'pre':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(el.textContent.trimRight(), style: base.copyWith(fontFamily: 'monospace')),
        );
      case 'blockquote':
        return Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final c in el.children ?? <md.Node>[]) _block(c, base.copyWith(color: colors.mutedForeground), colors, typography, depth)],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text.rich(_inline(el.children, base, colors)),
        );
    }
  }

  Widget _listItem(md.Element li, String marker, TextStyle base, FColors colors, FTypography typography, int depth) {
    final inline = <md.Node>[];
    final nested = <md.Node>[];
    for (final child in li.children ?? <md.Node>[]) {
      if (child is md.Element && (child.tag == 'ul' || child.tag == 'ol')) {
        nested.add(child);
      } else if (child is md.Element && child.tag == 'p') {
        inline.addAll(child.children ?? []);
      } else {
        inline.add(child);
      }
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 18, child: Text(marker, style: base.copyWith(color: colors.mutedForeground))),
              Expanded(child: Text.rich(_inline(inline, base, colors))),
            ],
          ),
          for (final n in nested) _block(n, base, colors, typography, depth + 1),
        ],
      ),
    );
  }

  InlineSpan _inline(List<md.Node>? nodes, TextStyle style, FColors colors) {
    return TextSpan(
      style: style,
      children: [
        for (final n in nodes ?? <md.Node>[])
          if (n is md.Text)
            TextSpan(text: n.text)
          else if (n is md.Element)
            _element(n, style, colors),
      ],
    );
  }

  InlineSpan _element(md.Element el, TextStyle style, FColors colors) {
    switch (el.tag) {
      case 'strong':
        return TextSpan(style: const TextStyle(fontWeight: FontWeight.w700), children: [_inline(el.children, style, colors)]);
      case 'em':
        return TextSpan(style: const TextStyle(fontStyle: FontStyle.italic), children: [_inline(el.children, style, colors)]);
      case 'code':
        return TextSpan(text: el.textContent, style: TextStyle(fontFamily: 'monospace', backgroundColor: colors.muted));
      case 'br':
        return const TextSpan(text: '\n');
      case 'a':
        final uri = Uri.tryParse(el.attributes['href'] ?? '');
        final recognizer = TapGestureRecognizer();
        if (uri != null && uri.scheme == 'https') {
          recognizer.onTap = () => launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        _recognizers.add(recognizer);
        return TextSpan(
          style: TextStyle(color: colors.primary, decoration: TextDecoration.underline),
          recognizer: recognizer,
          children: [_inline(el.children, style, colors)],
        );
      default:
        return _inline(el.children, style, colors);
    }
  }
}
