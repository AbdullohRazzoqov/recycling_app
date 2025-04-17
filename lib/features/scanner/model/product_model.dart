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
      category: json['category'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      code: json['code'] as int,
    );
  }
}
