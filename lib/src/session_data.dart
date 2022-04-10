import 'package:json_annotation/json_annotation.dart';

part 'session_data.g.dart';

@JsonSerializable()
class SessionData {
  SessionData({this.user});  

  factory SessionData.fromJson(Map<String, dynamic> json) => _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);


  String? user;
}