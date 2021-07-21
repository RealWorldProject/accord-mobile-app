import 'package:accord/models/book_test.dart';

class Category {
  final String imageUrl;
  final String name;
  final List<BookTest> book;

  Category({
    this.imageUrl,
    this.name,
    this.book
  });
}
