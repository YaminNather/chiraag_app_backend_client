import 'package:json_annotation/json_annotation.dart';

import 'product.dart';
import 'order.dart';
import 'bid.dart';

part 'sold_item.g.dart';

@JsonSerializable(explicitToJson: true)
class SoldItem {
  const SoldItem(this.product, {this.bid, this.order});

  factory SoldItem.fromJson(Map<String, dynamic> json) => _$SoldItemFromJson(json);

  Map<String, dynamic> toJson() => _$SoldItemToJson(this);

  final Product product;
  final Bid? bid;
  final Order? order;
}