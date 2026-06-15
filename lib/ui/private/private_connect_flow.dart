import 'package:flutter/material.dart';

import '../../services/school_systems_service.dart';
import '../dashboard/widgets/add_school_modal.dart';
import 'private_connect_screen.dart';

/// Private-mode connect flow: show the backend's school-system picker, then run
/// the generic connect screen for the chosen system (driven entirely by the
/// catalog descriptor). Returns true if a connection was stored on-device.
Future<bool> runPrivateConnectFlow(BuildContext context) async {
  final systems = await SchoolSystemsService.fetch();
  if (!context.mounted) return false;

  final key = await showAddSchoolModal(context, systems);
  if (key == null || !context.mounted) return false;

  final system = systems.firstWhere((s) => s.key == key);
  final ok = await Navigator.of(context).push<bool>(
    MaterialPageRoute(builder: (_) => PrivateConnectScreen(system: system)),
  );
  return ok == true;
}
