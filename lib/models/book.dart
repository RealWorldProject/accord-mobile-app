class Book {
  final String id;
  final String name;
  final String author;
  final String category;
  final double price;
  final String description;
  final String images;
  final bool isNew;
  final bool isAvailableForExchange;

  Book({
    this.id,
    this.name,
    this.author,
    this.category,
    this.price,
    this.description,
    this.images,
    this.isNew,
    this.isAvailableForExchange,
  });

  // json file to object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      name: json['name'],
      author: json['author'],
      category: json['category'],
      price: json['price'],
      description: json['description'],
      images: json['images'],
      isNew: json['isNew'],
      isAvailableForExchange: json['isAvailableForExchange'],
    );
  }

  // object to json file
  Map<String, dynamic> toJson() => {
        'name': name,
        'author': author,
        'category': category,
        'price': price,
        'description': description,
        'images': images,
        'isNew': isNew,
        'isAvailableForExchange': isAvailableForExchange,
      };
}
