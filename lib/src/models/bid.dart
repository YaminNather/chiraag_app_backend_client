import 'package:json_annotation/json_annotation.dart';

import '../enums/enums.dart';

part 'bid.g.dart';

@JsonSerializable()
class Bid {
  const Bid({required this.bidder, required this.productId, required this.amount, required this.status});

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);

  Map<String, dynamic> toJson() => _$BidToJson(this);


  
  final String bidder;
  final String productId;
  final double amount;
  final BidStatus status;
}