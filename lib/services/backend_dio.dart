import 'package:dio/dio.dart';

import '../config/backend_config.dart';

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
