class Category {
  final String id;
  final String name;
  String thumbnail;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  // Factory constructor
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] ?? '',
      name: json['strCategory'] ?? '',
      thumbnail: json['strCategoryThumb'] ?? '',
      description: json['strCategoryDescription'] ?? '',
    );
  }

  // GETTER
  String get thumb => thumbnail;

  // SETTER
  set thumb(String value) {
    thumbnail = value;
  }
}
