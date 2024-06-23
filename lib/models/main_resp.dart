class MainResp {
  final String gradeName;
  final String subscriptionName;
  final int usedGenerateCount;
  final int leftGenerateCount;
  final List<String> fileData;

  MainResp({
    required this.gradeName,
    required this.subscriptionName,
    required this.usedGenerateCount,
    required this.leftGenerateCount,
    required this.fileData,
  });

  factory MainResp.fromJson(Map<String, dynamic> json) {
    return MainResp(
      gradeName: json['gradeName'],
      subscriptionName: json['subscriptionName'],
      usedGenerateCount: json['usedGenerateCount'],
      leftGenerateCount: json['leftGenerateCount'],
      fileData: List<String>.from(json['fileData']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeName': gradeName,
      'subscriptionName': subscriptionName,
      'usedGenerateCount': usedGenerateCount,
      'leftGenerateCount': leftGenerateCount,
      'fileData': fileData,
    };
  }
}