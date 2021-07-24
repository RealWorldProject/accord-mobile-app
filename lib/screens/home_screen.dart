import 'package:accord/screens/search/search_test.dart';
import 'package:accord/screens/widgets/categories_view.dart';
import 'package:accord/screens/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'post_book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchField(),
            CategoriesView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostBook()));
        },
        child: const Icon(Icons.add,size: 32,),
        tooltip: "Add Book",
      ),
    );
  }
}
