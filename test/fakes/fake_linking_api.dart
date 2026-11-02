import 'package:schuly/services/linking_service.dart';

/// An in-memory linking server: a school provider whose select step lists the linked Microsoft-like
/// accounts plus a "link a new one" option, and an account provider whose form links an account
/// (idempotently, like the real one).
class FakeLinkingApi implements LinkingApi {
  static const school = 'school';
  static const identity = 'identity';

  final List<LinkedAccount> store = [];
  final Map<String, String> sessionProvider = {};
  String? submitFailure;
  Object? accountsFailure;
  int accountsCalls = 0;
  int cancelled = 0;
  LinkedAccountStatus linkedStatus = LinkedAccountStatus.ok;
  DateTime? linkedSyncedAt;
  int _next = 0;

  @override
  Future<List<LinkProvider>> providers({String platform = 'mobile'}) async => const [
        LinkProvider(id: school, displayName: 'School', flows: [LinkFlow(id: 'main', label: 'Sign in')]),
        LinkProvider(id: identity, displayName: 'Identity', flows: [LinkFlow(id: 'browser', label: 'Browser')]),
      ];

  @override
  Future<List<LinkedAccount>> accounts() async {
    accountsCalls++;
    final failure = accountsFailure;
    if (failure != null) throw failure;
    return List.of(store);
  }

  LinkSession _select(String sessionId) => LinkSession(
        sessionId: sessionId,
        providerId: school,
        flowId: 'main',
        status: LinkSessionStatus.active,
        step: LinkStep(
          id: 'identity-account',
          kind: LinkStepKind.select,
          title: 'Choose an account',
          options: [
            for (final a in store.where((a) => a.providerId == identity)) LinkOption(value: a.id, label: a.title),
            const LinkOption(value: 'new', label: 'Link a new account', linkProviderId: identity),
          ],
        ),
      );

  LinkSession _done(String sessionId, String provider, String accountId) => LinkSession(
        sessionId: sessionId,
        providerId: provider,
        flowId: 'main',
        status: LinkSessionStatus.done,
        step: LinkStep(id: 'done', kind: LinkStepKind.done, doneAccountId: accountId),
      );

  @override
  Future<LinkSession> start(String providerId, {String? flowId, String? reauthAccountId}) async {
    final id = 's${_next++}';
    sessionProvider[id] = providerId;
    if (providerId == school) return _select(id);
    return LinkSession(
      sessionId: id,
      providerId: providerId,
      flowId: 'browser',
      status: LinkSessionStatus.active,
      step: const LinkStep(id: 'credentials', kind: LinkStepKind.form, title: 'Sign in', fields: [LinkField(key: 'email', label: 'Email', type: LinkFieldType.email)]),
    );
  }

  @override
  Future<LinkSession> submit(String sessionId, String stepId, Map<String, String> values, {String? action}) async {
    final provider = sessionProvider[sessionId]!;
    if (provider == school) {
      if (action == 'refresh') return _select(sessionId);
      return _done(sessionId, school, 'school-account');
    }
    final failure = submitFailure;
    if (failure != null) throw LinkingException(failure);
    final email = values['email']!;
    // Linking the same account again updates it; it never duplicates and never fails.
    store.removeWhere((a) => a.providerId == identity && a.id == email);
    store.add(LinkedAccount(providerId: identity, providerName: 'Identity', id: email, title: email));
    return _done(sessionId, identity, email);
  }

  @override
  Future<LinkSession> poll(String sessionId) async => _select(sessionId);

  @override
  Future<void> cancel(String sessionId) async => cancelled++;

  @override
  Future<void> unlink(String providerId, String accountId) async => store.removeWhere((a) => a.providerId == providerId && a.id == accountId);
}
