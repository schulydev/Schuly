import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/oidc_config.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/school_data_service.dart';
import '../classes/class_detail_screen.dart';
import '../documents/documents_page.dart';

/// Account tab — profile details, enrolled classes, app info, and the account
/// switcher + sign out.
class AccountPage extends StatefulWidget {
  final String? pictureUrl;
  final String? userName;
  final VoidCallback onSignOut;
  const AccountPage({
    super.key,
    required this.pictureUrl,
    required this.userName,
    required this.onSignOut,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? _version;
  bool _syncing = false;
  String? _syncMsg;
  DateTime? _lastSync;
  String? _syncStatus;
  String? _syncError;

  @override
  void initState() {
    super.initState();
    _loadVersion();
    _loadSyncStatus();
  }

  /// Reads the active account's last-sync time / status / error off the plugin's
  /// `…/sync` endpoint so the user can see when data was last refreshed and why
  /// a sync failed.
  Future<void> _loadSyncStatus() async {
    try {
      final active = ActiveAccountService.instance.active;
      final accountId = active?.pluginAccountId;
      if (accountId == null) return;
      final sync = ApiClient.instance.api.getSyncApi();
      final res = active!.provider == 'odaorg'
          ? await sync.apiPluginsOdaorgAccountsAccountIdSyncGet(accountId: accountId)
          : await sync.apiPluginsSchulwareAccountsAccountIdSyncGet(accountId: accountId);
      final data = res.data as Map<String, dynamic>?;
      if (!mounted || data == null) return;
      setState(() {
        final last = data['lastSync'];
        _lastSync = last is String ? DateTime.tryParse(last)?.toLocal() : null;
        _syncStatus = data['syncStatus']?.toString();
        _syncError = data['syncError']?.toString();
      });
    } catch (_) {/* non-critical */}
  }

  /// The version shown is the active provider's plugin version (Schulware /
  /// OdaOrg), read off its `…/status` endpoint — not the backend app version.
  Future<void> _loadVersion() async {
    try {
      final active = ActiveAccountService.instance.active;
      final status = ApiClient.instance.api.getStatusApi();
      final res = active?.provider == 'odaorg'
          ? await status.apiPluginsOdaorgStatusGet()
          : await status.apiPluginsSchulwareStatusGet();
      final data = res.data as Map<String, dynamic>?;
      if (mounted) setState(() => _version = data?['version']?.toString());
    } catch (_) {/* non-critical */}
  }

  /// Triggers an actual provider re-fetch for the active account, then reloads
  /// the local data. Unlike pull-to-refresh (which only re-reads the backend),
  /// this pulls fresh data from Schulnetz / OdaOrg.
  Future<void> _syncNow() async {
    final active = ActiveAccountService.instance.active;
    final accountId = active?.pluginAccountId;
    if (accountId == null) {
      setState(() => _syncMsg = 'No connected account to sync');
      return;
    }
    setState(() {
      _syncing = true;
      _syncMsg = null;
    });
    try {
      final sync = ApiClient.instance.api.getSyncApi();
      if (active!.provider == 'odaorg') {
        await sync.apiPluginsOdaorgAccountsAccountIdSyncPost(accountId: accountId);
      } else {
        await sync.apiPluginsSchulwareAccountsAccountIdSyncPost(accountId: accountId);
      }
      await SchoolDataService.instance.refresh();
      await _loadSyncStatus();
      if (mounted) setState(() => _syncMsg = 'Synced just now');
    } on DioException catch (e) {
      if (mounted) setState(() => _syncMsg = 'Sync failed (${e.response?.statusCode ?? 'network'})');
    } catch (e) {
      if (mounted) setState(() => _syncMsg = 'Sync failed');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final me = SchoolDataService.instance.me;
    final classes = me?.classes ?? const <UserClassDto>[];

    String fmtDate(Date? d) => d == null ? '—' : '${d.day}.${d.month}.${d.year}';
    final fullName = me == null
        ? (widget.userName ?? '—')
        : '${me.firstName ?? ''} ${me.lastName ?? ''}'.trim();
    final initial = fullName.isNotEmpty ? fullName.characters.first.toUpperCase() : '?';
    final fallback = Text(initial,
        style: TextStyle(color: colors.mutedForeground, fontWeight: FontWeight.w600));
    // Prefer the school provider's photo (may be relative), fall back to OIDC.
    final providerPfp = OidcConfig.resolveUrl(me?.profilePictureUrl);
    final avatarUrl = providerPfp ?? widget.pictureUrl;

    return RefreshIndicator(
      onRefresh: () async {
        await SchoolDataService.instance.refresh();
        await _loadVersion();
        await _loadSyncStatus();
      },
      child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        // Identity header
        Row(
          children: [
            (avatarUrl == null || avatarUrl.isEmpty)
                ? FAvatar.raw(size: 56, child: fallback)
                : FAvatar(size: 56, image: NetworkImage(avatarUrl), fallback: fallback),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fullName.isEmpty ? 'Account' : fullName,
                      style: typography.lg.copyWith(fontWeight: FontWeight.w700)),
                  if (me?.role != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: _Badge(_roleLabel(me!.role)),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SectionLabel('Profile'),
        _InfoTile(icon: FIcons.mail, label: 'Email', value: me?.email),
        _InfoTile(icon: FIcons.phone, label: 'Phone', value: me?.phoneNumber),
        _InfoTile(
          icon: FIcons.mapPin,
          label: 'Address',
          value: [me?.street, [me?.zip, me?.city].where((s) => (s ?? '').isNotEmpty).join(' ')]
              .where((s) => (s ?? '').isNotEmpty)
              .join(', '),
        ),
        _InfoTile(icon: FIcons.cake, label: 'Birthday', value: fmtDate(me?.birthday)),
        const SizedBox(height: 20),
        if (classes.isNotEmpty) ...[
          _SectionLabel('My classes'),
          for (final c in classes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.users),
                title: Text(c.className ?? 'Class'),
                suffix: const Icon(FIcons.chevronRight),
                onPress: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ClassDetailScreen(
                    classId: c.classId,
                    title: c.className ?? 'Class',
                  ),
                )),
              ),
            ),
          const SizedBox(height: 12),
        ],
        if (SchoolDataService.instance.teachers.isNotEmpty) ...[
          _SectionLabel('Teachers'),
          for (final t in SchoolDataService.instance.teachers)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FTile(
                prefix: const Icon(FIcons.user),
                title: Text('${t.firstName ?? ''} ${t.lastName ?? ''}'.trim()),
                subtitle: (t.code?.isNotEmpty ?? false) ? Text(t.code!) : null,
                suffix: (t.email?.isNotEmpty ?? false) ? const Icon(FIcons.mail) : null,
                onPress: (t.email?.isNotEmpty ?? false)
                    ? () => launchUrl(Uri(scheme: 'mailto', path: t.email))
                    : null,
              ),
            ),
          const SizedBox(height: 12),
        ],
        _SectionLabel('Documents'),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FTile(
            prefix: const Icon(FIcons.folder),
            title: const Text('Documents'),
            details: SchoolDataService.instance.documents.isNotEmpty
                ? Text('${SchoolDataService.instance.documents.length}')
                : null,
            suffix: const Icon(FIcons.chevronRight),
            onPress: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DocumentsScreen())),
          ),
        ),
        _SectionLabel('Plugin'),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: _syncing
                ? const FCircularProgress()
                : const Icon(FIcons.refreshCw),
            title: const Text('Sync now'),
            subtitle: _syncMsg != null
                ? Text(_syncMsg!)
                : const Text('Fetch fresh data from the provider'),
            onPress: _syncing ? null : _syncNow,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: Icon(
              (_syncError?.isNotEmpty ?? false) ? FIcons.circleAlert : FIcons.circleCheck,
              color: (_syncError?.isNotEmpty ?? false) ? colors.destructive : null,
            ),
            title: const Text('Last sync'),
            subtitle: (_syncError?.isNotEmpty ?? false)
                ? Text(_syncError!, style: TextStyle(color: colors.destructive))
                : (_syncStatus != null ? Text(_syncStatus!) : null),
            details: Text(_lastSync != null ? _fmtSyncTime(_lastSync!) : 'Never'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FTile(
            prefix: const Icon(FIcons.info),
            title: const Text('Version'),
            suffix: Text(_version ?? '—', style: TextStyle(color: colors.mutedForeground)),
          ),
        ),
        const SizedBox(height: 4),
        FButton(
          prefix: const Icon(FIcons.logOut),
          onPress: widget.onSignOut,
          child: const Text('Sign out'),
        ),
      ],
      ),
    );
  }

  static String _fmtSyncTime(DateTime t) {
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return '${t.day}.${t.month}.${t.year}';
  }

  static String _roleLabel(Roles? r) => switch (r) {
        Roles.teacher => 'Teacher',
        Roles.administrator => 'Administrator',
        _ => 'Student',
      };
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    final t = context.theme.typography;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Text(text.toUpperCase(),
          style: t.xs.copyWith(color: c.mutedForeground, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  const _InfoTile({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FTile(
          prefix: Icon(icon),
          title: Text(label),
          details: Text((value?.isNotEmpty ?? false) ? value! : '—'),
        ),
      );
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge(this.text);
  @override
  Widget build(BuildContext context) {
    final c = context.theme.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.secondary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(color: c.secondaryForeground, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}
