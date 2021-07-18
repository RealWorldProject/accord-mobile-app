class Category {
  final String id;
  final String category;
  final String slug;
  final String displayName;
  final String image;

  Category({
    this.id,
    this.category,
    this.slug,
    this.displayName,
    this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      category: json['category'],
      slug: json['slug'],
      displayName: json['displayName'],
      image: json['image'],
    );
  }
}
