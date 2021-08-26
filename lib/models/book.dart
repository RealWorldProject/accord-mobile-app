import 'package:accord/models/category.dart';
import 'package:accord/models/user.dart';

class Book {
  final String id;
  final String name;
  final String author;
  final dynamic category;
  final double price;
  final int stock;
  final String description;
  final List<String> images;
  final dynamic userId;
  final double rating;
  final bool isNewBook;
  final bool isAvailableForExchange;

  Book({
    this.id,
    this.name,
    this.author,
    this.category,
    this.price,
    this.stock,
    this.description,
    this.images,
    this.userId,
    this.rating = 0,
    this.isNewBook,
    this.isAvailableForExchange,
  });

  // json file to object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['_id'],
      name: json['name'],
      author: json['author'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      price: json['category'] != null
          ? double.parse(json['price'].toString())
          : null,
      stock: json['stock'] ?? 0,
      description: json['description'],
      images:
          json['images'] != null ? new List<String>.from(json['images']) : null,
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      rating: double.parse(json['rating'].toString()),
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
        'stock': stock,
        'description': description,
        'images': images,
        'isNewBook': isNewBook,
        'isAvailableForExchange': isAvailableForExchange,
      };
}
