import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for AccountsApi
void main() {
  final instance = SchulyApi().getAccountsApi();

  group(AccountsApi, () {
    //Future apiPluginsMicrosoftAccountsAccountIdCalendarGet(String accountId, { int top }) async
    test('test apiPluginsMicrosoftAccountsAccountIdCalendarGet', () async {
      // TODO
    });

    //Future apiPluginsMicrosoftAccountsAccountIdFilesGet(String accountId, { String path, int top }) async
    test('test apiPluginsMicrosoftAccountsAccountIdFilesGet', () async {
      // TODO
    });

    //Future apiPluginsMicrosoftAccountsAccountIdMailGet(String accountId, { String folder, int top, bool unread, String search }) async
    test('test apiPluginsMicrosoftAccountsAccountIdMailGet', () async {
      // TODO
    });

    //Future apiPluginsOdaorgAccountsAccountIdDelete(String accountId) async
    test('test apiPluginsOdaorgAccountsAccountIdDelete', () async {
      // TODO
    });

    //Future apiPluginsOdaorgAccountsGet() async
    test('test apiPluginsOdaorgAccountsGet', () async {
      // TODO
    });

    //Future apiPluginsSchulwareAccountsAccountIdDelete(String accountId) async
    test('test apiPluginsSchulwareAccountsAccountIdDelete', () async {
      // TODO
    });

    //Future apiPluginsSchulwareAccountsGet() async
    test('test apiPluginsSchulwareAccountsGet', () async {
      // TODO
    });

  });
}
