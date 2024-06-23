class UserJoinReq {
  final String username;
  final String password;

  UserJoinReq({required this.username, required this.password});

  factory UserJoinReq.fromJson(Map<String, dynamic> json) {
    return UserJoinReq(
      username: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}