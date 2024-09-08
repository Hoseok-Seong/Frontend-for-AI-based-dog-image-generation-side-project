class AIImageReq {
  final String? breed;
  final String? sizeDesc;
  final String? coatLength;
  final String? coatColor;
  final String? furTexture;
  final String? eyeColor;
  final String? earShape;
  final String? noseShape;
  final String? faceShape;
  final String? tailShape;
  final String? expression;
  final String? pose;

  AIImageReq({
    this.breed,
    this.sizeDesc,
    this.coatLength,
    this.coatColor,
    this.furTexture,
    this.eyeColor,
    this.earShape,
    this.noseShape,
    this.faceShape,
    this.tailShape,
    this.expression,
    this.pose,
  });

  Map<String, dynamic> toJson() {
    return {
      'breed': breed ?? '',
      'sizeDesc': sizeDesc ?? '',
      'coatLength': coatLength ?? '',
      'coatColor': coatColor ?? '',
      'furTexture': furTexture ?? '',
      'eyeColor': eyeColor ?? '',
      'earShape': earShape ?? '',
      'noseShape': noseShape ?? '',
      'faceShape': faceShape ?? '',
      'tailShape': tailShape ?? '',
      'expression': expression ?? '',
      'pose': pose ?? '',
    };
  }
}