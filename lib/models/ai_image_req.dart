class AIImageReq {
  final String breed;
  final String sizeDesc;
  final String coatLength;
  final String coatColor;
  final String furTexture;
  final String eyeColor;
  final String earShape;
  final String noseShape;
  final String faceShape;
  final String tailShape;
  final String expression;
  final String pose;

  AIImageReq({
    required this.breed,
    required this.sizeDesc,
    required this.coatLength,
    required this.coatColor,
    required this.furTexture,
    required this.eyeColor,
    required this.earShape,
    required this.noseShape,
    required this.faceShape,
    required this.tailShape,
    required this.expression,
    required this.pose,
  });

  Map<String, dynamic> toJson() {
    return {
      'breed': breed,
      'sizeDesc': sizeDesc,
      'coatLength': coatLength,
      'coatColor': coatColor,
      'furTexture': furTexture,
      'eyeColor': eyeColor,
      'earShape': earShape,
      'noseShape': noseShape,
      'faceShape': faceShape,
      'tailShape': tailShape,
      'expression': expression,
      'pose': pose,
    };
  }
}
