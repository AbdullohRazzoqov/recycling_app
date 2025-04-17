class ProductModel {
  final String category;
  final String name;
  final String symbol;
  final int code;

  ProductModel({
    required this.category,
    required this.name,
    required this.symbol,
    required this.code,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      code: json['code'] ?? 0,
    );
  }
}
