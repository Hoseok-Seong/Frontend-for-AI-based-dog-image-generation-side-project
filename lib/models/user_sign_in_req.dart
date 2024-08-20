class UserSignInReq {
  final String username;
  final String password;

  UserSignInReq({required this.username, required this.password});

  factory UserSignInReq.fromJson(Map<String, dynamic> json) {
    return UserSignInReq(
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