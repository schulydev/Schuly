import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for SchoolSystemsApi
void main() {
  final instance = SchulyApi().getSchoolSystemsApi();

  group(SchoolSystemsApi, () {
    //Future<BuiltList<SchoolSystemDto>> apiSchoolSystemsGet() async
    test('test apiSchoolSystemsGet', () async {
      // TODO
    });

    //Future apiSchoolSystemsIdDelete(String id) async
    test('test apiSchoolSystemsIdDelete', () async {
      // TODO
    });

    //Future<SchoolSystemDto> apiSchoolSystemsIdGet(String id) async
    test('test apiSchoolSystemsIdGet', () async {
      // TODO
    });

    //Future<String> apiSchoolSystemsPost(CreateSchoolSystemCommand createSchoolSystemCommand) async
    test('test apiSchoolSystemsPost', () async {
      // TODO
    });

    //Future apiSchoolSystemsPut(UpdateSchoolSystemCommand updateSchoolSystemCommand) async
    test('test apiSchoolSystemsPut', () async {
      // TODO
    });

  });
}
