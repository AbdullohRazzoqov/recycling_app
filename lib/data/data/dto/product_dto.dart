import 'package:recycling_app/data/domain/entities/product_entities.dart';

class ProductDto extends ProductEntities {
  final String category;
  final String name;
  final String symbol;
  final int code;

  ProductDto({
    required this.category,
    required this.name,
    required this.symbol,
    required this.code,
  }) : super(category: category, name: name, symbol: symbol, code: code);
  factory ProductDto.fromMap(Map<String, dynamic> json) {
    return ProductDto(
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      code: json['code'] ?? 0,
    );
  }
}
