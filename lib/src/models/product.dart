import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  const Product({
    required this.id, 
    required this.name, 
    required this.seller,
    required this.description,    
    required this.initialPrice,
    required this.createdAt,
    required this.mainImage,
    required this.images,
    required this.isAvailable
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);


  final String id;
  final String name;
  final String seller;
  final String description;  
  final double initialPrice;
  final DateTime createdAt;
  final String mainImage;
  final List<String>? images;
  final bool isAvailable;
}