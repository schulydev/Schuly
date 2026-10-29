import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_error.dart';

/// A feature a provider's linked accounts unlock (`mail`, `calendar`, `absence_reporting`, ...),
/// served by the plugin at [basePath].
class LinkCapability {
  final String kind;
  final String label;
  final String? icon;
  final String? basePath;
  const LinkCapability({required this.kind, required this.label, this.icon, this.basePath});

  factory LinkCapability.fromJson(Map<String, dynamic> j) => LinkCapability(kind: j['kind'] as String? ?? '', label: j['label'] as String? ?? '', icon: j['icon'] as String?, basePath: j['basePath'] as String?);
}

class LinkFlow {
  final String id;
  final String label;
  final String? description;
  const LinkFlow({required this.id, required this.label, this.description});

  factory LinkFlow.fromJson(Map<String, dynamic> j) => LinkFlow(id: j['id'] as String, label: j['label'] as String? ?? '', description: j['description'] as String?);
}

class LinkProvider {
  final String id;
  final String displayName;
  final String? description;
  final String? lucide;
  final String? svgUrl;
  final List<LinkCapability> capabilities;
  final List<LinkFlow> flows;
  final int sortOrder;
  const LinkProvider({required this.id, required this.displayName, this.description, this.lucide, this.svgUrl, this.capabilities = const [], this.flows = const [], this.sortOrder = 0});

  factory LinkProvider.fromJson(Map<String, dynamic> j) {
    final icon = j['icon'] as Map<String, dynamic>?;
    return LinkProvider(
      id: j['id'] as String,
      displayName: j['displayName'] as String? ?? j['id'] as String,
      description: j['description'] as String?,
      lucide: icon?['lucide'] as String?,
      svgUrl: icon?['svgUrl'] as String?,
      capabilities: [for (final c in j['capabilities'] as List<dynamic>? ?? const []) LinkCapability.fromJson(c as Map<String, dynamic>)],
      flows: [for (final f in j['flows'] as List<dynamic>? ?? const []) LinkFlow.fromJson(f as Map<String, dynamic>)],
      sortOrder: j['sortOrder'] as int? ?? 0,
    );
  }
}

enum LinkedAccountStatus { ok, syncing, expired, error }

/// An account the user linked, whichever provider it belongs to.
class LinkedAccount {
  final String providerId;
  final String providerName;
  final String id;
  final String title;
  final String? detail;
  final LinkedAccountStatus status;
  final String? message;
  final DateTime? linkedAt;
  final DateTime? lastSyncedAt;
  final List<LinkCapability> capabilities;
  final bool canReauth;
  const LinkedAccount({required this.providerId, required this.providerName, required this.id, required this.title, this.detail, this.status = LinkedAccountStatus.ok, this.message, this.linkedAt, this.lastSyncedAt, this.capabilities = const [], this.canReauth = false});

  factory LinkedAccount.fromJson(Map<String, dynamic> j) => LinkedAccount(
        providerId: j['providerId'] as String,
        providerName: j['providerName'] as String? ?? j['providerId'] as String,
        id: j['id'].toString(),
        title: j['title'] as String? ?? '',
        detail: j['detail'] as String?,
        status: switch (j['status']) {
          'syncing' => LinkedAccountStatus.syncing,
          'expired' => LinkedAccountStatus.expired,
          'error' => LinkedAccountStatus.error,
          _ => LinkedAccountStatus.ok,
        },
        message: j['message'] as String?,
        linkedAt: DateTime.tryParse(j['linkedAt'] as String? ?? ''),
        lastSyncedAt: DateTime.tryParse(j['lastSyncedAt'] as String? ?? ''),
        capabilities: [for (final c in j['capabilities'] as List<dynamic>? ?? const []) LinkCapability.fromJson(c as Map<String, dynamic>)],
        canReauth: j['canReauth'] as bool? ?? false,
      );

  bool hasCapability(String kind) => capabilities.any((c) => c.kind == kind);

  LinkCapability? capability(String kind) {
    for (final c in capabilities) {
      if (c.kind == kind) return c;
    }
    return null;
  }

  /// Provider-qualified identity: two providers may reuse an account id.
  String get key => '$providerId/$id';
}

enum LinkStepKind { form, otp, pushCode, deviceCode, redirect, select, done, error }

enum LinkFieldType { text, email, password, select, url, totpSecret }

class LinkOption {
  final String value;
  final String label;
  final String? detail;
  final String? icon;

  /// Picking this option means "link an account at that provider first", then refresh this step.
  final String? linkProviderId;
  const LinkOption({required this.value, required this.label, this.detail, this.icon, this.linkProviderId});

  factory LinkOption.fromJson(Map<String, dynamic> j) => LinkOption(value: j['value']?.toString() ?? '', label: j['label'] as String? ?? '', detail: j['detail'] as String?, icon: j['icon'] as String?, linkProviderId: j['linkProviderId'] as String?);
}

