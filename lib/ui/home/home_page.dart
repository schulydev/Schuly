import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:schuly_api/schuly_api.dart';

import '../../domain/absence_rows.dart';
import '../../domain/grade_math.dart';
import '../../l10n/app_localizations.dart';
import '../../services/reported_absences.dart';
import '../../services/school_data_service.dart';
import '../absences/absence_detail_sheet.dart';
import '../absences/absences_page.dart' show absenceRowsNow;
import '../core/dates.dart';
import '../core/theme/schuly_theme.dart';
import '../core/ui/kit.dart';
import '../core/ui/now_ticker.dart';
import '../dashboard/dashboard_scope.dart';
import '../dashboard/tab_requests.dart';
import '../grades/grade_data.dart';
import '../grades/grade_detail_sheet.dart';
import '../timetable/day_timeline.dart';

/// The newest graded exams, at most [kHomeMaxItems].
List<ExamDto> latestGradedExams(SchoolDataService svc) {
  final mine = svc.myGradesByExam;
  final graded = svc.exams.where((e) => isGradedScore(mine[e.id]?.score)).toList()
    ..sort((a, b) {
      final da = examDay(a), db = examDay(b);
      if (da == null) return db == null ? 0 : 1;
      if (db == null) return -1;
      return db.compareTo(da);
    });
  return graded.take(kHomeMaxItems).toList();
}

