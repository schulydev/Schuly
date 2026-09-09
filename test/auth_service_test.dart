import 'dart:async';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/auth_service.dart';

FlutterAppAuthPlatformException _platformError(String? error) => FlutterAppAuthPlatformException(
      code: 'token_failed',
      platformErrorDetails: FlutterAppAuthPlatformErrorDetails(error: error),
    );

void main() {
  group('AuthService.classifyRefreshError', () {
    test('invalid_grant is an auth failure', () {
      expect(AuthService.classifyRefreshError(_platformError('invalid_grant')), AuthFailure.auth);
    });

    test('invalid_client is an auth failure', () {
      expect(AuthService.classifyRefreshError(_platformError('invalid_client')), AuthFailure.auth);
    });

    test('a non-OAuth platform error is a transport failure', () {
      expect(AuthService.classifyRefreshError(_platformError('Network error')), AuthFailure.transport);
    });

    test('a platform error with no error code is a transport failure', () {
      expect(AuthService.classifyRefreshError(_platformError(null)), AuthFailure.transport);
    });

    test('a plain exception is a transport failure', () {
      expect(AuthService.classifyRefreshError(Exception('boom')), AuthFailure.transport);
    });

    test('a timeout is a transport failure', () {
      expect(AuthService.classifyRefreshError(TimeoutException('timed out')), AuthFailure.transport);
    });
  });
}
