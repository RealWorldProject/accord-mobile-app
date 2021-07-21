import 'package:accord/models/book_test.dart';
import 'package:accord/models/category_test.dart';

final book1 = BookTest(
  images: 'assets/images/b2.jpg',
  name: 'Harry Potter B1',
  author: "JK rolling",
  category: "_fiction",
  price: 500.0,
  rating: 5,
  isNEW: false,
  isAvailableForExchange: false,
  isLiked: false,
);

final book2 = BookTest(
    images: 'assets/images/b2.jpg',
    name: 'Harry Potter B2',
    author: "JK rolling",
    category: "_fiction",
    price: 500.0,
    rating: 4,
    isNEW: true,
    isAvailableForExchange: true,
    isLiked: true);

final book3 = BookTest(
    images: 'assets/images/b2.jpg',
    name: 'Harry Potter B3',
    author: "JK rolling",
    category: "_fiction",
    price: 500.0,
    rating: 3,
    isNEW: false,
    isAvailableForExchange: false,
    isLiked: false);
// List Categories = [
//   {1,"Fiction", "assets/images/bg1.jpg"},
//   {2,"Non-Fiction", "assets/images/bg1.jpg"},
//   {3,"Adventure", "assets/images/bg1.jpg"},
//   {4,"Technology", "assets/images/bg1.jpg"},
//   {5,"Comedy", "assets/images/bg1.jpg"},
// ];
final _fiction = CategoryTest(
    imageUrl: 'assets/images/b2.jpg', name: 'Fiction', book: [book1, book2]);
final _nonFiction = CategoryTest(
    imageUrl: 'assets/images/b1.jpg',
    name: 'Non-Fiction',
    book: [book1, book2, book3]);
final _adventure = CategoryTest(
    imageUrl: 'assets/images/a1.jpg', name: 'Adventure', book: [book1]);
final _technology = CategoryTest(
    imageUrl: 'assets/images/b3.jpg',
    name: 'Techonology',
    book: [book1, book2, book3]);
final _comedy = CategoryTest(
    imageUrl: 'assets/images/c1.jpg',
    name: 'Comedy',
    book: [book1, book2, book3]);

final List<CategoryTest> categories = [
  _fiction,
  _nonFiction,
  _adventure,
  _technology,
  _comedy,
];
