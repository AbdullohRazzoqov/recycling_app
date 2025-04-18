class CategoryModel {
  final String name;
  final String imageUrl;
  final int id;
  final String path;
  CategoryModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.path});

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        imageUrl: json['image_url'] ?? '',
        path: json['path'] ?? '');
  }
}
