import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../../services/api_error.dart';

/// A failed load: what went wrong in words a person can act on, and a way to try again.
class LoadFailure extends StatelessWidget {
  const LoadFailure({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => _Message(text: ApiError.describe(error), color: context.theme.colors.destructive, onRetry: onRetry);
}

/// A spinner that does not spin forever: after [timeout] it says so and offers a retry, while the
/// load it stands for keeps running and can still finish.
class LoadingWithRetry extends StatefulWidget {
  const LoadingWithRetry({super.key, required this.onRetry});

  /// How long a load may take before the retry appears.
  static Duration timeout = const Duration(seconds: 30);

  final VoidCallback onRetry;

  @override
  State<LoadingWithRetry> createState() => _LoadingWithRetryState();
}

class _LoadingWithRetryState extends State<LoadingWithRetry> {
  Timer? _timer;
  bool _slow = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(LoadingWithRetry.timeout, () {
      if (mounted) setState(() => _slow = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _retry() {
    setState(() => _slow = false);
    _startTimer();
    widget.onRetry();
  }

  @override
  Widget build(BuildContext context) {
    if (!_slow) return const Center(child: FCircularProgress());
    return _Message(text: 'This is taking longer than usual. Check your connection and try again.', color: context.theme.colors.mutedForeground, onRetry: _retry);
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, required this.color, required this.onRetry});

  final String text;
  final Color color;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(text, textAlign: TextAlign.center, style: TextStyle(color: color)),
            FButton(mainAxisSize: MainAxisSize.min, prefix: const Icon(FIcons.refreshCw), onPress: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
