import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../config/backend_config.dart';
import '../../l10n/app_localizations.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/app_mode_service.dart';
import '../../services/linked_accounts_controller.dart';
import '../../services/linking_service.dart';
import '../../services/school_data_service.dart';
import '../../services/totp_vault.dart';
import '../../services/update/update_service.dart';
import '../authenticator/authenticator_vault_screen.dart';
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/sheet.dart';
import '../dashboard/dashboard_scope.dart';
import '../dashboard/schools_sheet.dart';
import '../documents/documents_page.dart';
import '../linking/schools_accounts_screen.dart';
import '../settings/settings_screen.dart';
import 'profile_picture.dart';
import 'student_id_page.dart';
import 'teachers_screen.dart';

/// Account: the Schuly account on top; below it what belongs to the school picked in the Schools sheet (the
/// Lernendenausweis, documents, teachers and contact details); then schools and accounts, the authenticator,
/// settings and sign-out.
class AccountPage extends StatefulWidget {
  final String? pictureUrl;
  final String? userName;
  final String? userEmail;
  final VoidCallback onSignOut;
  final bool visible;
  final ActiveAccountService? accountService;
  final LinkedAccountsController? linkedAccounts;
  final Future<Map<String, dynamic>?> Function(String path)? fetchJson;

  /// Reloads the Schuly account after its picture changed.
  final Future<void> Function()? onProfileChanged;
  const AccountPage({super.key, required this.pictureUrl, required this.userName, this.userEmail, required this.onSignOut, this.visible = true, this.accountService, this.linkedAccounts, this.fetchJson, this.onProfileChanged});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  /// The school connection's plugin version, shown in the version line.
  String? _version;
  DateTime? _lastSync;
  String? _syncStatus;
  String? _syncError;
  int? _codes;
  (String?, String?, String?) _pluginKey = (null, null, null);

  ActiveAccountService get _accountService => widget.accountService ?? ActiveAccountService.instance;
  LinkedAccountsController get _linked => widget.linkedAccounts ?? LinkedAccountsController.instance;

  @override
  void initState() {
    super.initState();
    _accountService.addListener(_onActiveChanged);
    SchoolDataService.instance.addListener(_onData);
    _linked.addListener(_onData);
    _pluginKey = _currentPluginKey();
    _loadVersion();
    _loadSyncStatus();
    _loadCodes();
  }

  @override
  void dispose() {
    _accountService.removeListener(_onActiveChanged);
    SchoolDataService.instance.removeListener(_onData);
    _linked.removeListener(_onData);
    super.dispose();
  }

