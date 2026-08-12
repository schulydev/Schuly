import 'package:dio/dio.dart';
import 'package:schuly_api/schuly_api.dart';

import 'auth_service.dart';
import 'backend_dio.dart';
import 'toast_service.dart';

class ApiClient {
  ApiClient._() {
    _dio = backendDio(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 30),
    );
    api = SchulyApi(
      dio: _dio,
      interceptors: [
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final token = await AuthService.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
          onError: (e, handler) async {
            final options = e.requestOptions;
            if (e.response?.statusCode == 401 && options.extra['_retried'] != true) {
              final newToken = await _refresh();
              if (newToken != null) {
                options.extra['_retried'] = true;
                options.headers['Authorization'] = 'Bearer $newToken';
                try {
                  return handler.resolve(await _dio.fetch(options));
                } on DioException catch (retryError) {
                  _toastHttpError(retryError);
                  return handler.next(retryError);
                }
              }
              ToastService.error('Session expired', 'Please sign in again.');
              await AuthService.signOut();
              return handler.next(e);
            }
            _toastHttpError(e);
            handler.next(e);
          },
        ),
      ],
    );
  }

  static final ApiClient instance = ApiClient._();

  /// Mark a request whose failure the caller renders itself, so the global
  /// interceptor stays quiet instead of adding a second, vaguer message:
  /// `Options(extra: {ApiClient.handlesErrors: true})`.
  static const handlesErrors = '_handlesErrors';

  /// Convenience for the above.
  static Options handled([Options? options]) =>
      (options ?? Options()).copyWith(extra: {...?options?.extra, handlesErrors: true});

  late final Dio _dio;
  late final SchulyApi api;

  Dio get dio => _dio;

  Future<String?>? _refreshing;

  Future<String?> _refresh() {
    return _refreshing ??=
        AuthService.refreshAccessToken().whenComplete(() => _refreshing = null);
  }
}

void _toastHttpError(DioException e) {
  // The caller is showing this failure itself, with the server's own wording.
  // Toasting "Request failed (400)" on top of that adds a second, vaguer copy.
  if (e.requestOptions.extra[ApiClient.handlesErrors] == true) return;

  final code = e.response?.statusCode;
  if (code != null) {
    ToastService.error('Request failed ($code)', e);
  } else {
    ToastService.error('Network error', "Couldn't reach the server.");
  }
}
