import 'package:test/test.dart';
import 'package:schuly_api/schuly_api.dart';


/// tests for MeApi
void main() {
  final instance = SchulyApi().getMeApi();

  group(MeApi, () {
    //Future apiMeAvatarDelete() async
    test('test apiMeAvatarDelete', () async {
      // TODO
    });

    //Future apiMeAvatarPut({ MultipartFile file }) async
    test('test apiMeAvatarPut', () async {
      // TODO
    });

    //Future apiMeGradesIdDelete(String id) async
    test('test apiMeGradesIdDelete', () async {
      // TODO
    });

    //Future<String> apiMeGradesPost(AddMyGradeCommand addMyGradeCommand) async
    test('test apiMeGradesPost', () async {
      // TODO
    });

    //Future apiMeGradesPut(UpdateMyGradeCommand updateMyGradeCommand) async
    test('test apiMeGradesPut', () async {
      // TODO
    });

    //Future<String> apiMeSchoolsPost(CreateMySchoolCommand createMySchoolCommand) async
    test('test apiMeSchoolsPost', () async {
      // TODO
    });

  });
}
