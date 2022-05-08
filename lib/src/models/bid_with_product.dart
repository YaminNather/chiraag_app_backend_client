import 'package:json_annotation/json_annotation.dart';
import '../enums/enums.dart';
import 'models.dart';

part 'bid_with_product.g.dart';

@JsonSerializable(explicitToJson: true)
class BidWithProduct {
  const BidWithProduct({
    required this.bidder,
    required this.product,
    required this.amount,
    required this.status
  });

  factory BidWithProduct.fromJson(Map<String, dynamic> json) => _$BidWithProductFromJson(json);

  Map<String, dynamic> toJson() => _$BidWithProductToJson(this);


  final User bidder;
  final Product product;
  final double amount;
  final BidStatus status;
}