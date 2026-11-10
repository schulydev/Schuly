// Fake Schuly API with made-up data for the app screenshots. Nothing here is real.
// Usage: bun tools/store-screenshots/fake-api/server.ts   (PORT=5591 by default; the emulator reaches it at http://10.0.2.2:5591)
const PORT = Number(process.env.PORT ?? 5591);
// EXTRAS=1 adds what the store shots leave out: the school's approval fields on absences, a linked Microsoft account
// with an Outlook calendar, the other providers, and a profile picture that can be changed.
const EXTRAS = process.env.EXTRAS === "1";
const STATIC = import.meta.dir + "/static";

// Europe/Zurich offset: CEST between last Sunday of March and last Sunday of October.
function lastSunday(y: number, m: number) { const d = new Date(Date.UTC(y, m + 1, 0)); d.setUTCDate(d.getUTCDate() - d.getUTCDay()); return d; }
function off(y: number, mo: number, d: number) { const t = Date.UTC(y, mo - 1, d); return t >= lastSunday(y, 2).getTime() && t < lastSunday(y, 9).getTime() ? "+02:00" : "+01:00"; }
const p2 = (n: number) => String(n).padStart(2, "0");
const ymd = (y: number, m: number, d: number) => `${y}-${p2(m)}-${p2(d)}`;
const at = (date: string, hm: string) => { const [y, m, d] = date.split("-").map(Number); return `${date}T${hm}:00${off(y, m, d)}`; };

const SCHOOL = "sch-bfs";
const ME = "su-mia";
const APP_USER = "au-mia";
const ACC = "acc-portal";
const BASE = "/api/plugins/schulportal";

const classes = [
  { id: "cls-mat", name: "Mathematik" },
  { id: "cls-eng", name: "Englisch" },
  { id: "cls-abu", name: "Allgemeinbildung" },
  { id: "cls-m164", name: "Modul 164 Datenbanken erstellen" },
  { id: "cls-m223", name: "Modul 223 Multi-User-Applikationen" },
  { id: "cls-spo", name: "Sport" },
  { id: "cls-m162", name: "Modul 162 Daten analysieren" },
];
const currentClassIds = ["cls-mat", "cls-eng", "cls-abu", "cls-m164", "cls-m223", "cls-spo"];

const teachers = [
  { code: "KeTh", firstName: "Thomas", lastName: "Keller" },
  { code: "BrCl", firstName: "Claire", lastName: "Brunner" },
  { code: "MeLu", firstName: "Lukas", lastName: "Meier" },
  { code: "HuSa", firstName: "Sandra", lastName: "Huber" },
  { code: "StRe", firstName: "Reto", lastName: "Steiner" },
  { code: "FrMa", firstName: "Marco", lastName: "Frei" },
].map((t, i) => ({ id: `t-${i}`, schoolId: SCHOOL, schoolName: "Berufsfachschule Beispielstadt", ...t }));
const tName = (code: string) => { const t = teachers.find((x) => x.code === code)!; return `${t.lastName} ${t.firstName} (${t.code})`; };

