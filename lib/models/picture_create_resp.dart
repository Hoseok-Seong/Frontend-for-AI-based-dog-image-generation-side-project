class Attribute {
  final String value;
  final String name;

  Attribute({required this.value, required this.name});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      value: json['value'],
      name: json['name'],
    );
  }
}

class PictureCreateResp {
  final List<Attribute>? breeds;
  final List<Attribute>? sizes;
  final List<Attribute>? coatLengths;
  final List<Attribute>? furTextures;
  final List<Attribute>? eyeColors;
  final List<Attribute>? earShapes;
  final List<Attribute>? noseShapes;
  final List<Attribute>? faceShapes;
  final List<Attribute>? tailShapes;
  final List<Attribute>? expressions;
  final List<Attribute>? poses;
  final List<Attribute>? coatColors;
  final List<Attribute>? themes;

  PictureCreateResp({
    this.breeds,
    this.sizes,
    this.coatLengths,
    this.furTextures,
    this.eyeColors,
    this.earShapes,
    this.noseShapes,
    this.faceShapes,
    this.tailShapes,
    this.expressions,
    this.poses,
    this.coatColors,
    this.themes
  });

  factory PictureCreateResp.fromJson(Map<String, dynamic> json) {
    return PictureCreateResp(
      breeds: (json['breeds'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      sizes: (json['sizes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      coatLengths: (json['coatLengths'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      furTextures: (json['furTextures'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      eyeColors: (json['eyeColors'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      earShapes: (json['earShapes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      noseShapes: (json['noseShapes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      faceShapes: (json['faceShapes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      tailShapes: (json['tailShapes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      expressions: (json['expressions'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      poses: (json['poses'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      coatColors: (json['coatColors'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
      themes: (json['themes'] as List?)?.map((i) => Attribute.fromJson(i)).toList(),
    );
  }
}