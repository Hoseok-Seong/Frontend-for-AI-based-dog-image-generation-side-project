import 'package:json_annotation/json_annotation.dart';

part 'user_join_req.g.dart';

@JsonSerializable()
class UserJoinReq {
  final String username;
  final String password;

  UserJoinReq({required this.username, required this.password});

  factory UserJoinReq.fromJson(Map<String, dynamic> json) =>
      _$UserJoinReqFromJson(json);
  Map<String, dynamic> toJson() => _$UserJoinReqToJson(this);
}