import 'dart:async';

import 'package:flutter/widgets.dart';

import 'active_account_service.dart';
import 'linking_service.dart';
import 'school_data_service.dart';

/// Capability kind of the accounts that unlock school data (grades, timetable, ...).
const schoolDataCapability = 'school_data';

/// Capability kind of the accounts that can report absences to the school.
const absenceReportingCapability = 'absence_reporting';

/// The one place that knows which accounts are linked and which providers exist. Every list,
/// picker and capability section reads from here, and every link, re-link or unlink goes
/// through it so that the dependent stores (active school, school data, absences, timetable,
/// documents) are invalidated and reloaded straight away instead of at the next app start.
class LinkedAccountsController extends ChangeNotifier with WidgetsBindingObserver {
  LinkedAccountsController({LinkingApi? api, Future<void> Function()? refreshDependents, Future<void> Function()? clearCaches, this.pollInterval = const Duration(seconds: 3), this.pollLimit = const Duration(minutes: 3)})
      : api = api ?? HttpLinkingApi(),
        _refreshDependents = refreshDependents ?? _defaultRefreshDependents,
        _clearCaches = clearCaches ?? SchoolDataService.instance.clearCache;

  static final LinkedAccountsController instance = LinkedAccountsController();

  final LinkingApi api;
  final Future<void> Function() _refreshDependents;
  final Future<void> Function() _clearCaches;
  final Duration pollInterval;
  final Duration pollLimit;

  List<LinkProvider> _providers = const [];
  List<LinkedAccount> _accounts = const [];
  bool _loaded = false;
  bool _loading = false;
  Object? _error;
  final Set<String> _linkedThisSession = {};
  Timer? _timer;
  int _ticks = 0;
  bool _foreground = true;
  bool _observing = false;
  bool _disposed = false;

  List<LinkProvider> get providers => _providers;
  List<LinkedAccount> get accounts => _accounts;
  bool get loaded => _loaded;
  bool get loading => _loading;
  Object? get error => _error;

  /// True while an account linked in this session is still pulling its first data in.
  bool get syncing => _accounts.any(_isSyncing);

  bool _isSyncing(LinkedAccount a) {
    if (a.isProviderError) return false;
    if (a.status == LinkedAccountStatus.syncing) return true;
    return a.status == LinkedAccountStatus.ok && a.lastSyncedAt == null && _linkedThisSession.contains(a.key) && a.hasCapability(schoolDataCapability);
  }

  LinkProvider? provider(String id) {
    for (final p in _providers) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Accounts offering the capability [kind], grouped for display by provider name.
  List<LinkedAccount> withCapability(String kind) => [for (final a in _accounts) if (!a.isProviderError && a.hasCapability(kind)) a];

  /// Provider display name -> accounts, for the capability sections of the UI.
  Map<String, List<LinkedAccount>> groupedByProvider() {
    final out = <String, List<LinkedAccount>>{};
    for (final a in _accounts) {
      out.putIfAbsent(a.providerName, () => []).add(a);
    }
    return out;
  }

  /// Providers and accounts, fresh from the server. A failure is kept in [error] and the last
  /// good lists stay on screen.
  Future<void> load() async {
    _loading = true;
    _error = null;
    _notify();
    try {
      final results = await Future.wait<Object>([api.providers(), api.accounts()]);
      _providers = results[0] as List<LinkProvider>;
      _setAccounts(results[1] as List<LinkedAccount>);
      _loaded = true;
    } catch (e) {
      _error = e;
    } finally {
      _loading = false;
      _notify();
    }
  }

  /// Only the accounts (providers rarely change).
  Future<void> reloadAccounts() async {
    try {
      _setAccounts(await api.accounts());
      _loaded = true;
      _error = null;
    } catch (e) {
      _error = e;
    }
    _notify();
  }

  void _setAccounts(List<LinkedAccount> next) {
    final seen = <String>{};
    _accounts = [for (final a in next) if (seen.add(a.key)) a];
  }

  /// A link flow reached its done step for [providerId] / [accountId]. Reloads the account lists
  /// at once (a re-link of the same account just refreshes its row), starts watching it while it
  /// syncs, and reloads everything that depends on the account.
  Future<void> linked(String providerId, String accountId) async {
    _linkedThisSession.add('$providerId/$accountId');
    await reloadAccounts();
    await _refreshDependents();
    _startPolling();
  }

  /// Removes the account, drops it from every list immediately and reloads what depended on it.
  Future<void> unlink(LinkedAccount account) async {
    await api.unlink(account.providerId, account.id);
    _linkedThisSession.remove(account.key);
    _accounts = [for (final a in _accounts) if (a.key != account.key) a];
    _notify();
    await _clearCaches();
    await reloadAccounts();
    await _refreshDependents();
  }

  void _startPolling() {
    if (_disposed || _timer != null || !syncing) return;
    _ticks = 0;
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    _timer = Timer.periodic(pollInterval, (_) => _tick());
  }

  void _stopPolling() {
    _timer?.cancel();
    _timer = null;
    _ticks = 0;
    if (_observing) {
      WidgetsBinding.instance.removeObserver(this);
      _observing = false;
    }
  }

  bool _ticking = false;

  Future<void> _tick() async {
    if (_ticking || !_foreground) return;
    if (++_ticks * pollInterval.inMilliseconds > pollLimit.inMilliseconds) {
      _stopPolling();
      return;
    }
    _ticking = true;
    try {
      final before = syncing;
      await reloadAccounts();
      if (_disposed) return;
      if (!syncing) {
        _stopPolling();
        if (before) await _refreshDependents();
      }
    } finally {
      _ticking = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    if (_foreground && syncing) unawaited(_tick());
  }

  /// Forgets everything (sign-out / server change).
  void clear() {
    _stopPolling();
    _providers = const [];
    _accounts = const [];
    _loaded = false;
    _error = null;
    _linkedThisSession.clear();
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _stopPolling();
    super.dispose();
  }

  static Future<void> _defaultRefreshDependents() async {
    await ActiveAccountService.instance.refresh();
    await SchoolDataService.instance.refresh();
  }
}
