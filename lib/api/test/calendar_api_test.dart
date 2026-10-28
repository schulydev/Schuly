import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for CalendarApi
void main() {
  final instance = SchulyApi().getCalendarApi();

  group(CalendarApi, () {
    //Future<MicrosoftCalendarFeed> apiPluginsMicrosoftCalendarGet({ DateTime start, DateTime end }) async
    test('test apiPluginsMicrosoftCalendarGet', () async {
      // TODO
    });

  });
}
