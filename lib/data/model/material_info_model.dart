class MaterialInfoModel {
  final String material;
  final List<String> commonItems;
  final String symbol;
  final int code;

  MaterialInfoModel({
    required this.material,
    required this.commonItems,
    required this.symbol,
    required this.code,
  });
  factory MaterialInfoModel.fromMap(Map<String, dynamic> json) {
    return MaterialInfoModel(
        material: json['material'] ?? '',
        symbol: json['symbol'] ?? '',
        code: json['code'] ?? 0,
        commonItems: List<String>.from(json['common_items'] ?? []));
  }
}
