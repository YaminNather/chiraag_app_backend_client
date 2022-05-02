import 'package:chiraag_app_backend_client/src/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enums/order_status.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  const Order({required this.product, required this.purchasedBy, required this.amount, required this.deliverTo, required this.status});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);


  final Product product;
  final String purchasedBy;
  final double amount;
  final String deliverTo;
  final OrderStatus status;
}