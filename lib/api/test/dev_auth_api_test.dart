import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for DevAuthApi
void main() {
  final instance = SchulyApi().getDevAuthApi();

  group(DevAuthApi, () {
    //Future<DevTokenResponse> apiDevTokenPost({ DevTokenRequest devTokenRequest }) async
    test('test apiDevTokenPost', () async {
      // TODO
    });

  });
}
