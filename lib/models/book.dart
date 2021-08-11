class Book {
  final String id;
  final String name;
  final String author;
  final String category;
  final double price;
  final String description;
  final List<String> images;
  final String userId;
  final bool isNewBook;
  final bool isAvailableForExchange;

  Book({
    this.id,
    this.name,
    this.author,
    this.category,
    this.price,
    this.description,
    this.images,
    this.userId,
    this.isNewBook,
    this.isAvailableForExchange,
  });

  // json file to object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      name: json['name'],
      author: json['author'],
      category: json['category'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      images: new List<String>.from(json['images']),
      userId: json['userId'],
      isNewBook: json['isNewBook'],
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
        'isNewBook': isNewBook,
        'isAvailableForExchange': isAvailableForExchange,
      };
}
