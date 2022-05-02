import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  const Address({required this.building, required this.street, required this.city, required this.state});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {    
    return '$building\n$street\n$city\n$state';
  }


  final String building;
  final String street;
  final String city;
  final String state;
}