import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class User {
  const User(this.id, this.username);

  final String id;
  final String username;
}