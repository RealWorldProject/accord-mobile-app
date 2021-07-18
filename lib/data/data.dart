
import 'package:accord/models/category.dart';
// List Categories = [
//   {1,"Fiction", "assets/images/bg1.jpg"},
//   {2,"Non-Fiction", "assets/images/bg1.jpg"},
//   {3,"Adventure", "assets/images/bg1.jpg"},
//   {4,"Technology", "assets/images/bg1.jpg"},
//   {5,"Comedy", "assets/images/bg1.jpg"},
// ];
final _fiction = Category(imageUrl: 'assets/images/bg1.jpg', name: 'Fiction');
final _nonFiction = Category(imageUrl: 'assets/images/bg1.jpg', name: 'Non-Fiction');
final _adventure = Category(imageUrl: 'assets/images/bg1.jpg', name: 'Adventure');
final _technology = Category(imageUrl: 'assets/images/bg1.jpg', name: 'Techonology');
final _comedy = Category(imageUrl: 'assets/images/bg1.jpg', name: 'Comedy');

final List<Category> categories =[
 _fiction,
 _nonFiction,
 _adventure,
 _technology,
 _comedy,
];