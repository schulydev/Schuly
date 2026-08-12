import 'package:flutter/material.dart';

import '../dashboard/widgets/add_school_modal.dart';
import 'private_connect_screen.dart';

Future<bool> runPrivateConnectFlow(BuildContext context) async {
  final systems = await fetchSystemsOrShowError(context);
  if (systems == null || !context.mounted) return false;

  final key = await showAddSchoolModal(context, systems);
  if (key == null || !context.mounted) return false;

  final system = systems.firstWhere((s) => s.key == key);
  final ok = await Navigator.of(context).push<bool>(
    MaterialPageRoute(builder: (_) => PrivateConnectScreen(system: system)),
  );
  return ok == true;
}
