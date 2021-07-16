class Book {
  final String id;
  final String name;
  final String images;
  final String description;
  final String author;
  final String category;
  final bool isNew;
  final bool isAvailableForExchange;

  Book({
    this.id,
    this.name,
    this.images,
    this.description,
    this.author,
    this.category,
    this.isNew,
    this.isAvailableForExchange,
  });

  // json file to object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      name: json['name'],
      images: json['images'],
      description: json['description'],
      author: json['author'],
      category: json['category'],
      isNew: json['isNew'],
      isAvailableForExchange: json['isAvailableForExchange'],
    );
  }

  // object to json file
  Map<String, dynamic> toJson() => {
        'name': name,
        'images': images,
        'description': description,
        'author': author,
        'category': category,
        'isNew': isNew,
        'isAvailableForExchange': isAvailableForExchange,
      };
}