// Weekly timetable: Tuesday and Friday are school days.
type Slot = { from: string; to: string; cls: string; title: string; room: string; teacher: string };
const week: Record<number, Slot[]> = {
  2: [
    { from: "08:15", to: "09:50", cls: "cls-m164", title: "M164 Datenbanken", room: "C311", teacher: "HuSa" },
    { from: "10:10", to: "11:45", cls: "cls-eng", title: "Englisch", room: "B112", teacher: "BrCl" },
    { from: "12:45", to: "14:20", cls: "cls-spo", title: "Sport", room: "Turnhalle 2", teacher: "FrMa" },
  ],
  5: [
    { from: "08:15", to: "09:50", cls: "cls-mat", title: "Mathematik", room: "B204", teacher: "KeTh" },
    { from: "10:10", to: "11:45", cls: "cls-m223", title: "M223 Multi-User-Apps", room: "C312", teacher: "StRe" },
    { from: "12:45", to: "14:20", cls: "cls-abu", title: "Allgemeinbildung", room: "A105", teacher: "MeLu" },
    { from: "14:30", to: "15:15", cls: "cls-abu", title: "Klassenstunde", room: "A105", teacher: "MeLu" },
  ],
};
const holidays = [
  { id: "h-herbst", title: "Herbstferien", from: "2026-09-28", to: "2026-10-09" },
  { id: "h-weihnacht", title: "Weihnachtsferien", from: "2026-12-21", to: "2027-01-01" },
  { id: "h-sport", title: "Sportferien", from: "2027-02-08", to: "2027-02-19" },
];
// Tests replace the lesson in their slot; key = date|from.
const tests: Record<string, { title: string; description?: string }> = {
  "2026-11-06|12:45": { title: "ABU – Test Mietrecht" },
  "2026-11-10|10:10": { title: "Englisch – Vocabulary Unit 5" },
  "2026-11-13|08:15": { title: "Mathematik – Prüfung Funktionen" },
  "2026-11-17|08:15": { title: "M164 – LB3 Datenbankprojekt" },
  "2026-11-20|10:10": { title: "M223 – LB2 Transaktionen" },
};
const events = [
  { id: "ev-messe", title: "Exkursion Berufsmesse", date: "2026-11-24", from: "08:15", to: "15:00", place: "Messezentrum Beispielstadt", cls: null },
  { id: "ev-eltern", title: "Elternabend 2. Lehrjahr", date: "2026-11-19", from: "19:00", to: "20:30", place: "Aula", cls: null },
];

function inHoliday(date: string) { return holidays.some((h) => date >= h.from && date <= h.to); }

const agenda: any[] = [];
for (let t = Date.UTC(2026, 7, 17); t <= Date.UTC(2026, 11, 18); t += 86400000) {
  const d = new Date(t);
  const date = ymd(d.getUTCFullYear(), d.getUTCMonth() + 1, d.getUTCDate());
  const slots = week[d.getUTCDay()];
  if (!slots || inHoliday(date)) continue;
  for (const s of slots) {
    const test = tests[`${date}|${s.from}`];
    agenda.push({
      id: `ag-${date}-${s.from}`,
      entryType: test ? "Test" : "Lesson",
      title: test ? test.title : s.title,
      description: tName(s.teacher),
      place: s.room,
      date: at(date, s.from),
      endDate: at(date, s.to),
      classId: s.cls,
      schoolId: SCHOOL,
      schoolUserId: ME,
    });
  }
}
for (const e of events) agenda.push({ id: e.id, entryType: "Event", title: e.title, place: e.place, date: at(e.date, e.from), endDate: at(e.date, e.to), schoolId: SCHOOL, schoolUserId: ME });
for (const h of holidays) agenda.push({ id: h.id, entryType: "Holiday", title: h.title, date: at(h.from, "00:00"), endDate: at(h.to, "23:59"), schoolId: SCHOOL });

// Exams and Mia's grades.
const examDefs: [string, string, string, number, number, number, string?][] = [
  // id, class, name, date, score, classAverage, weighting, description
  ["ex-mat-1", "cls-mat", "Lineare Gleichungssysteme", "2026-09-04", 4.5, 4.4, 1],
  ["ex-mat-2", "cls-mat", "Potenzen und Wurzeln", "2026-10-16", 5.0, 4.6, 1],
  ["ex-mat-3", "cls-mat", "Kurztest Funktionen", "2026-10-30", 3.75, 4.1, 0.5],
  ["ex-eng-1", "cls-eng", "Vocabulary Test Unit 3", "2026-09-08", 5.5, 4.9, 0.5],
  ["ex-eng-2", "cls-eng", "Reading Comprehension", "2026-10-20", 5.0, 4.7, 1],
  ["ex-eng-3", "cls-eng", "Vocabulary Test Unit 4", "2026-11-03", 6, 5.0, 0.5],
  ["ex-abu-1", "cls-abu", "Vertragsrecht", "2026-09-11", 4.75, 4.5, 1],
  ["ex-abu-2", "cls-abu", "Präsentation Steuern", "2026-10-23", 5.25, 5.0, 1],
  ["ex-m164-1", "cls-m164", "LB1 ERD und Normalisierung", "2026-09-15", 5.5, 4.8, 1],
  ["ex-m164-2", "cls-m164", "LB2 SQL-Abfragen", "2026-11-03", 5.0, 4.6, 1],
  ["ex-m223-1", "cls-m223", "LB1 Mehrbenutzer-Konzept", "2026-10-16", 5.25, 4.9, 1],
  ["ex-spo-1", "cls-spo", "Ausdauerlauf 12 Minuten", "2026-09-22", 5.5, 5.0, 1],
  // 2. semester 25/26
  ["ex-mat-0", "cls-mat", "Bruchrechnen und Terme", "2026-03-13", 5.0, 4.5, 1],
  ["ex-eng-0", "cls-eng", "Grammar Test Tenses", "2026-04-21", 4.5, 4.4, 1],
  ["ex-abu-0", "cls-abu", "Arbeitsvertrag", "2026-05-29", 5.5, 4.8, 1],
  ["ex-m162-0", "cls-m162", "LB1 Datenmodelle", "2026-06-16", 5.0, 4.7, 1],
];
const descriptions: Record<string, string> = {
  "ex-mat-3": "Lineare und quadratische Funktionen, Scheitelpunktform",
  "ex-m164-2": "SELECT, JOIN, GROUP BY und Unterabfragen",
  "ex-eng-3": "Unit 4: Work and careers",
  "ex-abu-2": "Gruppenpräsentation zur Steuererklärung",
};
const grades = examDefs.map(([id, , , , score, , w]) => ({ id: `g-${id}`, score, weighting: w, examId: id, schoolUserId: ME }));
const exams = examDefs.map(([id, cls, name, date, , avg]) => ({ id, name, description: descriptions[id] ?? null, type: "Classic", date, classAverage: avg, classId: cls, schoolId: SCHOOL, grades: [] }));

