class Category {
  final int categoryId;
  final String name;
  final String imageUrl;

  Category({
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
