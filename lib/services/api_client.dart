import 'package:dio/dio.dart';
import 'package:schuly_api/schuly_api.dart';

import 'auth_service.dart';
import 'backend_dio.dart';
import 'toast_service.dart';

const _retried = '_retried';

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
            if (e.response?.statusCode != 401) {
              _toastHttpError(e);
              return handler.next(e);
            }
            // A 401 on the retry means the freshly minted access token was still
            // refused - the session itself is gone, not just the old token.
            if (options.extra[_retried] == true) {
              await _endExpiredSession();
              return handler.next(e);
            }
            final refresh = await _refresh();
            final newToken = refresh.accessToken;
            if (newToken != null) {
              options.extra[_retried] = true;
              options.headers['Authorization'] = 'Bearer $newToken';
              try {
                return handler.resolve(await _dio.fetch(options));
              } on DioException catch (retryError) {
                // The nested interceptor pass already reported this failure.
                return handler.next(retryError);
              }
            }
            if (refresh.failure == AuthFailure.transport) {
              _toastNetworkError(e);
              return handler.next(e);
            }
            await _endExpiredSession();
            return handler.next(e);
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

  Future<AuthRefresh>? _refreshing;

  Future<AuthRefresh> _refresh() {
    return _refreshing ??=
        AuthService.refreshAccessToken().whenComplete(() => _refreshing = null);
  }
}

/// The session is over. Sign out locally - the browser logout page would be a
/// jarring detour out of the app for something the user didn't ask for - and let
/// RootScreen react to `sessionEpoch`. Only the call that actually ended the
/// session toasts, so N concurrent 401s produce one message.
Future<void> _endExpiredSession() async {
  if (await AuthService.signOut(endSession: false)) {
    ToastService.error('Session expired', 'Please sign in again.');
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

void _toastNetworkError(DioException e) {
  if (e.requestOptions.extra[ApiClient.handlesErrors] == true) return;
  ToastService.error('Network error', "Couldn't reach the server. Please try again.");
}
