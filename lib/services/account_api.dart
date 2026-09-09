import 'package:dio/dio.dart';

import 'api_client.dart';

/// Hand-written calls for the account deletion / data export endpoints
/// (SchulyBackend#274) - not yet in the generated OpenAPI client. Move these
/// onto `ApiClient.instance.api` once the backend PR merges and `bun run
/// apigen` regenerates `lib/api/` from the live spec.
class AccountApi {
  AccountApi._();

  /// `DELETE /api/auth/me` - permanently deletes the signed-in user's account
  /// and server-side data. Resolves on `204 No Content`.
  static Future<void> deleteAccount() {
    return ApiClient.instance.dio.delete<void>('/api/auth/me', options: ApiClient.handled());
  }

  /// `GET /api/auth/me/export` - the account's data as a JSON attachment.
  static Future<List<int>> exportData() async {
    final res = await ApiClient.instance.dio.get<List<int>>(
      '/api/auth/me/export',
      options: ApiClient.handled(Options(responseType: ResponseType.bytes)),
    );
    return res.data ?? const [];
  }
}