const absences = [
  { id: "ab-1", reason: "Krankheit", type: "Absence", from: at("2026-11-03", "08:15"), until: at("2026-11-03", "14:20"), isExcused: false, schoolUserId: ME, schoolId: SCHOOL },
  { id: "ab-2", reason: "Zug verspätet", type: "Delay", from: at("2026-10-20", "08:15"), until: at("2026-10-20", "08:35"), isExcused: true, schoolUserId: ME, schoolId: SCHOOL },
  { id: "ab-3", reason: "Arzttermin", type: "Absence", from: at("2026-10-13", "10:10"), until: at("2026-10-13", "11:45"), isExcused: true, schoolUserId: ME, schoolId: SCHOOL },
  { id: "ab-5", reason: "Zahnarzt", type: "Absence", from: at("2026-09-15", "10:10"), until: at("2026-09-15", "11:45"), isExcused: true, schoolUserId: ME, schoolId: SCHOOL },
  { id: "ab-6", reason: "Bus verpasst", type: "Delay", from: at("2026-08-25", "08:15"), until: at("2026-08-25", "08:25"), isExcused: true, schoolUserId: ME, schoolId: SCHOOL },
  { id: "ab-4", reason: "Grippe", type: "Absence", from: at("2026-09-01", "08:15"), until: at("2026-09-04", "15:15"), isExcused: true, schoolUserId: ME, schoolId: SCHOOL },
];
if (EXTRAS) {
  Object.assign(absences.find((a) => a.id === "ab-1")!, { parentStatus: "ofAge", trainerStatus: "open", comment: "Arztzeugnis liegt bei", excuseDeadline: "2026-11-17", lessons: 6 });
  absences.push(
    { id: "ab-7", reason: "Familiäre Gründe", type: "Absence", from: at("2026-11-06", "12:45"), until: at("2026-11-06", "15:15"), isExcused: false, schoolUserId: ME, schoolId: SCHOOL, parentStatus: "ofAge", trainerStatus: "declined", trainerComment: "Bitte vorher absprechen", lessons: 3 } as any,
    { id: "ab-8", reason: "Krankheit", type: "Absence", from: at("2026-11-09", "08:15"), until: at("2026-11-09", "15:15"), isExcused: false, schoolUserId: ME, schoolId: SCHOOL, excuseDeadline: "2026-11-23", lessons: 7 } as any,
  );
  for (const a of absences) if (a.isExcused && !(a as any).lessons && a.type === "Absence") (a as any).lessons = 2;
}
const reported = [
  { ids: ["rep-1", "rep-2"], dateFrom: "2026-11-10", dateTo: "2026-11-10", hourFrom: "08:15", hourTo: "11:45", reason: "Arzttermin", comment: "Zeugnis folgt", profiles: ["M164", "Englisch"], reportedAt: at("2026-11-05", "18:12") },
];

