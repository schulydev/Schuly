import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for TrustedDevicesApi
void main() {
  final instance = SchulyApi().getTrustedDevicesApi();

  group(TrustedDevicesApi, () {
    // Revokes every device this user has trusted.
    //
    //Future toamaisutaaRevokeAllTrustedDevices() async
    test('test toamaisutaaRevokeAllTrustedDevices', () async {
      // TODO
    });

    // Revokes one device by its id.
    //
    // 404 covers both a device that does not exist and one belonging to someone else, so this cannot be used to discover another account's device ids.
    //
    //Future toamaisutaaRevokeTrustedDevice(String id) async
    test('test toamaisutaaRevokeTrustedDevice', () async {
      // TODO
    });

    // Lists the devices this user has trusted.
    //
    // Send the device token you are holding in an `X-Toamaisutaa-Device` header and the matching row comes back with `isCurrent` true, so a list can say \"this device\" rather than inviting somebody to revoke the one they are sitting at.
    //
    //Future<BuiltList<TrustedDeviceSummary>> toamaisutaaTrustedDevices() async
    test('test toamaisutaaTrustedDevices', () async {
      // TODO
    });

  });
}
