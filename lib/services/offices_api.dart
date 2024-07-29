import 'package:test_flutter/models/office.dart';
import 'package:test_flutter/models/office_reponse.dart';
import 'package:test_flutter/services/http.dart';

Future<OfficeReponse> delete(String id) async {
  final response = await HttpClient().apiEndpoint.delete('/api/v1/offices/$id');

  if (response.statusCode == 204) {
    return OfficeReponse(success: true);
  } else {
    return OfficeReponse(success: false, error: response.statusMessage);
  }
}

Future<OfficeReponse> show(String id) async {
  final response = await HttpClient().apiEndpoint.get('/api/v1/offices/$id');

  if (response.statusCode == 200) {
    final office = Office.fromJson(response.data);
    return OfficeReponse(success: true, office: office);
  } else {
    throw Exception('Failed to load offices');
  }
}

Future<OfficeReponse> update(Office office) async {
  final response = await HttpClient()
      .apiEndpoint
      .put('/api/v1/offices/${office.id}', data: office.toJson());

  if (response.statusCode == 200) {
    final office = Office.fromJson(response.data);
    return OfficeReponse(success: true, office: office);
  } else {
    return OfficeReponse(success: false, error: response.statusMessage);
  }
}

Future<OfficeReponse> create(Office office) async {
  final response = await HttpClient()
      .apiEndpoint
      .post('/api/v1/offices', data: office.toJson());

  if (response.statusCode == 200) {
    final office = Office.fromJson(response.data);
    return OfficeReponse(success: true, office: office);
  } else {
    return OfficeReponse(success: false, error: response.statusMessage);
  }
}

Future<OfficeReponse> index() async {
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
    return OfficeReponse(success: true, offices: officesList);
  } else {
    return OfficeReponse(success: false, error: response.statusMessage);
  }
}