const classmates = [
  ["Luca", "Baumann"], ["Noah", "Fischer"], ["Lea", "Gerber"], ["Elena", "Schmid"], ["Jan", "Weber"], ["Sara", "Rossi"], ["Timo", "Zürcher"], ["Nina", "Frei"], ["Mia", "Muster"], ["Jonas", "Ammann"], ["Aline", "Kälin"], ["David", "Hofmann"],
].map(([f, l], i) => ({ id: l === "Muster" ? ME : `cm-${i}`, schoolId: SCHOOL, firstName: f, lastName: l, profilePictureUrl: l === "Muster" ? "/static/mia.jpg" : null, role: "Student", absences: [], grades: [] }));

const myClasses = currentClassIds.map((id) => ({ classId: id, className: classes.find((c) => c.id === id)!.name }));
const schoolUser = {
  id: ME, applicationUserId: APP_USER, schoolId: SCHOOL, schoolName: "Berufsfachschule Beispielstadt",
  firstName: "Mia", lastName: "Muster", email: "mia.muster@bfs-beispielstadt.ch", profilePictureUrl: "/static/mia.jpg",
  entryDate: "2025-08-11", role: "Student", state: "Active",
  absences, grades, classes: myClasses,
};
const classDtos = classes.map((c) => ({ id: c.id, name: c.name, description: null, schoolId: SCHOOL, schoolName: "Berufsfachschule Beispielstadt", students: [], agenda: [], exams: exams.filter((e) => e.classId === c.id) }));

const documents = [
  { id: "doc-1", schoolUserId: ME, title: "Semesterzeugnis 2. Semester 25/26", category: "Zeugnis", enteredBy: "Sekretariat", fileName: "Zeugnis_2_25-26.pdf", fileSizeBytes: 184320, createdAt: at("2026-07-03", "10:00") },
  { id: "doc-2", schoolUserId: ME, title: "Bestätigung Lehrverhältnis", category: "Bestätigung", enteredBy: "Sekretariat", fileName: "Bestaetigung.pdf", fileSizeBytes: 92160, createdAt: at("2026-08-17", "09:30") },
];

let picture: string | null = "/static/mia.jpg";
let uploaded: { bytes: Uint8Array; type: string } | null = null;
let pictureVersion = 0;

const nowIso = () => new Date().toISOString();
const minutesAgo = (m: number) => new Date(Date.now() - m * 60000).toISOString();
const linkedAccount = () => ({
  providerId: "schulportal", providerName: "Schulportal", id: ACC, title: "Berufsfachschule Beispielstadt", detail: "mia.muster", status: "ok",
  linkedAt: "2025-08-20T08:00:00Z", lastSyncedAt: minutesAgo(12), canReauth: true,
  capabilities: [{ kind: "school_data", label: "School data" }, { kind: "absence_reporting", label: "Absence reporting", basePath: `${BASE}/accounts` }],
});

