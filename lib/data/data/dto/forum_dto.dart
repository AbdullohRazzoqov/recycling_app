import 'package:recycling_app/data/domain/entities/forum_entities.dart';

class ForumDto extends ForumEntities {
  final List<String> faqs;
  final List<String> tips;

  ForumDto({required this.faqs, required this.tips})
      : super(faqs: faqs, tips: tips);

  factory ForumDto.fromMap(Map<String, dynamic> json) {
    return ForumDto(
      faqs: List<String>.from(json['faqs'] ?? ""),
      tips: List<String>.from(json['tips'] ?? []),
    );
  }
}
