import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../domain/school_system.dart';
import '../../services/backend_dio.dart';
import '../../services/microsoft_service.dart';
import '../../services/toast_service.dart';
import '../microsoft/microsoft_link_flow.dart';

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

/// The Microsoft accounts linked in Settings to pick from, plus a shortcut to link one here.
class LinkedMicrosoftAccountPicker extends StatefulWidget {
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  const LinkedMicrosoftAccountPicker({required this.selectedId, required this.onChanged, super.key});

  @override
  State<LinkedMicrosoftAccountPicker> createState() => _LinkedMicrosoftAccountPickerState();
}

class _LinkedMicrosoftAccountPickerState extends State<LinkedMicrosoftAccountPicker> {
  List<MicrosoftAccount>? _accounts;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({String? select}) async {
    List<MicrosoftAccount> accounts;
    try {
      accounts = await MicrosoftService.instance.accounts();
    } catch (_) {
      accounts = const [];
    }
    if (!mounted) return;
    setState(() => _accounts = accounts);
    final keep = select ?? widget.selectedId;
    final next = accounts.any((a) => a.id == keep) ? keep : (accounts.length == 1 ? accounts.first.id : null);
    if (next != widget.selectedId) widget.onChanged(next);
  }

  Future<void> _link() async {
    try {
      final account = await linkMicrosoftAccount(context);
      if (account != null) await _load(select: account.id);
    } catch (_) {
      if (mounted) ToastService.error('Microsoft sign-in failed');
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
        Text('This school signs in with Microsoft. Choose the Microsoft account to use.', style: typography.sm.copyWith(color: colors.mutedForeground)),
        if (accounts == null)
          const Center(child: FCircularProgress())
        else
          for (final account in accounts)
            FTile(
              prefix: const Icon(FIcons.mail),
              title: Text(account.email),
              subtitle: account.displayName == null ? null : Text(account.displayName!),
              suffix: account.id == widget.selectedId ? Icon(FIcons.check, color: colors.primary) : null,
              onPress: () => widget.onChanged(account.id),
            ),
        FTile(
          prefix: const Icon(FIcons.plus),
          title: const Text('Link a Microsoft account'),
          onPress: _link,
        ),
      ],
    );
  }
}
