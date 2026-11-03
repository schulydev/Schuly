import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for HelplyApi
void main() {
  final instance = SchulyApi().getHelplyApi();

  group(HelplyApi, () {
    //Future apiHelplyConversationsDelete() async
    test('test apiHelplyConversationsDelete', () async {
      // TODO
    });

    //Future<BuiltList<HelplyConversationSummaryDto>> apiHelplyConversationsGet() async
    test('test apiHelplyConversationsGet', () async {
      // TODO
    });

    //Future apiHelplyConversationsIdApprovalsPost(String id, AnswerHelplyApprovalsRequest answerHelplyApprovalsRequest) async
    test('test apiHelplyConversationsIdApprovalsPost', () async {
      // TODO
    });

    //Future apiHelplyConversationsIdAttachmentsAttachmentIdDelete(String id, String attachmentId) async
    test('test apiHelplyConversationsIdAttachmentsAttachmentIdDelete', () async {
      // TODO
    });

    //Future<FileContentResult> apiHelplyConversationsIdAttachmentsAttachmentIdGet(String id, String attachmentId) async
    test('test apiHelplyConversationsIdAttachmentsAttachmentIdGet', () async {
      // TODO
    });

    //Future<HelplyAttachmentDto> apiHelplyConversationsIdAttachmentsPost(String id, { MultipartFile file }) async
    test('test apiHelplyConversationsIdAttachmentsPost', () async {
      // TODO
    });

    //Future apiHelplyConversationsIdDelete(String id) async
    test('test apiHelplyConversationsIdDelete', () async {
      // TODO
    });

    //Future<HelplyConversationDto> apiHelplyConversationsIdGet(String id) async
    test('test apiHelplyConversationsIdGet', () async {
      // TODO
    });

    //Future apiHelplyConversationsIdMessagesPost(String id, SendHelplyMessageRequest sendHelplyMessageRequest) async
    test('test apiHelplyConversationsIdMessagesPost', () async {
      // TODO
    });

    //Future<HelplyConversationSummaryDto> apiHelplyConversationsIdPatch(String id, RenameHelplyConversationRequest renameHelplyConversationRequest) async
    test('test apiHelplyConversationsIdPatch', () async {
      // TODO
    });

    //Future apiHelplyConversationsIdRetryPost(String id) async
    test('test apiHelplyConversationsIdRetryPost', () async {
      // TODO
    });

    //Future<HelplyConversationSummaryDto> apiHelplyConversationsPost({ CreateHelplyConversationRequest createHelplyConversationRequest }) async
    test('test apiHelplyConversationsPost', () async {
      // TODO
    });

    //Future<HelplySettingsDto> apiHelplySettingsGet() async
    test('test apiHelplySettingsGet', () async {
      // TODO
    });

    //Future<HelplySettingsDto> apiHelplySettingsPermissionsPut(McpPermissionSet mcpPermissionSet) async
    test('test apiHelplySettingsPermissionsPut', () async {
      // TODO
    });

    //Future<HelplySettingsDto> apiHelplySettingsWorkspacePut(UpdateHelplyWorkspaceRequest updateHelplyWorkspaceRequest) async
    test('test apiHelplySettingsWorkspacePut', () async {
      // TODO
    });

    //Future<HelplyStatusDto> apiHelplyStatusGet() async
    test('test apiHelplyStatusGet', () async {
      // TODO
    });

  });
}
