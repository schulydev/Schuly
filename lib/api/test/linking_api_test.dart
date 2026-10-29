import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for LinkingApi
void main() {
  final instance = SchulyApi().getLinkingApi();

  group(LinkingApi, () {
    //Future<BuiltList<LinkProviderAccountDto>> apiLinkingAccountsGet() async
    test('test apiLinkingAccountsGet', () async {
      // TODO
    });

    //Future apiLinkingAccountsProviderIdAccountIdDelete(String providerId, String accountId) async
    test('test apiLinkingAccountsProviderIdAccountIdDelete', () async {
      // TODO
    });

    //Future apiLinkingCallbackGet({ String session }) async
    test('test apiLinkingCallbackGet', () async {
      // TODO
    });

    //Future<BuiltList<LinkProviderDto>> apiLinkingProvidersGet({ String platform }) async
    test('test apiLinkingProvidersGet', () async {
      // TODO
    });

    //Future<String> apiLinkingProvidersProviderIdIconSvgGet(String providerId) async
    test('test apiLinkingProvidersProviderIdIconSvgGet', () async {
      // TODO
    });

    //Future<LinkSessionDto> apiLinkingProvidersProviderIdStartPost(String providerId, StartLinkRequest startLinkRequest) async
    test('test apiLinkingProvidersProviderIdStartPost', () async {
      // TODO
    });

    //Future apiLinkingSessionsSessionIdDelete(String sessionId) async
    test('test apiLinkingSessionsSessionIdDelete', () async {
      // TODO
    });

    //Future<LinkSessionDto> apiLinkingSessionsSessionIdGet(String sessionId) async
    test('test apiLinkingSessionsSessionIdGet', () async {
      // TODO
    });

    //Future<LinkSessionDto> apiLinkingSessionsSessionIdSubmitPost(String sessionId, SubmitLinkRequest submitLinkRequest) async
    test('test apiLinkingSessionsSessionIdSubmitPost', () async {
      // TODO
    });

  });
}
