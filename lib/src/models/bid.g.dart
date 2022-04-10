// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bid _$BidFromJson(Map<String, dynamic> json) => Bid(
      bidder: json['bidder'] as String,
      productId: json['productId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: $enumDecode(_$BidStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$BidToJson(Bid instance) => <String, dynamic>{
      'bidder': instance.bidder,
      'productId': instance.productId,
      'amount': instance.amount,
      'status': _$BidStatusEnumMap[instance.status],
    };

const _$BidStatusEnumMap = {
  BidStatus.pending: 'pending',
  BidStatus.declined: 'declined',
  BidStatus.accepted: 'accepted',
};
