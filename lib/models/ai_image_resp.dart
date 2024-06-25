class AIImageResp {
  final String imageUrl;

  AIImageResp({required this.imageUrl});

  factory AIImageResp.fromJson(Map<String, dynamic> json) {
    return AIImageResp(
      imageUrl: json['imageUrl'],
    );
  }
}
