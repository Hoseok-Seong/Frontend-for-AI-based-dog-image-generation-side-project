class UserResetPasswordReq {
  final String username;

  UserResetPasswordReq({required this.username});

  factory UserResetPasswordReq.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordReq(
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}