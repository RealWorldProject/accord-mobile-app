import 'package:accord/constant/constant.dart';
import 'package:accord/models/book.dart';
import 'package:accord/responses/fetch_books_response.dart';
import 'package:accord/screens/shimmer/book_list_item.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedBooksSection extends StatefulWidget {
  const FeaturedBooksSection({Key key}) : super(key: key);

  @override
  _FeaturedBooksSectionState createState() => _FeaturedBooksSectionState();
}

class _FeaturedBooksSectionState extends State<FeaturedBooksSection> {
  List<Book> _books;
  @override
  void initState() {
    loadBooks().then((listOfBooks) => setState(
          () {
            _books = listOfBooks;
          },
        ));
    super.initState();
  }

  Future<List<Book>> loadBooks() async {
    BookViewModel bookViewModel = new BookViewModel();
    FetchBooksResponse fetchBooksResponse = await bookViewModel.fetchAllBooks();

    if (fetchBooksResponse.success) {
      return fetchBooksResponse.result;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  "Featured Books",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1),
                ),
              ),
            ],
          ),
          CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            slivers: <Widget>[
              SliverGrid.count(
                crossAxisSpacing: 0,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height),
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
        ],
      ),
    );
  }
}
