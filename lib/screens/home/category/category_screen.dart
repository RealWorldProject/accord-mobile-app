import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
import 'package:accord/screens/shimmer/book_list_item.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  final Category categoryObj;

  CategoryScreen({this.categoryObj});

  @override
  Widget build(BuildContext context) {
    context.read<BookViewModel>().fetchBooksInCategory(categoryObj.id);

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(categoryObj.category),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: categoryObj.category,
                      child: Image.network(
                        categoryObj.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
          ),
          Consumer<BookViewModel>(
            builder: (context, bookViewModel, child) {
              return SliverGrid.count(
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                crossAxisCount: 2,
                childAspectRatio: 1 / 2,
                children: (() {
                  if (bookViewModel.data.status == Status.LOADING ||
                      bookViewModel.data.status == Status.ERROR) {
                    return List.generate(4, (index) {
                      return BookListItem(
                        index: index,
                      );
                    });
                  } else {
                    return List.generate(bookViewModel.categoricalBooks.length,
                        (index) {
                      Book book = bookViewModel.categoricalBooks[index];
                      return BookDisplayFormat(
                        book: book,
                        index: index,
                      );
                    });
                  }
                }()),
              );
            },
          )
        ],
      ),
    );
  }
}
