// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      purchasedBy: json['purchasedBy'] as String,
      deliverTo: json['deliverTo'] as String,
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'product': instance.product.toJson(),
      'purchasedBy': instance.purchasedBy,
      'deliverTo': instance.deliverTo,
      'status': _$OrderStatusEnumMap[instance.status],
    };

const _$OrderStatusEnumMap = {
  OrderStatus.verifying: 'verifying',
  OrderStatus.delivering: 'delivering',
  OrderStatus.delivered: 'delivered',
};
