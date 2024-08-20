class UserSignUpReq {
  final String username;
  final String password;

  UserSignUpReq({required this.username, required this.password});

  factory UserSignUpReq.fromJson(Map<String, dynamic> json) {
    return UserSignUpReq(
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