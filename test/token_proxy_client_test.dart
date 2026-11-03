import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/private_account_store.dart';
import 'package:schuly/services/token_proxy_client.dart';

class _FakeServer implements HttpClientAdapter {
  _FakeServer(this.statusFor);

  final int Function(String path) statusFor;
  final List<String> requested = [];

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requested.add(options.path);
    final status = statusFor(options.path);
    final body = options.path.endsWith('/userinfo') ? '{"firstName":"A"}' : (options.path.endsWith('/grades') ? '[{"id":"g1","score":5}]' : '[]');
    return ResponseBody.fromString(status == 200 ? body : jsonEncode({'code': 'failed'}), status, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  const account = PrivateAccount(systemKey: 's', loginMethod: 'm', baseUrl: 'https://school.example', displayName: 'School', statelessBasePath: '/stateless', accessToken: 'token');

  TokenProxyClient client(_FakeServer server) => TokenProxyClient.withDio(Dio(BaseOptions(baseUrl: 'https://backend.example'))..httpClientAdapter = server);

  test('a section the school fails to answer does not cost the others', () async {
    final server = _FakeServer((path) => path.endsWith('/absences') ? 502 : 200);
    final data = await client(server).fetchAll(account);
    expect(data.grades, hasLength(1));
    expect(data.userInfo?.firstName, 'A');
    expect(data.absences, isEmpty);
    expect(data.failedSections, 1);
  });

  test('a full answer reports no failed section', () async {
    final data = await client(_FakeServer((_) => 200)).fetchAll(account);
    expect(data.failedSections, 0);
  });

  test('nothing answering at all is an error', () async {
    expect(client(_FakeServer((_) => 502)).fetchAll(account), throwsA(isA<DioException>()));
  });
}
