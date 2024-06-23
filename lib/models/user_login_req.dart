class UserLoginReq {
  final String username;
  final String password;

  UserLoginReq({required this.username, required this.password});

  factory UserLoginReq.fromJson(Map<String, dynamic> json) {
    return UserLoginReq(
      username: json['username'],
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