const MS_ACC = "acc-ms";
const microsoftAccount = () => ({
  providerId: "microsoft", providerName: "Microsoft", id: MS_ACC, title: "mia.muster@bfs-beispielstadt.ch", detail: "Mia Muster", status: "ok",
  pictureUrl: `/api/avatars/accounts/${MS_ACC}?v=1`,
  linkedAt: "2026-09-01T08:00:00Z", lastSyncedAt: minutesAgo(5), canReauth: true,
  capabilities: [{ kind: "mail", label: "Mail" }, { kind: "calendar", label: "Calendar", basePath: "/api/plugins/microsoft/calendar" }],
});
const providers = () => [
  { id: "schulportal", displayName: "Schulportal", description: "Grades, timetable and absences from your school", icon: { lucide: "graduation-cap" }, capabilities: [{ kind: "school_data", label: "School data" }, { kind: "absence_reporting", label: "Absence reporting" }], flows: [], sortOrder: 0 },
  ...(EXTRAS ? [
    { id: "schulnetz", displayName: "Schulnetz", description: "Noten, Stundenplan und Absenzen", icon: { lucide: "graduation-cap" }, capabilities: [], flows: [{ id: "schulnetz", label: "Schulnetz" }], sortOrder: 1 },
    { id: "odaorg", displayName: "OdA Org", description: "Überbetriebliche Kurse", icon: { lucide: "book-open" }, capabilities: [], flows: [{ id: "credentials", label: "OdA Org" }], sortOrder: 2 },
    { id: "microsoft", displayName: "Microsoft", description: "Mail, Teams und Kalender", icon: { lucide: "layout-grid" }, capabilities: [{ kind: "calendar", label: "Calendar" }], flows: [{ id: "web", label: "Microsoft" }], sortOrder: 3 },
  ] : []),
];
// The week of Tue 10.11.2026, Mia's Outlook calendar.
const outlookEvents = [
  { id: "ev1", title: "Lernpartnerschaft Mathe", start: at("2026-11-10", "15:00"), end: at("2026-11-10", "16:00"), isAllDay: false, location: "Microsoft Teams-Besprechung", organizer: "Luca Baumann", preview: "Wir gehen die Aufgaben zu den Funktionen durch.", webLink: "https://outlook.office.com/calendar/item/ev1", joinUrl: "https://teams.microsoft.com/l/meetup-join/ev1" },
  { id: "ev2", title: "Zahnarzt", start: at("2026-11-10", "17:30"), end: at("2026-11-10", "18:00"), isAllDay: false, location: "Praxis Beispielstadt", organizer: null, preview: null, webLink: "https://outlook.office.com/calendar/item/ev2", joinUrl: null },
  { id: "ev3", title: "Projektabgabe M164", start: "2026-11-12", end: "2026-11-13", isAllDay: true, location: null, organizer: "Sandra Huber", preview: "Abgabe über Teams bis 23:59.", webLink: "https://outlook.office.com/calendar/item/ev3", joinUrl: null },
  { id: "ev4", title: "Training", start: at("2026-11-13", "18:00"), end: at("2026-11-13", "19:30"), isAllDay: false, location: "Sporthalle", organizer: null, preview: null, webLink: "https://outlook.office.com/calendar/item/ev4", joinUrl: null },
].map((e) => ({ ...e, accountId: MS_ACC, showAs: "busy", isCancelled: false }));

// A made-up Lernendenausweis shaped like the Schulnetz one: elements placed absolutely with inline CSS, `data:` images,
// and taller than a phone's card area, so the page has to show all of it.
const qr = (() => {
  let cells = "";
  for (let y = 0; y < 25; y++) for (let x = 0; x < 25; x++) {
    const finder = (a: number, b: number) => a >= 0 && a < 7 && b >= 0 && b < 7 && (a === 0 || a === 6 || b === 0 || b === 6 || (a > 1 && a < 5 && b > 1 && b < 5));
    if (finder(x, y) || finder(x - 18, y) || finder(x, y - 18) || (!(x < 8 && y < 8) && !(x > 16 && y < 8) && !(x < 8 && y > 16) && (x * 7 + y * 13 + x * y) % 3 === 0)) cells += `<rect x="${x}" y="${y}" width="1" height="1"/>`;
  }
  return "data:image/svg+xml;base64," + Buffer.from(`<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 25 25">${cells}</svg>`).toString("base64");
})();
const studentIdCardHtml = async () => {
  const photo = "data:image/jpeg;base64," + Buffer.from(await Bun.file(STATIC + "/mia.jpg").arrayBuffer()).toString("base64");
  const t = "position:absolute;font-family:Arial,sans-serif;color:#111;";
  return `<div style="position:absolute;left:0;top:0;width:340px;height:44px;background:#0b5394"></div>`
    + `<div style="${t}left:16px;top:12px;font-size:16px;font-weight:bold;color:#fff">Lernendenausweis 2026/27</div>`
    + `<div style="${t}left:16px;top:60px;font-size:13px">Berufsfachschule Beispielstadt</div>`
    + `<img src="${photo}" style="position:absolute;left:16px;top:90px;width:150px;height:200px;object-fit:cover">`
    + `<div style="${t}left:16px;top:306px;font-size:11px;color:#555">Name</div><div style="${t}left:16px;top:322px;font-size:18px;font-weight:bold">Muster</div>`
    + `<div style="${t}left:16px;top:352px;font-size:11px;color:#555">Vorname</div><div style="${t}left:16px;top:368px;font-size:18px;font-weight:bold">Mia</div>`
    + `<div style="${t}left:16px;top:398px;font-size:11px;color:#555">Geburtsdatum</div><div style="${t}left:16px;top:414px;font-size:15px">14.03.2009</div>`
    + `<div style="${t}left:16px;top:442px;font-size:11px;color:#555">Ausbildung</div><div style="${t}left:16px;top:458px;font-size:15px">Informatikerin EFZ</div>`
    + `<img src="${qr}" style="position:absolute;left:70px;top:496px;width:200px;height:200px">`
    + `<div style="${t}left:16px;top:712px;font-size:12px;color:#555">Gültig bis 31.07.2027</div>`
    + `<div style="position:absolute;left:0;top:740px;width:340px;height:16px;background:#0b5394"></div>`;
};

