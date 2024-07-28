import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/http.dart';
import 'package:test_flutter/services/user_auth.dart';

Future<List<Office?>> index(UserAuth auth) async {
  final response = await HttpClient().apiEndpoint.get(
        '/api/v1/offices',
      );

  if (response.statusCode == 200) {
    final offices = response.data['content'] as List<dynamic>;
    final officesList = offices.map((officeJson) {
      try {
        return Office.fromJson(officeJson as Map<String, dynamic>);
      } catch (e) {
        print(e);
      }
    }).toList();
    return officesList;
  } else {
    throw Exception('Failed to load offices');
  }
}
