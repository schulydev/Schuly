import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/ui/widgets/remote_icon.dart';

void main() {
  test('svg urls are recognised by their path, whatever the query', () {
    expect(isSvgUrl('https://server.example/sso-icons/gaggao-id.svg'), isTrue);
    expect(isSvgUrl('https://server.example/ICON.SVG?v=2'), isTrue);
    expect(isSvgUrl('https://server.example/sso-icons/google.png'), isFalse);
    expect(isSvgUrl('https://server.example/icon?file=a.svg'), isFalse);
  });

  test('svg content is recognised whatever the url says', () {
    expect(looksLikeSvg(Uint8List.fromList(utf8.encode('  <svg xmlns="http://www.w3.org/2000/svg"/>'))), isTrue);
    expect(looksLikeSvg(Uint8List.fromList(utf8.encode('<?xml version="1.0"?><svg/>'))), isTrue);
    expect(looksLikeSvg(Uint8List.fromList([0x89, 0x50, 0x4E, 0x47])), isFalse);
  });
}
