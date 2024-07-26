// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      open: json['open'] as String,
      close: json['close'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'open': instance.open,
      'close': instance.close,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
