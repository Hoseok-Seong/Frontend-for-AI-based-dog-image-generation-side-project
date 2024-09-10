class NewAccessTokenReq {
  final int userId;
  final String refreshToken;

  NewAccessTokenReq({required this.userId, required this.refreshToken});

  factory NewAccessTokenReq.fromJson(Map<String, dynamic> json) {
    return NewAccessTokenReq(
      userId: json['userId'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'refreshToken': refreshToken,
    };
  }
}