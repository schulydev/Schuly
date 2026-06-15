import 'package:flutter/material.dart';

import '../../services/school_systems_service.dart';
import '../dashboard/widgets/add_school_modal.dart';
import '../odaorg/private_odaorg_connect_screen.dart';
import '../schulnetz/private_connect_screen.dart';

/// Private-mode connect flow: show the backend's school-system picker, then run
/// the chosen system's private connect screen. Returns true if a connection was
/// stored on-device.
Future<bool> runPrivateConnectFlow(BuildContext context) async {
  final systems = await SchoolSystemsService.fetch();
  if (!context.mounted) return false;

  final key = await showAddSchoolModal(context, systems);
  if (key == null || !context.mounted) return false;

  final Widget screen = key == 'odaorg'
      ? const OdaorgPrivateConnectScreen()
      : const PrivateConnectScreen();
  final ok = await Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (_) => screen));
  return ok == true;
}
