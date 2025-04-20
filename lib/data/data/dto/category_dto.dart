import 'package:recycling_app/data/domain/entities/category_entites.dart';

class CategoryDto extends CategoryEntites {
  final String name;
  final String imageUrl;
  final int id;
  final String path;
  CategoryDto(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.path})
      : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          path: path,
        );

  factory CategoryDto.fromMap(Map<String, dynamic> json) {
    return CategoryDto(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        imageUrl: json['image_url'] ?? '',
        path: json['path'] ?? '');
  }
}
