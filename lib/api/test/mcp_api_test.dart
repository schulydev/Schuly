import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for McpApi
void main() {
  final instance = SchulyApi().getMcpApi();

  group(McpApi, () {
    //Future<McpAuthorizationDecisionDto> apiMcpAuthorizationDecisionPost(DecideMcpAuthorizationCommand decideMcpAuthorizationCommand) async
    test('test apiMcpAuthorizationDecisionPost', () async {
      // TODO
    });

    //Future<McpAuthorizationRequestDto> apiMcpAuthorizationRequestPost(McpAuthorizationParameters mcpAuthorizationParameters) async
    test('test apiMcpAuthorizationRequestPost', () async {
      // TODO
    });

    //Future<BuiltList<McpConnectionDto>> apiMcpConnectionsGet() async
    test('test apiMcpConnectionsGet', () async {
      // TODO
    });

    //Future<BuiltList<McpActivityDto>> apiMcpConnectionsIdActivityGet(String id) async
    test('test apiMcpConnectionsIdActivityGet', () async {
      // TODO
    });

    //Future apiMcpConnectionsIdDelete(String id) async
    test('test apiMcpConnectionsIdDelete', () async {
      // TODO
    });

    //Future<McpConnectionDto> apiMcpConnectionsIdPermissionsPut(String id, McpPermissionSet mcpPermissionSet) async
    test('test apiMcpConnectionsIdPermissionsPut', () async {
      // TODO
    });

    //Future<BuiltList<McpApiKeyDto>> apiMcpKeysGet() async
    test('test apiMcpKeysGet', () async {
      // TODO
    });

    //Future<BuiltList<McpActivityDto>> apiMcpKeysIdActivityGet(String id) async
    test('test apiMcpKeysIdActivityGet', () async {
      // TODO
    });

    //Future apiMcpKeysIdDelete(String id) async
    test('test apiMcpKeysIdDelete', () async {
      // TODO
    });

    //Future<McpApiKeyDto> apiMcpKeysIdPermissionsPut(String id, McpPermissionSet mcpPermissionSet) async
    test('test apiMcpKeysIdPermissionsPut', () async {
      // TODO
    });

    //Future<CreatedMcpApiKeyDto> apiMcpKeysPost(CreateMcpApiKeyCommand createMcpApiKeyCommand) async
    test('test apiMcpKeysPost', () async {
      // TODO
    });

  });
}
