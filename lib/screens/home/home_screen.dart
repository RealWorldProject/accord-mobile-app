import 'package:accord/screens/home/categories_section.dart';
import 'package:accord/screens/home/featured_books.dart';
import 'package:accord/screens/home/search_field.dart';
import 'package:accord/screens/profile/user/book/post_book_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        padding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SearchField(),
                  CategoriesSection(),
                  FeaturedBooksSection(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
          child: FloatingActionButton(
            isExtended: true,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PostBookScreen()));
            },
            child: const Icon(
              Icons.add,
              size: 32,
            ),
            tooltip: "Add Book",
          ),
          alignment: Alignment(1, 0.81)),
    );
  }
}
