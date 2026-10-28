import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for LinkedAccountsApi
void main() {
  final instance = SchulyApi().getLinkedAccountsApi();

  group(LinkedAccountsApi, () {
    //Future<BuiltList<LinkedAccountDto>> apiMeLinkedAccountsGet({ String provider }) async
    test('test apiMeLinkedAccountsGet', () async {
      // TODO
    });

    //Future apiMeLinkedAccountsIdDelete(String id) async
    test('test apiMeLinkedAccountsIdDelete', () async {
      // TODO
    });

  });
}
