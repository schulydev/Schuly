import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for StatelessAuthApi
void main() {
  final instance = SchulyApi().getStatelessAuthApi();

  group(StatelessAuthApi, () {
    //Future apiPluginsSchulwareStatelessLoginMethodGet({ String baseUrl }) async
    test('test apiPluginsSchulwareStatelessLoginMethodGet', () async {
      // TODO
    });

    //Future apiPluginsSchulwareStatelessLoginPost(StatelessLoginRequest statelessLoginRequest) async
    test('test apiPluginsSchulwareStatelessLoginPost', () async {
      // TODO
    });

    //Future apiPluginsSchulwareStatelessRefreshPost(StatelessRefreshRequest statelessRefreshRequest) async
    test('test apiPluginsSchulwareStatelessRefreshPost', () async {
      // TODO
    });

  });
}
