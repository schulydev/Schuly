import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';

import '../../l10n/app_localizations.dart';
import '../../services/school_data_service.dart';
import '../core/ui/kit.dart';

/// The school's teachers, with their short codes.
class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final svc = SchoolDataService.instance;
    return ListenableBuilder(
      listenable: svc,
      builder: (context, _) {
        final teachers = [...svc.teachers]..sort((a, b) => a.lastName.toLowerCase().compareTo(b.lastName.toLowerCase()));
        return SubPage(
          backLabel: t.tabAccount,
          title: t.accountTeachers,
          onRefresh: svc.refresh,
          children: [
            if (teachers.isEmpty)
              EmptyNote(t.teachersEmpty)
            else
              FTileGroup(
                divider: FItemDivider.full,
                children: [
                  for (final teacher in teachers)
                    FTile(
                      title: Text('${teacher.lastName} ${teacher.firstName}'.trim()),
                      details: teacher.code.isNotEmpty ? Text(teacher.code) : null,
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}
