import 'package:json_annotation/json_annotation.dart';

part 'login_form.g.dart';

@JsonSerializable()
class FormData {
  String? email;
  String? password;

  FormData({
    this.email,
    this.password,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}
