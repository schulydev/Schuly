import 'dart:async';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import '../../../config/backend_config.dart';
import '../../../services/api_client.dart';

/// True when [url] points at the Schuly server, whose images are only fetched with the signed-in account's token.
bool isBackendUrl(String url) {
  final host = Uri.tryParse(url)?.host;
  final backend = Uri.tryParse(BackendConfig.url)?.host;
  return host != null && host.isNotEmpty && host == backend;
}

final Dio _plain = Dio(BaseOptions(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 30)));
final Map<String, Future<Uint8List>> _bytes = {};

/// The bytes of an image. A Schuly server image (`/api/avatars/...`, which answers 401 without a token) goes through
/// [ApiClient], which sends the bearer token and renews it, so no picture is ever fetched anonymously; a `data:` URL is
/// decoded in place, and an external https URL is a plain GET. Kept per URL for the session: the server changes the
/// `?v=` hash when a picture changes. A failure (401, 404, offline) is forgotten so a later build tries again, and the
/// widgets show initials meanwhile.
Future<Uint8List> fetchImageBytes(String url) => _bytes.putIfAbsent(url, () async {
      // A picture the server inlines as a data URL needs no request at all.
      if (url.startsWith('data:')) return UriData.parse(url).contentAsBytes();
      try {
        final options = Options(responseType: ResponseType.bytes);
        final res = isBackendUrl(url) ? await ApiClient.instance.dio.get<List<int>>(url, options: ApiClient.handled(options)) : await _plain.get<List<int>>(url, options: options);
        final data = res.data;
        if (data == null || data.isEmpty) throw StateError('empty image');
        return Uint8List.fromList(data);
      } catch (_) {
        _bytes.remove(url)?.ignore();
        rethrow;
      }
    });

/// Forgets every fetched image, after a picture changed on the server.
void clearFetchedImages() {
  _bytes.clear();
  PaintingBinding.instance.imageCache.clear();
}

/// An [ImageProvider] for [fetchImageBytes]: use it instead of `NetworkImage` for anything the server serves.
@immutable
class AuthImage extends ImageProvider<AuthImage> {
  const AuthImage(this.url);

  final String url;

  @override
  Future<AuthImage> obtainKey(ImageConfiguration configuration) => SynchronousFuture(this);

  @override
  ImageStreamCompleter loadImage(AuthImage key, ImageDecoderCallback decode) => MultiFrameImageStreamCompleter(codec: _load(decode), scale: 1, debugLabel: url);

  Future<ui.Codec> _load(ImageDecoderCallback decode) async {
    final bytes = await fetchImageBytes(url);
    return decode(await ui.ImmutableBuffer.fromUint8List(bytes));
  }

  @override
  bool operator ==(Object other) => other is AuthImage && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
