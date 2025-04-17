class ForumModel {
  final List<String> faqs;
  final List<String> tips;

  ForumModel({required this.faqs, required this.tips});

  factory ForumModel.fromMap(Map<String, dynamic> json) {
    return ForumModel(
      faqs: List<String>.from(json['faqs']??""),
      tips: List<String>.from(json['tips']??[]),
    );
  }
}
