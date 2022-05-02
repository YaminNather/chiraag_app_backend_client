// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      building: json['building'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'building': instance.building,
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
    };
