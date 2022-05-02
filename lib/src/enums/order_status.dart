import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  verifying,
  verified,
  @JsonValue('checked_out')
  checkedOut,
  delivered
}