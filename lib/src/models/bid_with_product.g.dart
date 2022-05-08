// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_with_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidWithProduct _$BidWithProductFromJson(Map<String, dynamic> json) =>
    BidWithProduct(
      bidder: User.fromJson(json['bidder'] as Map<String, dynamic>),
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$BidStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$BidWithProductToJson(BidWithProduct instance) =>
    <String, dynamic>{
      'bidder': instance.bidder.toJson(),
      'product': instance.product.toJson(),
      'amount': instance.amount,
      'status': _$BidStatusEnumMap[instance.status],
    };

const _$BidStatusEnumMap = {
  BidStatus.pending: 'pending',
  BidStatus.declined: 'declined',
  BidStatus.accepted: 'accepted',
};
