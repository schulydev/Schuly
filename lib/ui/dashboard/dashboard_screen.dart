import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../config/backend_config.dart';
import '../../services/active_account_service.dart';
import '../../services/api_client.dart';
import '../../services/app_mode_service.dart';
import '../../services/private_account_store.dart';
import '../../services/profile_refresh_requests.dart';
import '../../services/school_data_service.dart';
import '../absences/absences_page.dart';
import '../core/ui/load_state.dart';
import '../account/account_page.dart';
import '../grades/grades_page.dart';
import '../home/home_page.dart';
import '../timetable/timetable_page.dart';
import 'tab_requests.dart';
import '../../l10n/app_localizations.dart';
import '../../services/reported_absences.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import 'dashboard_scope.dart';
import '../linking/add_account_flow.dart';
import '../linking/schools_accounts_screen.dart';
import '../../services/linked_accounts_controller.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onSignOut;
  const DashboardScreen({super.key, required this.onSignOut});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  String? _pictureUrl;
  String? _userName;
  String? _userEmail;
  String? _privateTitle;
  int _index = 0;
  DateTime? _lastClaimsRead;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ActiveAccountService.instance.addListener(_onActiveChanged);
    TabRequests.pending.addListener(_onTabRequested);
    _onTabRequested();
    ReportedAbsences.instance.start();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ActiveAccountService.instance.removeListener(_onActiveChanged);
    TabRequests.pending.removeListener(_onTabRequested);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    if (AppModeService.instance.isPrivate) return;
    final requested = ProfileRefreshRequests.pending.value;
    final stale = _lastClaimsRead == null ||
        DateTime.now().difference(_lastClaimsRead!) > const Duration(seconds: 60);
    if (!requested && !stale) return;
    ProfileRefreshRequests.clear();
    unawaited(_loadProfile());
  }

  /// Reads the signed-in account's name, email and picture; again on resume, so
  /// a picture changed in the web app shows up without an app restart.
  Future<void> _loadProfile() async {
    _lastClaimsRead = DateTime.now();
    try {
      final me = (await ApiClient.instance.api.getAuthApi().apiAuthMeGet()).data;
      if (!mounted || me == null) return;
      setState(() {
        _pictureUrl = BackendConfig.resolveUrl(me.profilePictureUrl);
        _userName = me.displayName;
        _userEmail = me.email.isEmpty ? null : me.email;
      });
    } catch (_) {}
  }

  void _onTabRequested() {
    final tab = TabRequests.pending.value;
    if (tab == null) return;
    final index = DashboardTab.values.indexOf(tab);
    if (mounted && index != _index) setState(() => _index = index);
    TabRequests.clear();
  }

  String? _lastSchoolId;
  void _onActiveChanged() {
    final id = ActiveAccountService.instance.active?.id;
    if (id != _lastSchoolId) {
      _lastSchoolId = id;
      SchoolDataService.instance.refresh();
    }
  }

  Future<void> _bootstrap() async {
    if (AppModeService.instance.isPrivate) {
      final account = await PrivateAccountStore.instance.load();
      if (mounted) {
        setState(() {
          _userName = account?.displayName;
          _privateTitle = account?.displayName;
        });
      }
      await SchoolDataService.instance.refresh();
      return;
    }

    await _loadProfile();
    unawaited(LinkedAccountsController.instance.load());

    final svc = ActiveAccountService.instance;
    await svc.refresh();
    if (!mounted) return;
    if (svc.schools.isEmpty) {
      // Empty only counts when the server actually answered - a cold start with no
      // network must not greet the user with the add-school flow.
      if (svc.error != null) {
        SchoolDataService.instance.settle();
        return;
      }
      await SchoolDataService.instance.refresh();
      if (mounted) await runAddAccountFlow(context);
    }
  }

  /// Starts the load over. The school data has to be asked for as well: an unchanged active school does not refresh it.
  Future<void> _retryLoad() async {
    await _bootstrap();
    if (mounted && !AppModeService.instance.isPrivate && ActiveAccountService.instance.schools.isNotEmpty) await SchoolDataService.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return AnimatedBuilder(
      animation: Listenable.merge([
        ActiveAccountService.instance,
        SchoolDataService.instance,
        LinkedAccountsController.instance,
      ]),
      builder: (context, _) {
        final data = SchoolDataService.instance;

        final pages = [
          const HomePage(),
          const TimetablePage(),
          const GradesPage(),
          const AbsencesPage(),
          AccountPage(
            pictureUrl: _pictureUrl,
            userName: _userName,
            userEmail: _userEmail,
            onSignOut: widget.onSignOut,
            visible: _index == 4,
          ),
        ];

        Widget body = IndexedStack(index: _index, children: pages);
        if (!AppModeService.instance.isPrivate && LinkedAccountsController.instance.syncing) {
          body = Column(children: [
            const Padding(padding: EdgeInsets.fromLTRB(16, 12, 16, 0), child: SyncingBanner()),
            Expanded(child: body),
          ]);
        }
        if (data.error != null && data.me == null) {
          body = Stack(children: [
            body,
            Positioned.fill(
              child: ColoredBox(
                color: colors.background,
                child: LoadFailure(error: data.error!, onRetry: _retryLoad),
              ),
            ),
          ]);
        } else if (!data.hasLoaded) {
          body = Stack(children: [
            body,
            Positioned.fill(
              child: ColoredBox(
                color: colors.background,
                child: LoadingWithRetry(onRetry: _retryLoad),
              ),
            ),
          ]);
        }

        final t = AppLocalizations.of(context)!;
        final ink = context.tokens.ink;
        final avatarName = _userName ?? SchoolDataService.instance.me?.firstName;
        final tabs = [
          (FIcons.house, t.tabHome),
          (FIcons.calendar, t.tabTimetable),
          (FIcons.chartColumn, t.tabGrades),
          (FIcons.calendarX, t.tabAbsences),
          (null, t.tabAccount),
        ];

        return DashboardScope(
          userName: _userName,
          userEmail: _userEmail,
          pictureUrl: _pictureUrl,
          privateTitle: _privateTitle,
          onSignOut: widget.onSignOut,
          child: FScaffold(
            footer: SafeArea(
              top: false,
              child: FBottomNavigationBar(
                index: _index,
                onChange: (i) {
                  if (i != _index) HapticFeedback.selectionClick();
                  setState(() => _index = i);
                },
                children: [
                  for (final (i, (icon, label)) in tabs.indexed)
                    FBottomNavigationBarItem(
                      icon: _TabIcon(
                        active: i == _index,
                        ink: ink,
                        child: icon != null ? Icon(icon) : Avatar(url: _pictureUrl, name: avatarName, size: 22, ring: i == _index ? ink : null),
                      ),
                      label: Text(label),
                    ),
                ],
              ),
            ),
            childPad: false,
            child: SafeArea(bottom: false, child: body),
          ),
        );
      },
    );
  }
}

/// A tab icon with the accent bar above it while its tab is open.
class _TabIcon extends StatelessWidget {
  const _TabIcon({required this.active, required this.ink, required this.child});

  final bool active;
  final Color ink;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 20, height: 2, decoration: BoxDecoration(color: active ? ink : const Color(0x00000000), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 7),
          SizedBox(height: 24, child: Center(child: child)),
        ],
      );
}