class LinkField {
  final String key;
  final String label;
  final LinkFieldType type;
  final String? placeholder;
  final String? help;
  final String? defaultValue;
  final bool required;
  final bool secret;
  final int? maxLength;
  final List<LinkOption> options;
  final bool allowCustom;
  const LinkField({required this.key, required this.label, this.type = LinkFieldType.text, this.placeholder, this.help, this.defaultValue, this.required = true, this.secret = false, this.maxLength, this.options = const [], this.allowCustom = false});

  factory LinkField.fromJson(Map<String, dynamic> j) => LinkField(
        key: j['key'] as String,
        label: j['label'] as String? ?? j['key'] as String,
        type: switch (j['type']) {
          'email' => LinkFieldType.email,
          'password' => LinkFieldType.password,
          'select' => LinkFieldType.select,
          'url' => LinkFieldType.url,
          'totpSecret' => LinkFieldType.totpSecret,
          _ => LinkFieldType.text,
        },
        placeholder: j['placeholder'] as String?,
        help: j['help'] as String?,
        defaultValue: j['defaultValue'] as String?,
        required: j['required'] as bool? ?? true,
        secret: j['secret'] as bool? ?? false,
        maxLength: j['maxLength'] as int?,
        options: [for (final o in j['options'] as List<dynamic>? ?? const []) LinkOption.fromJson(o as Map<String, dynamic>)],
        allowCustom: j['allowCustom'] as bool? ?? false,
      );
}

class LinkAction {
  final String id;
  final String label;
  const LinkAction({required this.id, required this.label});
}

class LinkRedirect {
  final String url;

  /// True for `capture` (embedded browser); false for `hostCallback` (open externally).
  final bool capture;
  final String? callbackPrefix;
  final List<String> captureCookieDomains;
  const LinkRedirect({required this.url, required this.capture, this.callbackPrefix, this.captureCookieDomains = const []});
}

class LinkStep {
  final String id;
  final LinkStepKind kind;
  final String? title;
  final String? description;
  final String? error;
  final List<LinkField> fields;
  final int otpLength;
  final String? otpLabel;
  final bool otpNumericOnly;
  final String? pushNumber;
  final String? deviceUserCode;
  final String? deviceVerificationUri;
  final DateTime? expiresAt;
  final int pollIntervalSeconds;
  final LinkRedirect? redirect;
  final List<LinkOption> options;
  final List<LinkAction> actions;
  final String? submitLabel;
  final String? doneAccountId;
  final String? doneTitle;

  const LinkStep({
    required this.id,
    required this.kind,
    this.title,
    this.description,
    this.error,
    this.fields = const [],
    this.otpLength = 6,
    this.otpLabel,
    this.otpNumericOnly = true,
    this.pushNumber,
    this.deviceUserCode,
    this.deviceVerificationUri,
    this.expiresAt,
    this.pollIntervalSeconds = 3,
    this.redirect,
    this.options = const [],
    this.actions = const [],
    this.submitLabel,
    this.doneAccountId,
    this.doneTitle,
  });

  factory LinkStep.fromJson(Map<String, dynamic> j) {
    final otp = j['otp'] as Map<String, dynamic>?;
    final push = j['pushCode'] as Map<String, dynamic>?;
    final device = j['deviceCode'] as Map<String, dynamic>?;
    final redirect = j['redirect'] as Map<String, dynamic>?;
    final done = j['done'] as Map<String, dynamic>?;
    final timing = push ?? device;
    return LinkStep(
      id: j['id'] as String? ?? '',
      kind: switch (j['kind']) {
        'otp' => LinkStepKind.otp,
        'pushCode' => LinkStepKind.pushCode,
        'deviceCode' => LinkStepKind.deviceCode,
        'redirect' => LinkStepKind.redirect,
        'select' => LinkStepKind.select,
        'done' => LinkStepKind.done,
        'error' => LinkStepKind.error,
        _ => LinkStepKind.form,
      },
      title: j['title'] as String?,
      description: j['description'] as String?,
      error: j['error'] as String?,
      fields: [for (final f in j['fields'] as List<dynamic>? ?? const []) LinkField.fromJson(f as Map<String, dynamic>)],
      otpLength: otp?['length'] as int? ?? 6,
      otpLabel: otp?['label'] as String?,
      otpNumericOnly: otp?['numericOnly'] as bool? ?? true,
      pushNumber: push?['number']?.toString(),
      deviceUserCode: device?['userCode'] as String?,
      deviceVerificationUri: device?['verificationUri'] as String?,
      expiresAt: DateTime.tryParse(timing?['expiresAt'] as String? ?? ''),
      pollIntervalSeconds: (timing?['pollIntervalSeconds'] as int?) ?? 3,
      redirect: redirect == null
          ? null
          : LinkRedirect(
              url: redirect['url'] as String,
              capture: redirect['mode'] == 'capture',
              callbackPrefix: redirect['callbackPrefix'] as String?,
              captureCookieDomains: [for (final d in redirect['captureCookieDomains'] as List<dynamic>? ?? const []) d.toString()],
            ),
      options: [for (final o in j['options'] as List<dynamic>? ?? const []) LinkOption.fromJson(o as Map<String, dynamic>)],
      actions: [for (final a in j['actions'] as List<dynamic>? ?? const []) LinkAction(id: (a as Map<String, dynamic>)['id'] as String, label: a['label'] as String? ?? '')],
      submitLabel: j['submitLabel'] as String?,
      doneAccountId: done?['accountId']?.toString(),
      doneTitle: done?['title'] as String?,
    );
  }
}

