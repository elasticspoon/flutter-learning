import 'package:json_annotation/json_annotation.dart';

part 'office.g.dart';

@JsonSerializable()
class Office {
  String id, name, address, city, state, zip, open, close;

  double? latitude, longitude;

  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    this.latitude,
    this.longitude,
    required this.open,
    required this.close,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OfficeToJson(this);
}
