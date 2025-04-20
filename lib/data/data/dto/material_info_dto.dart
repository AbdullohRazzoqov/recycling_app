import 'package:recycling_app/data/domain/entities/material_info_entities.dart';

class MaterialInfoDto extends MaterialInfoEntities {
  final String material;
  final List<String> commonItems;
  final String symbol;
  final int code;

  MaterialInfoDto({
    required this.material,
    required this.commonItems,
    required this.symbol,
    required this.code,
  }) : super(
            material: material,
            commonItems: commonItems,
            symbol: symbol,
            code: code);
  factory MaterialInfoDto.fromMap(Map<String, dynamic> json) {
    return MaterialInfoDto(
        material: json['material'] ?? '',
        symbol: json['symbol'] ?? '',
        code: json['code'] ?? 0,
        commonItems: List<String>.from(json['common_items'] ?? []));
  }
}