enum LinkSessionStatus { active, done, failed, expired }

class LinkSession {
  final String sessionId;
  final String providerId;
  final String flowId;
  final LinkSessionStatus status;
  final LinkStep step;
  const LinkSession({required this.sessionId, required this.providerId, required this.flowId, required this.status, required this.step});

  factory LinkSession.fromJson(Map<String, dynamic> j) => LinkSession(
        sessionId: j['sessionId'].toString(),
        providerId: j['providerId'] as String? ?? '',
        flowId: j['flowId'] as String? ?? '',
        status: switch (j['status']) {
          'done' => LinkSessionStatus.done,
          'failed' => LinkSessionStatus.failed,
          'expired' => LinkSessionStatus.expired,
          _ => LinkSessionStatus.active,
        },
        step: LinkStep.fromJson(j['step'] as Map<String, dynamic>),
      );
}

/// A failed linking call, carrying the server's own wording.
class LinkingException implements Exception {
  final String message;
  const LinkingException(this.message);

  @override
  String toString() => message;
}

/// The linking HTTP surface. The UI only talks to this, so tests swap in a fake.
abstract class LinkingApi {
  Future<List<LinkProvider>> providers({String platform = 'mobile'});
  Future<List<LinkedAccount>> accounts();
  Future<LinkSession> start(String providerId, {String? flowId, String? reauthAccountId});
  Future<LinkSession> submit(String sessionId, String stepId, Map<String, String> values, {String? action});
  Future<LinkSession> poll(String sessionId);
  Future<void> cancel(String sessionId);
  Future<void> unlink(String providerId, String accountId);
}

/// [LinkingApi] over the authenticated app client (`/api/linking/*`).
class HttpLinkingApi implements LinkingApi {
  HttpLinkingApi([Dio? dio]) : _dio = dio;

  final Dio? _dio;

  Dio get _client => _dio ?? ApiClient.instance.dio;

  Future<T> _run<T>(Future<Response<dynamic>> Function(Dio dio) call, T Function(Object? data) parse) async {
    try {
      final res = await call(_client);
      return parse(res.data);
    } on DioException catch (e) {
      throw LinkingException(ApiError.describe(e));
    }
  }

  @override
  Future<List<LinkProvider>> providers({String platform = 'mobile'}) => _run((d) => d.get<dynamic>('/api/linking/providers', queryParameters: {'platform': platform}, options: ApiClient.handled()), (data) => [for (final p in data as List<dynamic>) LinkProvider.fromJson(p as Map<String, dynamic>)]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)));

  @override
  Future<List<LinkedAccount>> accounts() => _run((d) => d.get<dynamic>('/api/linking/accounts', options: ApiClient.handled()), (data) => [for (final a in data as List<dynamic>) LinkedAccount.fromJson(a as Map<String, dynamic>)]);

  @override
  Future<LinkSession> start(String providerId, {String? flowId, String? reauthAccountId}) => _run(
        (d) => d.post<dynamic>('/api/linking/providers/$providerId/start', data: {'flowId': ?flowId, 'platform': 'mobile', 'reauthAccountId': ?reauthAccountId}, options: ApiClient.handled()),
        (data) => LinkSession.fromJson(data as Map<String, dynamic>),
      );

  @override
  Future<LinkSession> submit(String sessionId, String stepId, Map<String, String> values, {String? action}) => _run(
        (d) => d.post<dynamic>('/api/linking/sessions/$sessionId/submit', data: {'stepId': stepId, 'values': values, 'action': ?action}, options: ApiClient.handled()),
        (data) => LinkSession.fromJson(data as Map<String, dynamic>),
      );

  @override
  Future<LinkSession> poll(String sessionId) => _run((d) => d.get<dynamic>('/api/linking/sessions/$sessionId', options: ApiClient.handled()), (data) => LinkSession.fromJson(data as Map<String, dynamic>));

  @override
  Future<void> cancel(String sessionId) => _run((d) => d.delete<dynamic>('/api/linking/sessions/$sessionId', options: ApiClient.handled()), (_) {});

  @override
  Future<void> unlink(String providerId, String accountId) => _run((d) => d.delete<dynamic>('/api/linking/accounts/$providerId/$accountId', options: ApiClient.handled()), (_) {});
}
