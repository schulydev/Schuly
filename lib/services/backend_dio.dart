import 'package:dio/dio.dart';

import '../config/backend_config.dart';

/// Builds a [Dio] whose base URL always tracks [BackendConfig.url]: an interceptor
/// re-points it on every request, so a runtime backend change (Settings -> Server)
/// takes effect immediately - no per-client `applyBaseUrl()` bookkeeping.
Dio backendDio({Duration? connectTimeout, Duration? receiveTimeout, Duration? sendTimeout}) {
  final dio = Dio(BaseOptions(
    baseUrl: BackendConfig.url,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    sendTimeout: sendTimeout,
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      options.baseUrl = BackendConfig.url;
      handler.next(options);
    },
  ));
  return dio;
}
