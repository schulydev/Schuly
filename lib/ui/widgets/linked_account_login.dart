import 'dart:async';

import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/backend_dio.dart';
import '../../services/api_error.dart';
import '../../services/private_link_service.dart';
import '../../services/private_linked_account_store.dart';
import '../private/private_link_flow.dart';

/// Asks the catalog's [SchoolSystem.loginMethodPath], once a school URL is entered, whether that
/// school signs in with a linked account instead of the fields marked
/// [SchoolSystemLoginField.replacedByLinkedAccount].
class LoginMethodController extends ChangeNotifier {
  final SchoolSystem system;
  final TextEditingController? baseUrl;

  Timer? _debounce;
  String? _checkedUrl;
  bool checking = false;
  String? linkedProvider;
  String? browserLoginPath;

  LoginMethodController(this.system, this.baseUrl) {
    if (system.loginMethodPath != null) baseUrl?.addListener(_onChanged);
  }

  bool get usesLinkedAccount => linkedProvider != null;

  bool get usesBrowser => browserLoginPath != null;

  Set<String> get hiddenKeys => usesLinkedAccount || usesBrowser ? {for (final f in system.loginFields) if (f.replacedByLinkedAccount) f.key} : const {};

  void _onChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () => _check(baseUrl!.text.trim()));
  }

  Future<void> _check(String url) async {
    final uri = Uri.tryParse(url);
    final valid = uri != null && (uri.isScheme('http') || uri.isScheme('https')) && uri.host.contains('.');
    if (url == _checkedUrl) return;
    _checkedUrl = url;
    if (!valid) {
      _set(checking: false, provider: null, browserPath: null);
      return;
    }
    _set(checking: true, provider: linkedProvider, browserPath: browserLoginPath);
    String? provider;
    String? browserPath;
    try {
      final res = await backendDio().get<Map<String, dynamic>>(system.loginMethodPath!, queryParameters: {'baseUrl': url});
      provider = res.data?['linkedProvider'] as String?;
      browserPath = res.data?['browserLoginPath'] as String?;
    } catch (_) {
      provider = null;
      browserPath = null;
    }
    if (url == _checkedUrl) _set(checking: false, provider: provider, browserPath: browserPath);
  }

  void _set({required bool checking, required String? provider, required String? browserPath}) {
    this.checking = checking;
    linkedProvider = provider;
    browserLoginPath = browserPath;
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    baseUrl?.removeListener(_onChanged);
    super.dispose();
  }
}

/// Private mode: the accounts kept on this device that the school can sign in with, plus a
/// shortcut to link another one. [provider] is the id the school's login-method answer named.
/// A newly linked account is merged into the list straight from the link result, and a failure is
/// shown with its real reason; nothing is ever turned into an empty list.
class PrivateLinkedAccountPicker extends StatefulWidget {
  final String provider;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  const PrivateLinkedAccountPicker({required this.provider, required this.selectedId, required this.onChanged, super.key});

  @override
  State<PrivateLinkedAccountPicker> createState() => _PrivateLinkedAccountPickerState();
}

class _PrivateLinkedAccountPickerState extends State<PrivateLinkedAccountPicker> {
  List<PrivateLinkedAccount>? _accounts;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final accounts = await PrivateLinkService.instance.accounts();
      if (!mounted) return;
      setState(() {
        _accounts = accounts;
        _error = null;
      });
      final next = accounts.any((a) => a.id == widget.selectedId) ? widget.selectedId : (accounts.length == 1 ? accounts.first.id : null);
      if (next != widget.selectedId) widget.onChanged(next);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.describe(e));
    }
  }

  Future<void> _link() async {
    try {
      final account = await linkPrivateAccount(context, widget.provider);
      if (account == null || !mounted) return;
      setState(() {
        _error = null;
        _accounts = [...?_accounts?.where((a) => a.id != account.id), account];
      });
      widget.onChanged(account.id);
    } catch (e) {
      if (mounted) setState(() => _error = ApiError.describe(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;
    final accounts = _accounts;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Text('This school signs in with a linked account. Choose the account to use.', style: typography.sm.copyWith(color: colors.mutedForeground)),
        if (accounts == null && _error == null)
          const Center(child: FCircularProgress())
        else
          for (final account in accounts ?? const <PrivateLinkedAccount>[])
            FTile(
              prefix: const Icon(FIcons.mail),
              title: Text(account.email),
              subtitle: account.displayName == null ? null : Text(account.displayName!),
              suffix: account.id == widget.selectedId ? Icon(FIcons.check, color: colors.primary) : null,
              onPress: () => widget.onChanged(account.id),
            ),
        FTile(prefix: const Icon(FIcons.plus), title: const Text('Link a new account'), onPress: _link),
        if (_error != null) SelectableText(_error!, style: typography.sm.copyWith(color: colors.destructive)),
      ],
    );
  }
}
