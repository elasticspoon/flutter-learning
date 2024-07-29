import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/services/http.dart';

Future<void> delete(String id) async {
  final response = await HttpClient().apiEndpoint.delete('/api/v1/offices/$id');

  if (response.statusCode == 204) {
    return;
  } else {
    throw Exception('Failed to load offices');
  }
}

Future<Office?> show(String id) async {
  final response = await HttpClient().apiEndpoint.get('/api/v1/offices/$id');

  if (response.statusCode == 200) {
    return Office.fromJson(response.data);
  } else {
    throw Exception('Failed to load offices');
  }
}

Future<String?> update(Office office) async {
  final response = await HttpClient()
      .apiEndpoint
      .put('/api/v1/offices/${office.id}', data: office.toJson());

  if (response.statusCode == 200) {
    return Office.fromJson(response.data).id;
  } else {
    throw Exception('Failed to load offices');
  }
}

Future<String?> create(Office office) async {
  final response = await HttpClient()
      .apiEndpoint
      .post('/api/v1/offices', data: office.toJson());

  if (response.statusCode == 200) {
    return Office.fromJson(response.data).id;
  } else {
    throw Exception('Failed to load offices');
  }
}

Future<List<Office?>> index() async {
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
