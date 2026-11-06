import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/config/backend_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a saved copy of the retired hosted address falls back to the hosted server', () async {
    SharedPreferences.setMockInitialValues({'backend.url': '${BackendConfig.retiredHostedUrl}/'});
    await BackendConfig.load();
    expect(BackendConfig.url, BackendConfig.hostedUrl);
    expect((await SharedPreferences.getInstance()).getString('backend.url'), isNull);
  });

  test('a self-hosted address is kept', () async {
    SharedPreferences.setMockInitialValues({'backend.url': 'https://schuly.example.com'});
    await BackendConfig.load();
    expect(BackendConfig.url, 'https://schuly.example.com');
    await BackendConfig.setUrl(null);
  });
}
