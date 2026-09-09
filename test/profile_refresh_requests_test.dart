import 'package:flutter_test/flutter_test.dart';
import 'package:schuly/services/profile_refresh_requests.dart';

void main() {
  setUp(() => ProfileRefreshRequests.clear());

  group('ProfileRefreshRequests', () {
    test('starts clear', () {
      expect(ProfileRefreshRequests.pending.value, isFalse);
    });

    test('request() sets the flag', () {
      ProfileRefreshRequests.request();
      expect(ProfileRefreshRequests.pending.value, isTrue);
    });

    test('clear() resets the flag', () {
      ProfileRefreshRequests.request();
      ProfileRefreshRequests.clear();
      expect(ProfileRefreshRequests.pending.value, isFalse);
    });

    test('notifies listeners on request and clear', () {
      final events = <bool>[];
      void listener() => events.add(ProfileRefreshRequests.pending.value);
      ProfileRefreshRequests.pending.addListener(listener);
      addTearDown(
        () => ProfileRefreshRequests.pending.removeListener(listener),
      );

      ProfileRefreshRequests.request();
      ProfileRefreshRequests.clear();

      expect(events, [true, false]);
    });
  });
}
