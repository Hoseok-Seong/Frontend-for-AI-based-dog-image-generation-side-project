class GalleriesResp {
  final List<String> fileData;

  GalleriesResp({required this.fileData});

  factory GalleriesResp.fromJson(Map<String, dynamic> json) {
    return GalleriesResp(
      fileData: List<String>.from(json['fileData'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileData': fileData,
    };
  }
}