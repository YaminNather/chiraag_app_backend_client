// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sold_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoldItem _$SoldItemFromJson(Map<String, dynamic> json) => SoldItem(
      Product.fromJson(json['product'] as Map<String, dynamic>),
      bid: json['bid'] == null
          ? null
          : Bid.fromJson(json['bid'] as Map<String, dynamic>),
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SoldItemToJson(SoldItem instance) => <String, dynamic>{
      'product': instance.product.toJson(),
      'bid': instance.bid?.toJson(),
      'order': instance.order?.toJson(),
    };
