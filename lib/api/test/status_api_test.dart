import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for StatusApi
void main() {
  final instance = SchulyApi().getStatusApi();

  group(StatusApi, () {
    //Future apiPluginsOdaorgStatusGet() async
    test('test apiPluginsOdaorgStatusGet', () async {
      // TODO
    });

    //Future apiPluginsSchulwareStatusGet() async
    test('test apiPluginsSchulwareStatusGet', () async {
      // TODO
    });

  });
}
