import 'package:accord/screens/home/search_field.dart';
import 'package:accord/screens/profile/post_book.dart';
import 'package:accord/screens/search/search_test.dart';

import 'package:flutter/material.dart';
import 'categories_view_shimmer.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({Key key}) : super(key: key);

  @override
  _HomeScreenShimmerState createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SearchField(),
              CategoriesViewShimmer(),
            ],
          ),
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
