import 'package:dio/dio.dart';

import '../config/backend_config.dart';
import 'update/required_update_service.dart';

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
      final version = RequiredUpdateService.instance.headerValue;
      if (version.isNotEmpty) options.headers[appVersionHeader] = version;
      handler.next(options);
    },
    // A 426 "update required" from any backend call shows the update screen.
    onResponse: (response, handler) {
      RequiredUpdateService.instance.report(response.statusCode, response.data);
      handler.next(response);
    },
    onError: (e, handler) {
      RequiredUpdateService.instance.report(e.response?.statusCode, e.response?.data);
      handler.next(e);
    },
  ));
  return dio;
}