  void _onData() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant AccountPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This page lives inside a dashboard IndexedStack, so it can go from hidden to visible without ever being rebuilt
    // for a new active school - only the tab index changes. Catch the case where plugin detection finished while the
    // tab was hidden and nothing ever fetched.
    if (widget.visible && !oldWidget.visible) {
      _loadCodes();
      if (_version == null && _syncStatus == null && _lastSync == null) {
        _loadVersion();
        _loadSyncStatus();
      }
    }
  }

  (String?, String?, String?) _currentPluginKey() {
    final active = _accountService.active;
    return (active?.id, active?.pluginAccountId, active?.pluginBasePath);
  }

  void _onActiveChanged() {
    if (mounted) setState(() {});
    final key = _currentPluginKey();
    if (key == _pluginKey) return;
    _pluginKey = key;
    _loadVersion();
    _loadSyncStatus();
  }

  Future<Map<String, dynamic>?> _fetchJson(String path) {
    if (widget.fetchJson != null) return widget.fetchJson!(path);
    return ApiClient.instance.dio.get<Map<String, dynamic>>(path).then((res) => res.data);
  }

  Future<void> _loadSyncStatus() async {
    try {
      final active = _accountService.active;
      final accountId = active?.pluginAccountId;
      final base = active?.pluginBasePath;
      if (accountId == null || base == null || base.isEmpty) return;
      final data = await _fetchJson('$base/accounts/$accountId/sync');
      if (!mounted || data == null) return;
      setState(() {
        final last = data['lastSync'];
        _lastSync = last is String ? DateTime.tryParse(last)?.toLocal() : null;
        _syncStatus = data['syncStatus']?.toString();
        _syncError = data['syncError']?.toString();
      });
    } catch (e, st) {
      debugPrint('AccountPage: failed to load sync status: $e\n$st');
    }
  }

  Future<void> _loadVersion() async {
    try {
      final base = _accountService.active?.pluginBasePath;
      if (base == null || base.isEmpty) return;
      final data = await _fetchJson('$base/status');
      if (mounted) setState(() => _version = data?['version']?.toString());
    } catch (e, st) {
      debugPrint('AccountPage: failed to load version: $e\n$st');
    }
  }

  Future<void> _loadCodes() async {
    try {
      final entries = await TotpVault.instance.load();
      if (mounted) setState(() => _codes = entries.length);
    } catch (_) {}
  }

  Future<void> _refresh() async {
    await SchoolDataService.instance.refresh();
    await _loadVersion();
    await _loadSyncStatus();
    await _loadCodes();
  }

  void _push(Widget screen) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen)).then((_) => _loadCodes());

  /// The one-line status under "Schools & accounts": a sign-in to renew first, then a sync error, then the last sync.
  Widget? _accountsStatus(AppLocalizations t) {
    final tokens = context.tokens;
    final colors = context.theme.colors;
    final accounts = _linked.accounts.where((a) => !a.isProviderError).toList();
    final expired = accounts.where((a) => a.status == LinkedAccountStatus.expired || a.status == LinkedAccountStatus.error).length;
    if (expired > 0) return StatusLabel(t.accountsNeedSignIn(expired), color: tokens.warn);
    if (_linked.syncing) return StatusLabel(t.accountsSyncing, color: colors.mutedForeground, dot: tokens.ink);
    if (_syncError?.isNotEmpty ?? false) return StatusLabel(_syncError!, color: tokens.bad);
    if (_lastSync != null) return StatusLabel(_syncStatus?.isNotEmpty == true ? '${t.accountsSynced(_ago(t, _lastSync!))} · $_syncStatus' : t.accountsSynced(_ago(t, _lastSync!)), color: colors.mutedForeground, dot: tokens.good);
    if (_pluginKey.$2 != null) return StatusLabel(t.accountsNeverSynced, color: colors.mutedForeground, dot: colors.mutedForeground);
    return null;
  }

  static String _ago(AppLocalizations t, DateTime when) {
    final d = DateTime.now().difference(when);
    if (d.inMinutes < 1) return t.agoJustNow;
    if (d.inMinutes < 60) return t.agoMinutes(d.inMinutes);
    if (d.inHours < 24) return t.agoHours(d.inHours);
    return '${when.day}.${when.month}.${when.year}';
  }

  Future<void> _confirmSignOut() async {
    final t = AppLocalizations.of(context)!;
    final ok = await showSchulySheet<bool>(
      context,
      builder: (ctx) => SchulySheet(
        title: t.signOutQuestion,
        subtitle: AppModeService.instance.isPrivate ? t.signOutPrivateBody : t.signOutBody,
        footer: SheetButtons(
          left: FButton(style: blockButton(FButtonStyle.outline), onPress: () => Navigator.of(ctx).pop(false), child: Text(t.cancel)),
          right: FButton(style: blockButton(FButtonStyle.destructive), onPress: () => Navigator.of(ctx).pop(true), child: Text(t.signOut)),
        ),
      ),
    );
    if (ok == true) widget.onSignOut();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final dates = Dates(context);
    final svc = SchoolDataService.instance;
    final me = svc.me;
    final isPrivate = AppModeService.instance.isPrivate;
    final scope = DashboardScope.maybeOf(context);
    final active = _accountService.active;

    final name = isPrivate ? (scope?.privateTitle ?? widget.userName) : (widget.userName ?? scope?.userName);
    final email = isPrivate ? null : (widget.userEmail ?? scope?.userEmail);
    final schoolPicture = BackendConfig.resolveUrl(me?.profilePictureUrl);
    final linkedCount = _linked.accounts.where((a) => !a.isProviderError).length;
    final version = UpdateService.instance.installedVersion;
    final server = BackendConfig.isCustom ? BackendConfig.url : t.serverCloud;

    return PageList(
      onRefresh: _refresh,
      bottom: 32,
      children: [
        const SchoolHeader(),
        PageTitle(t.tabAccount),
        FTileGroup(
          style: cardGroup,
          children: [
            FTile(
              style: (s) => s.copyWith(contentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.all(16), prefixIconSpacing: 14)),
              // The Schuly account's picture is changed here, as on the web's profile card; private mode has no account.
              prefix: isPrivate || widget.onProfileChanged == null
                  ? Avatar(url: widget.pictureUrl ?? scope?.pictureUrl, name: name, size: 60)
                  : ProfilePictureButton(url: widget.pictureUrl ?? scope?.pictureUrl, name: name, onChanged: widget.onProfileChanged!),
              title: Text(name?.isNotEmpty == true ? name! : t.tabAccount, style: typography.xl.copyWith(fontWeight: FontWeight.w600, letterSpacing: -0.18)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (email != null) Text(email),
                  Text(isPrivate ? t.accountPrivateMode : t.accountSchuly),
                ],
              ),
            ),
          ],
        ),
        SectionHead(t.accountThisSchool, link: t.accountSwitch, onLink: () => openSchoolsSheet(context)),
        FTileGroup(
          style: cardGroup,
          divider: FItemDivider.full,
          children: [
            FTile(
              style: (s) => s.copyWith(contentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14), prefixIconSpacing: 12)),
              // The picture of the account this school comes from, else the one the school holds.
              prefix: Avatar(url: _linked.accounts.where((a) => a.id == active?.pluginAccountId).firstOrNull?.pictureUrl ?? active?.profilePictureUrl, name: active?.fullName ?? active?.name ?? me?.schoolName, size: 40),
              title: Text(active?.fullName?.isNotEmpty == true ? active!.fullName! : (active?.name ?? me?.schoolName ?? '-'), style: typography.base.copyWith(fontWeight: FontWeight.w600)),
              subtitle: active?.name != null && active?.fullName?.isNotEmpty == true ? Text(active!.name) : null,
            ),
            FTile(
              style: (s) => s.copyWith(contentStyle: (c) => c.copyWith(padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14), prefixIconSpacing: 10)),
              prefix: const _MiniId(),
              title: Text(t.studentIdTitle),
              details: Text(t.accountShow),
              suffix: chevron(),
              onPress: () => openStudentId(context, me == null ? null : StudentId.fromProfile(me, schoolName: active?.fullName ?? me.schoolName, photoUrl: schoolPicture ?? widget.pictureUrl)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FTileGroup(
          divider: FItemDivider.full,
          children: [
            FTile(
              title: Text(t.accountDocuments),
              details: svc.documents.isEmpty ? null : Text('${svc.documents.length}'),
              suffix: chevron(),
              onPress: () => _push(const DocumentsScreen()),
            ),
            FTile(
              title: Text(t.accountTeachers),
              details: svc.teachers.isEmpty ? null : Text('${svc.teachers.length}'),
              suffix: chevron(),
              onPress: () => _push(const TeachersScreen()),
            ),
          ],
        ),
        if (me != null) ...[
          const SizedBox(height: 12),
          FTileGroup(
            divider: FItemDivider.full,
            children: [
              keyValueTile(context, t.accountEmail, me.email.isEmpty ? '-' : me.email),
              if (me.entryDate != null) keyValueTile(context, t.accountSince, dates.full(DateTime(me.entryDate!.year, me.entryDate!.month, me.entryDate!.day))),
            ],
          ),
        ],
        const SizedBox(height: 26),
        FTileGroup(
          divider: FItemDivider.full,
          children: [
            if (!isPrivate)
              FTile(
                title: Text(t.accountsTitle),
                subtitle: _accountsStatus(t),
                details: linkedCount == 0 ? null : Text('$linkedCount'),
                suffix: chevron(),
                onPress: () => _push(const SchoolsAccountsScreen()),
              ),
            FTile(
              title: Text(t.authenticatorTitle),
              details: _codes == null || _codes == 0 ? null : Text(t.authenticatorCodes(_codes!)),
              suffix: chevron(),
              onPress: () => _push(const AuthenticatorVaultScreen()),
            ),
            FTile(
              title: Text(t.settingsTitle),
              suffix: chevron(),
              onPress: () => _push(const SettingsScreen()),
            ),
          ],
        ),
        const SizedBox(height: 26),
        FButton(style: blockButton(FButtonStyle.outline, text: colors.destructive), onPress: _confirmSignOut, child: Text(t.signOut)),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Text(
            [
              version.isEmpty ? t.appTitle : '${t.appTitle} $version',
              server,
              if (_version != null) t.accountPluginVersion(_version!),
            ].join(' · '),
            textAlign: TextAlign.center,
            style: typography.xs.copyWith(color: colors.mutedForeground),
          ),
        ),
      ],
    );
  }
}

/// A tiny ID card drawing in front of "Lernendenausweis".
class _MiniId extends StatelessWidget {
  const _MiniId();

  @override
  Widget build(BuildContext context) {
    final muted = context.theme.colors.mutedForeground;
    return Container(
      width: 30,
      height: 20,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: context.tokens.input)),
      child: Stack(
        children: [
          Positioned(left: 3, top: 3, child: Container(width: 8, height: 12, decoration: BoxDecoration(color: muted.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(2)))),
          Positioned(left: 14, right: 3, top: 5, child: Container(height: 2, color: muted.withValues(alpha: 0.5))),
          Positioned(left: 14, right: 3, top: 9, child: Container(height: 2, color: muted.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