// SLOW=<ms> holds back the student ID card and the picture upload, to see their spinners.
const slow = () => Bun.sleep(Number(process.env.SLOW ?? 0));

const tokens = () => ({ access_token: "fake-access-" + Date.now(), refresh_token: "fake-refresh", expires_in: 86400, token_type: "Bearer" });

const routes: Record<string, (req: Request, url: URL) => any> = {
  "GET /api/app": () => ({ registrationEnabled: true, version: "3.2.0", policyVersion: "2026-05", policyUrl: "https://schuly.dev/en/privacy", swissSchoolConfirmationRequired: false }),
  "GET /api/app/school-systems": () => [{ key: "schulportal", displayName: "Schulportal", loginMethod: "credentials", enabled: true, sortOrder: 0, pluginBasePath: BASE, loginFields: [] }],
  "GET /auth/providers": () => (EXTRAS ? [{ key: "microsoft", display_name: "Microsoft", icon_url: null }] : []),
  "POST /auth/login": () => tokens(),
  "POST /auth/refresh": () => tokens(),
  "POST /auth/logout": () => null,
  "GET /api/Auth/me": () => ({ id: APP_USER, externalId: "mia.muster", email: "mia.muster@bfs-beispielstadt.ch", displayName: "Mia Muster", profilePictureUrl: picture, createdAt: "2025-08-20T08:00:00Z", schoolUsers: [{ id: ME, firstName: "Mia", lastName: "Muster", email: "mia.muster@bfs-beispielstadt.ch", role: "Student" }] }),
  "GET /api/Auth/me/privacy-notice": () => ({ policyVersion: "2026-05", policyUrl: "https://schuly.dev/en/privacy", acceptanceRequired: false, swissSchoolConfirmationRequired: false, acceptedVersion: "2026-05", acceptedAt: "2026-05-12T07:00:00Z", swissSchoolConfirmedAt: "2026-05-12T07:00:00Z" }),
  "GET /api/Schools/my-schools": () => [
    { id: SCHOOL, name: "BFS Beispielstadt", fullName: "Berufsfachschule Beispielstadt", email: "mia.muster@bfs-beispielstadt.ch", logoUrl: null, schoolSystemKey: "schulportal", profilePictureUrl: "/static/mia.jpg" },
    // Two more schools for the Schools sheet: one with a bundled logo and a picture, one with the logo only.
    ...(EXTRAS ? [
      { id: "sch-bms", name: "BMS Beispielstadt", fullName: "Berufsmaturitätsschule Beispielstadt", email: "mia.muster@bms-beispielstadt.ch", logoUrl: null, schoolSystemKey: "schulnetz", profilePictureUrl: "/static/mia.jpg" },
      { id: "sch-uek", name: "üK Beispielstadt", fullName: "Überbetriebliche Kurse Beispielstadt", email: "mia.muster@uek-beispielstadt.ch", logoUrl: null, schoolSystemKey: "odaorg", profilePictureUrl: null },
    ] : []),
  ],
  "GET /api/SchoolUsers": () => [schoolUser],
  "GET /api/Exams": () => exams,
  "GET /api/Agendas": () => agenda,
  "GET /api/Absences": () => absences,
  "GET /api/Class": () => classDtos,
  "GET /api/Class/search": (_r, u) => { const c = classDtos.find((x) => x.id === u.searchParams.get("classId")); return c ? { ...c, students: classmates, agenda: agenda.filter((a) => a.classId === c.id) } : null; },
  "GET /api/SemesterReports": () => [],
  "GET /api/Teachers": () => teachers,
  "GET /api/documents": () => documents,
  "GET /api/notifications/preferences": () => ({ grades: true, absences: true, agenda: true, includeGradeValue: true, includeDetails: false }),
  "POST /api/notifications/devices": () => null,
  "GET /api/linking/providers": () => providers(),
  "GET /api/linking/accounts": () => (EXTRAS ? [linkedAccount(), microsoftAccount()] : [linkedAccount()]),
  "GET /api/plugins/microsoft/calendar": (_r, u) => {
    const start = Date.parse(u.searchParams.get("start") ?? ""), end = Date.parse(u.searchParams.get("end") ?? "");
    const events = outlookEvents.filter((e) => Date.parse(e.start) < end && Date.parse(e.end) > start);
    return { accounts: [{ id: MS_ACC, email: "mia.muster@bfs-beispielstadt.ch", displayName: "Mia Muster", status: "ok", message: null }], events };
  },
  "PUT /api/me/avatar": async (req) => {
    await slow();
    const form = await req.formData();
    const file = form.get("file") as File | null;
    if (!file) return new Response(JSON.stringify({ message: "no file" }), { status: 400 });
    uploaded = { bytes: new Uint8Array(await file.arrayBuffer()), type: file.type || "image/jpeg" };
    picture = `/static/upload?v=${++pictureVersion}`;
    console.log(`  avatar upload ${uploaded.bytes.length} bytes ${uploaded.type}`);
    return null;
  },
  // Like the server: pictures only with a bearer token.
  [`GET /api/avatars/accounts/${MS_ACC}`]: async (req) =>
    req.headers.get("authorization") ? new Response(Bun.file(STATIC + "/mia.jpg"), { headers: { "Content-Type": "image/jpeg", "Cache-Control": "private, max-age=3600" } }) : new Response("", { status: 401 }),
  "DELETE /api/me/avatar": () => { picture = null; uploaded = null; return null; },
  [`GET ${BASE}/accounts`]: () => [{ id: ACC, schoolUserId: ME }],
  [`GET ${BASE}/status`]: () => ({ version: "1.8.2" }),
  [`GET ${BASE}/accounts/${ACC}/sync`]: () => ({ lastSync: minutesAgo(12), syncStatus: "Up to date", syncError: null }),
  [`POST ${BASE}/accounts/${ACC}/sync`]: () => null,
  [`GET ${BASE}/accounts/${ACC}/absences/reported`]: () => reported,
  [`GET ${BASE}/accounts/${ACC}/student-id-card`]: async () => {
    await slow();
    return { html: await studentIdCardHtml(), fetchedAt: nowIso(), source: "mobile" };
  },
  [`GET ${BASE}/accounts/${ACC}/absences/reasons`]: () => ["Krankheit", "Arzttermin", "Unfall", "Familiäre Gründe", "Militär / Zivilschutz"],
};

