// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      name: json['name'] as String,
      seller: User.fromJson(json['seller'] as Map<String, dynamic>),
      description: json['description'] as String,
      initialPrice: (json['initialPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      mainImage: json['mainImage'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isAvailable: json['isAvailable'] as bool,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seller': instance.seller.toJson(),
      'description': instance.description,
      'initialPrice': instance.initialPrice,
      'createdAt': instance.createdAt.toIso8601String(),
      'mainImage': instance.mainImage,
      'images': instance.images,
      'isAvailable': instance.isAvailable,
    };
