// class GalleriesResp {
//   final List<String> fileData;
//
//   GalleriesResp({required this.fileData});
//
//   factory GalleriesResp.fromJson(Map<String, dynamic> json) {
//     return GalleriesResp(
//       fileData: List<String>.from(json['fileData'] as List<dynamic>),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'fileData': fileData,
//     };
//   }
// }

class GalleriesResp {
  final List<String> imageUrls;

  GalleriesResp({required this.imageUrls});

  factory GalleriesResp.fromJson(Map<String, dynamic> json) {
    return GalleriesResp(
      imageUrls: List<String>.from(json['imageUrls'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrls': imageUrls,
    };
  }
}