Bun.serve({
  port: PORT,
  hostname: "0.0.0.0",
  async fetch(req) {
    const url = new URL(req.url);
    if (url.pathname.startsWith("/static/")) console.log(`${new Date().toISOString().slice(11, 19)} GET ${url.pathname} auth=${req.headers.get("authorization") ? "bearer" : "none"}`);
    if (EXTRAS && url.pathname.startsWith("/static/") && !req.headers.get("authorization")) return new Response("", { status: 401 });
    if (url.pathname === "/static/upload" && uploaded) return new Response(uploaded.bytes, { headers: { "Content-Type": uploaded.type } });
    if (url.pathname.startsWith("/static/")) {
      const f = Bun.file(STATIC + url.pathname.slice(7));
      return (await f.exists()) ? new Response(f, { headers: { "Content-Type": "image/jpeg" } }) : new Response("", { status: 404 });
    }
    const key = `${req.method} ${url.pathname}`;
    const h = routes[key];
    console.log(`${new Date().toISOString().slice(11, 19)} ${key}${h ? "" : "  <-- UNHANDLED"}`);
    if (!h) return new Response(JSON.stringify({ message: "not found" }), { status: 404, headers: { "Content-Type": "application/json" } });
    const body = await h(req, url);
    if (body === null) return new Response(null, { status: 204 });
    if (body instanceof Response) return body;
    return Response.json(body);
  },
});
console.log(`fake api on :${PORT}`);
