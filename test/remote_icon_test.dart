import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/ui/widgets/remote_icon.dart';

void main() {
  test('svg urls are recognised by their path, whatever the query', () {
    expect(isSvgUrl('https://server.example/sso-icons/gaggao-id.svg'), isTrue);
    expect(isSvgUrl('https://server.example/ICON.SVG?v=2'), isTrue);
    expect(isSvgUrl('https://server.example/sso-icons/google.png'), isFalse);
    expect(isSvgUrl('https://server.example/icon?file=a.svg'), isFalse);
  });

  testWidgets('a raster url is drawn as an image, not as svg', (tester) async {
    await tester.pumpWidget(const Directionality(textDirection: TextDirection.ltr, child: RemoteIcon('https://server.example/sso-icons/google.png', size: 18)));
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });
}
