//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_collection/built_collection.dart';
import 'package:schuly_api/src/api_util.dart';
import 'package:schuly_api/src/model/error_response.dart';
import 'package:schuly_api/src/model/external_link_response.dart';
import 'package:schuly_api/src/model/external_login_exchange_request.dart';
import 'package:schuly_api/src/model/external_login_response.dart';
import 'package:schuly_api/src/model/external_provider_response.dart';
import 'package:schuly_api/src/model/link_external_login_request.dart';
import 'package:schuly_api/src/model/two_factor_challenge_response.dart';
import 'package:schuly_api/src/model/unlink_external_login_request.dart';
import 'package:schuly_api/src/model/validation_error_response.dart';

class ExternalLoginApi {

  final Dio _dio;

  final Serializers _serializers;

  const ExternalLoginApi(this._dio, this._serializers);

  /// Where the provider sends the browser back. Register this address with the provider.
  /// Not for clients to call. Redirects to the &#x60;returnUrl&#x60; the sign-in began with; answers 400 only when the answer belongs to no sign-in begun here, since then there is nowhere safe to send it.
  ///
  /// Parameters:
  /// * [provider] 
  /// * [code] 
  /// * [state] 
  /// * [error] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> toamaisutaaExternalCallback({ 
    required String provider,
    String? code,
    String? state,
    String? error,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/{provider}/callback'.replaceAll('{' r'provider' '}', encodeQueryParameter(_serializers, provider, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (code != null) r'code': encodeQueryParameter(_serializers, code, const FullType(String)),
      if (state != null) r'state': encodeQueryParameter(_serializers, state, const FullType(String)),
      if (error != null) r'error': encodeQueryParameter(_serializers, error, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// Exchanges the code a provider sign-in returned for tokens.
  /// Send &#x60;{ \&quot;code\&quot;: \&quot;...\&quot;, \&quot;codeVerifier\&quot;: \&quot;...\&quot; }&#x60;. Returns the same two shapes &#x60;/auth/login&#x60; does: tokens with &#x60;fed&#x60; in &#x60;amr&#x60;, or a second-factor challenge for &#x60;/auth/2fa/verify&#x60;. A code is spent by the first attempt, right verifier or not.
  ///
  /// Parameters:
  /// * [externalLoginExchangeRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [TwoFactorChallengeResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<TwoFactorChallengeResponse>> toamaisutaaExternalExchange({ 
    required ExternalLoginExchangeRequest externalLoginExchangeRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/exchange';
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(ExternalLoginExchangeRequest);
      _bodyData = _serializers.serialize(externalLoginExchangeRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    TwoFactorChallengeResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(TwoFactorChallengeResponse),
      ) as TwoFactorChallengeResponse;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<TwoFactorChallengeResponse>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Starts linking a provider to the caller&#39;s account.
  /// Send &#x60;returnUrl&#x60; and the proof passkey registration takes: &#x60;code&#x60; where the account has a second factor, &#x60;currentPassword&#x60; where it has a password, otherwise nothing beyond a sign-in within &#x60;ExternalLogin:LinkProofWindow&#x60;. Navigate the browser to &#x60;authorization_url&#x60;; it comes back to &#x60;returnUrl&#x60; with &#x60;linked&#x60;, or &#x60;error&#x60;: &#x60;linked_to_another_account&#x60;, &#x60;provider_already_linked&#x60; or &#x60;external_login_failed&#x60;.
  ///
  /// Parameters:
  /// * [provider] 
  /// * [linkExternalLoginRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [ExternalLinkResponse] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<ExternalLinkResponse>> toamaisutaaExternalLink({ 
    required String provider,
    required LinkExternalLoginRequest linkExternalLoginRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/{provider}/link'.replaceAll('{' r'provider' '}', encodeQueryParameter(_serializers, provider, const FullType(String)).toString());
    final _options = Options(
      method: r'POST',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(LinkExternalLoginRequest);
      _bodyData = _serializers.serialize(linkExternalLoginRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    ExternalLinkResponse? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(ExternalLinkResponse),
      ) as ExternalLinkResponse;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<ExternalLinkResponse>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Lists the providers linked to the caller&#39;s account.
  /// 
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BuiltList<ExternalLoginResponse>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BuiltList<ExternalLoginResponse>>> toamaisutaaExternalLogins({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/logins';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BuiltList<ExternalLoginResponse>? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(BuiltList, [FullType(ExternalLoginResponse)]),
      ) as BuiltList<ExternalLoginResponse>;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BuiltList<ExternalLoginResponse>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Lists the identity providers a user can sign in with.
  /// Anonymous, so a sign-in page can draw a button per entry. &#x60;key&#x60; is what the other routes take.
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BuiltList<ExternalProviderResponse>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BuiltList<ExternalProviderResponse>>> toamaisutaaExternalProviders({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/providers';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BuiltList<ExternalProviderResponse>? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(BuiltList, [FullType(ExternalProviderResponse)]),
      ) as BuiltList<ExternalProviderResponse>;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BuiltList<ExternalProviderResponse>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Sends the browser to a provider to sign in.
  /// Navigate here, do not fetch it. Query: &#x60;returnUrl&#x60;, exactly one of &#x60;ExternalLogin:AllowedReturnUrls&#x60;; &#x60;codeChallenge&#x60;, the base64url SHA-256 of a random verifier the client keeps; &#x60;codeChallengeMethod&#x3D;S256&#x60;; and optionally &#x60;state&#x60;, handed back untouched.  The browser comes back to &#x60;returnUrl&#x60; with &#x60;code&#x60;, to exchange at &#x60;/exchange&#x60; with the verifier, or with &#x60;error&#x60;: &#x60;access_denied&#x60;, &#x60;account_exists&#x60;, &#x60;account_not_found&#x60; or &#x60;external_login_failed&#x60;.
  ///
  /// Parameters:
  /// * [provider] 
  /// * [returnUrl] 
  /// * [codeChallenge] 
  /// * [codeChallengeMethod] 
  /// * [state] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> toamaisutaaExternalStart({ 
    required String provider,
    String? returnUrl,
    String? codeChallenge,
    String? codeChallengeMethod,
    String? state,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/{provider}/start'.replaceAll('{' r'provider' '}', encodeQueryParameter(_serializers, provider, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (returnUrl != null) r'returnUrl': encodeQueryParameter(_serializers, returnUrl, const FullType(String)),
      if (codeChallenge != null) r'codeChallenge': encodeQueryParameter(_serializers, codeChallenge, const FullType(String)),
      if (codeChallengeMethod != null) r'codeChallengeMethod': encodeQueryParameter(_serializers, codeChallengeMethod, const FullType(String)),
      if (state != null) r'state': encodeQueryParameter(_serializers, state, const FullType(String)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

  /// Unlinks a provider. Takes the same proof linking does.
  /// Refused with 400 when it is the account&#39;s only way to sign in. Unlinking ends every session on the account, this one included, since the usual reason to remove a provider is that somebody else linked it.
  ///
  /// Parameters:
  /// * [provider] 
  /// * [unlinkExternalLoginRequest] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> toamaisutaaExternalUnlink({ 
    required String provider,
    UnlinkExternalLoginRequest? unlinkExternalLoginRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/auth/external/logins/{provider}'.replaceAll('{' r'provider' '}', encodeQueryParameter(_serializers, provider, const FullType(String)).toString());
    final _options = Options(
      method: r'DELETE',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(UnlinkExternalLoginRequest);
      _bodyData = unlinkExternalLoginRequest == null ? null : _serializers.serialize(unlinkExternalLoginRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

}
