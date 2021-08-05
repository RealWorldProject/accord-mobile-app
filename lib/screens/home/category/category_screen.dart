import 'package:accord/constant/constant.dart';
import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_books_response.dart';
import 'package:accord/screens/shimmer/book_list_item.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:accord/viewModel/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  final Category categoryObj;

  CategoryScreen({this.categoryObj});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Book> _books;

  @override
  initState() {
    loadBooksInSelectedCategory().then((value) => setState(
          () {
            _books = value;
          },
        ));
    super.initState();
  }

  Future<List<Book>> loadBooksInSelectedCategory() async {
    BookViewModel bookViewModel = new BookViewModel();
    FetchBooksResponse fetchBooksInCategoryResponse =
        await bookViewModel.fetchBooksInCategory(widget.categoryObj.id);

    if (fetchBooksInCategoryResponse.success) {
      return fetchBooksInCategoryResponse.result;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartviewModel>().fetchCartItems;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.categoryObj.category),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: widget.categoryObj.category,
                      child: Image.network(
                        widget.categoryObj.image,
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
          SliverGrid.count(
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 2,
            childAspectRatio: 1 / 2,
            children: _books != null
                ? List.generate(_books.length, (index) {
                    Book book = _books[index];
                    return BookDisplayFormat(
                      book: book,
                      index: index,
                    );
                  })
                : List.generate(4, (index) {
                    return Shimmer.fromColors(
                      child: BookListItem(
                        index: index,
                      ),
                      baseColor: Constant.shimmer_base_color,
                      highlightColor: Constant.shimmer_highlight_color,
                    );
                  }),
          ),
        ],
      ),
    );
  }
}
