import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MainReq {
  final String username;
  final String password;

  MainReq({required this.username, required this.password});

  factory MainReq.fromJson(Map<String, dynamic> json) =>
      _$MainReqFromJson(json);
  Map<String, dynamic> toJson() => _$MainReqToJson(this);
}