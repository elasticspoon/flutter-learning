import 'package:test_flutter/models/office.dart';

class OfficeReponse {
  bool success;
  String? error;
  Office? office;
  List<Office?>? offices;

  OfficeReponse({required this.success, this.office, this.error, this.offices});
}
