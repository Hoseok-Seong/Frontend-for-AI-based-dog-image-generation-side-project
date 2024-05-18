// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginReq _$UserLoginReqFromJson(Map<String, dynamic> json) => UserLoginReq(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginReqToJson(UserLoginReq instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
