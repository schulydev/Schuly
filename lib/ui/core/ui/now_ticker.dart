import 'dart:async';

import 'package:flutter/widgets.dart';

class NowTicker extends StatefulWidget {
  const NowTicker({super.key, required this.builder, this.interval = const Duration(seconds: 30)});

  final Widget Function(BuildContext context, DateTime now) builder;
  final Duration interval;

  @override
  State<NowTicker> createState() => _NowTickerState();
}

class _NowTickerState extends State<NowTicker> with WidgetsBindingObserver {
  DateTime _now = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) => setState(() => _now = DateTime.now()));
  }

  @override
  void didUpdateWidget(covariant NowTicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval) {
      _timer.cancel();
      _startTimer();
    }
  }

  // The periodic timer alone can leave `now` stale for as long as the app was
  // backgrounded (Android/iOS suspend timers while paused) - refresh
  // immediately when the app comes back to the foreground instead of waiting
  // for the next tick.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) setState(() => _now = DateTime.now());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _now);
}
