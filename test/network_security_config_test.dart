import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const path = 'res/xml/network_security_config.xml';

  test('release flavors allow no cleartext traffic', () {
    final main = File('android/app/src/main/$path').readAsStringSync();
    expect(main, contains('cleartextTrafficPermitted="false"'));
    expect(main, isNot(contains('cleartextTrafficPermitted="true"')));
    expect(main, isNot(contains('192.168.')));
    expect(File('android/app/src/prod/$path').existsSync(), isFalse);
  });

  test('the dev flavor keeps its local backends', () {
    final dev = File('android/app/src/dev/$path').readAsStringSync();
    expect(dev, contains('cleartextTrafficPermitted="true"'));
    expect(dev, contains('10.0.2.2'));
  });
}
