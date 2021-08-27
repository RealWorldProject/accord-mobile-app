import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/profile/user/book/post_book_screen.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:accord/viewModel/category_view_model.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categories_section.dart';
import 'featured_books.dart';
import 'search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    context.read<UserViewModel>().fetchUserDetail();
    context.read<CategoryViewModel>().fetchCategories();
    context.read<BookViewModel>().fetchAllBooks();
    context.read<CartviewModel>().fetchCartItems;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserViewModel>().fetchUserDetail();
        context.read<CategoryViewModel>().fetchCategories();
        context.read<BookViewModel>().fetchAllBooks();
        context.read<CartviewModel>().fetchCartItems;
      },
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: SafeArea(
            bottom: false,
            child: Container(
              margin: EdgeInsets.only(bottom: 80),
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
              tooltip: AccordLabels.addBookLabel,
            ),
            alignment: Alignment(1, 0.81)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
