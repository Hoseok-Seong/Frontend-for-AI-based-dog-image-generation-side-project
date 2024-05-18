import 'package:json_annotation/json_annotation.dart';

part 'user_login_req.g.dart';

@JsonSerializable()
class UserLoginReq {
  final String username;
  final String password;

  UserLoginReq({required this.username, required this.password});

  factory UserLoginReq.fromJson(Map<String, dynamic> json) =>
      _$UserLoginReqFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginReqToJson(this);
}