/// What comes after today: tests and events from tomorrow on, and holidays not yet over, at most [kHomeMaxItems].
List<AgendaEntryDto> comingUp(Iterable<AgendaEntryDto> agenda, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  final out = agenda.where((a) {
    final start = dayOf(a.date);
    return switch (a.entryType) {
      AgendaEntryType.test || AgendaEntryType.event => start.isAfter(today),
      AgendaEntryType.holiday => !dayOf(a.endDate ?? a.date).isBefore(today),
      _ => false,
    };
  }).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
  return out.take(kHomeMaxItems).toList();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This page is const in the dashboard, so its parent rebuilding does not reach it.
  @override
  void initState() {
    super.initState();
    SchoolDataService.instance.addListener(_changed);
    ReportedAbsences.instance.addListener(_changed);
  }

  @override
  void dispose() {
    SchoolDataService.instance.removeListener(_changed);
    ReportedAbsences.instance.removeListener(_changed);
    super.dispose();
  }

  void _changed() => setState(() {});

  @override
  Widget build(BuildContext context) => NowTicker(builder: (context, now) => _content(context, now));

  Widget _content(BuildContext context, DateTime now) {
    final t = AppLocalizations.of(context)!;
    final dates = Dates(context);
    final svc = SchoolDataService.instance;
    final tokens = context.tokens;
    final today = DateTime(now.year, now.month, now.day);

    final todayEntries = svc.agenda.where((a) => a.entryType != AgendaEntryType.holiday && sameDay(dayOf(a.date), today)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final firstTest = todayEntries.where((a) => a.entryType == AgendaEntryType.test).firstOrNull;
    final lessonCount = todayEntries.where((a) => a.entryType != AgendaEntryType.event).length;

    final names = subjectNames(svc);
    final grades = latestGradedExams(svc);
    // The absences that still ask something of the student or the school, as the web's statuses say.
    final unexcused = absenceRowsNow().where((r) => const {AbsenceState.needsExcuse, AbsenceState.unexcused, AbsenceState.rejected, AbsenceState.waiting}.contains(r.state)).toList();
    final upcoming = comingUp(svc.agenda, now);

    final firstName = svc.me?.firstName.trim().isNotEmpty == true ? svc.me!.firstName.trim() : DashboardScope.maybeOf(context)?.userName?.split(' ').first;
    final hour = now.hour;
    final greeting = hour < 5 || hour >= 18 ? t.homeGreetingEvening(firstName ?? '') : (hour < 12 ? t.homeGreetingMorning(firstName ?? '') : t.homeGreetingAfternoon(firstName ?? ''));
    final greetingText = firstName == null || firstName.isEmpty ? greeting.replaceAll(RegExp(r',\s*$'), '') : greeting;
    final subtitle = firstTest != null
        ? t.homeSubtitleTest(dates.dayLong(now), firstTest.title, dates.hm(firstTest.date.toLocal()))
        : lessonCount > 0
            ? t.homeSubtitleLessons(dates.dayLong(now), lessonCount)
            : dates.dayLong(now);

    return PageList(
      onRefresh: () => Future.wait([svc.refresh(), ReportedAbsences.instance.load()]),
      children: [
        const SchoolHeader(),
        PageTitle(greetingText, subtitle: subtitle, bottom: 18),
        SectionHead(t.homeToday, link: t.homeTimetableLink, onLink: () => TabRequests.request(DashboardTab.timetable), top: 0),
        if (todayEntries.isEmpty) EmptyNote(t.homeNoLessons) else DayTimeline(entries: todayEntries, now: now, isToday: true, compact: true),
        SectionHead(t.homeNewGrades, link: t.homeAllGrades, onLink: () => TabRequests.request(DashboardTab.grades)),
        if (grades.isEmpty)
          EmptyNote(t.gradesEmpty)
        else
          FTileGroup(
            divider: FItemDivider.full,
            children: [
              for (final e in grades)
                FTile(
                  title: Text(e.name),
                  subtitle: Text([names[e.classId], if (examDay(e) != null) dates.dayMonth(examDay(e)!)].whereType<String>().join(' · ')),
                  suffix: GradePill(svc.myGradesByExam[e.id]?.score),
                  onPress: () => showGradeDetail(context, e),
                ),
            ],
          ),
        if (unexcused.isNotEmpty) ...[
          SectionHead(t.homeUnexcused, link: t.homeAllAbsences, onLink: () => TabRequests.request(DashboardTab.absences)),
          FTileGroup(
            divider: FItemDivider.full,
            children: [
              for (final a in unexcused.take(kHomeMaxItems))
                _absenceTile(context, t, dates, a),
            ],
          ),
        ],
        SectionHead(t.homeComingUp),
        if (upcoming.isEmpty)
          EmptyNote(t.homeNothingComing)
        else
          FTileGroup(
            divider: FItemDivider.full,
            children: [for (final a in upcoming) _comingTile(context, t, dates, a, today, tokens)],
          ),
      ],
    );
  }

  FTile _absenceTile(BuildContext context, AppLocalizations t, Dates dates, AbsenceRow a) {
    final status = absenceStatusLabel(context, a);
    return FTile(
      prefix: DateTile(weekday: dates.weekdayShort(a.from), day: a.from.day),
      title: Text(absenceReasonLine(t, a)),
      subtitle: status ?? Text(absenceDetail(t, a) ?? absenceRange(dates, a)),
      onPress: () => showAbsenceDetail(context, a),
    );
  }

  FTile _comingTile(BuildContext context, AppLocalizations t, Dates dates, AgendaEntryDto a, DateTime today, SchulyTokens tokens) {
    final start = a.date.toLocal();
    final typography = context.theme.typography;
    final String kind;
    final Color color;
    final String sub;
    switch (a.entryType) {
      case AgendaEntryType.holiday:
        final days = dayOf(a.date).difference(today).inDays;
        kind = days <= 0 ? t.homeHolidayNow : t.homeInDays(days);
        color = tokens.calendarHoliday;
        final end = a.endDate?.toLocal();
        sub = end == null || sameDay(dayOf(end), dayOf(start)) ? dates.full(start) : '${dates.full(start)} – ${dates.full(end)}';
      case AgendaEntryType.event:
        kind = t.entryTypeEvent;
        color = tokens.calendarEvent;
        sub = [dates.hm(start), a.place].whereType<String>().where((s) => s.isNotEmpty).join(' · ');
      default:
        kind = t.entryTypeTest;
        color = tokens.calendarTest;
        sub = [dates.hm(start), a.place].whereType<String>().where((s) => s.isNotEmpty).join(' · ');
    }
    return FTile(
      prefix: DateTile(weekday: dates.weekdayShort(start), day: start.day),
      title: Text(a.title.isNotEmpty ? a.title : kind),
      subtitle: Text(sub),
      details: Text(kind, style: typography.xs.copyWith(fontWeight: FontWeight.w500, color: color)),
    );
  }
}
