import 'package:accord/constant/constant.dart';
import 'package:accord/models/book.dart';
import 'package:accord/models/category.dart';
import 'package:accord/responses/fetch_books_in_category_response.dart';
import 'package:accord/screens/rating/rate_book.dart';
import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:accord/screens/shimmer/book_list_item.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  final Category categoryObj;

  CategoryScreen({this.categoryObj});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // bool isLiked = false;
  // static const isNew = widget.categoryObj.book.isNew;

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
    FetchBooksInCategoryResponse fetchBooksInCategoryResponse =
        await bookViewModel.fetchBooksInCategory(widget.categoryObj.id);

    if (fetchBooksInCategoryResponse.success) {
      return fetchBooksInCategoryResponse.result;
    } else {
      return [];
    }
  }

  _buildBooks(Book book, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.zero,
                height: 219.0,
                width: 176.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(book.images[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              Positioned.fill(
                child: Container(
                  height: 219.0,
                  width: 176.0,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                right: 10,
                child: Container(
                  padding: EdgeInsets.zero,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 0, left: 0, right: 0),
                    alignment: Alignment.center,
                    // icon: book.isLiked == false
                    //     ? Icon(Icons.favorite_outline_rounded)
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    iconSize: 25,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  alignment: Alignment.center,
                  decoration: book.isNew == false
                      ? BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        )
                      : BoxDecoration(
                          color: Colors.greenAccent[700],
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                  child: book.isNew == false
                      ? Text(
                          "old",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )
                      : Text(
                          "new",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  book.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900]),
                ),
                Text(
                  book.author,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic),
                ),
                RatingStars(4.5),
                Text(
                  "Available for Exchange",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w100,
                      color: book.isAvailableForExchange == true
                          ? Colors.blue
                          : Colors.grey[800],
                      decoration: book.isAvailableForExchange == false
                          ? (TextDecoration.lineThrough)
                          : (TextDecoration.none),
                      fontStyle: FontStyle.italic),
                ),
                // book.isAvailableForExchange == false
                //     ? Text(
                //   "Available for Exchange",
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.w100,
                //       color: Colors.grey[800],
                //       decoration: TextDecoration.lineThrough,
                //       fontStyle: FontStyle.italic),
                // )
                //     : Text(
                //   "Available for Exchange",
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 11,
                //       fontWeight: FontWeight.w100,
                //       color: Colors.blue,
                //       fontStyle: FontStyle.italic),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rs. ${book.price.toString()}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff247BA0),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Color(0xff13293D),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.shopping_cart),
                        iconSize: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            childAspectRatio: 1/2,
            // childAspectRatio: (MediaQuery.of(context).devicePixelRatio /5.2),
            // childAspectRatio: MediaQuery.of(context).size.width /
            //     (MediaQuery.of(context).size.height / 1.05),
            children: _books != null
                ? List.generate(_books.length, (index) {
                    Book book = _books[index];
                    return _buildBooks(book, index);
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
