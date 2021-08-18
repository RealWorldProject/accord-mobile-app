import 'package:accord/models/book.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:flutter/material.dart';

class ResultDisplayFormat extends StatelessWidget {
  const ResultDisplayFormat({
    Key key,
    @required this.categoryTitle,
    @required this.books,
  }) : super(key: key);

  final String categoryTitle;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 5),
            child: Text(
              categoryTitle,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 22.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            slivers: <Widget>[
              SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height),
                children: List.generate(books.length, (index) {
                  Book book = books[index];
                  return BookDisplayFormat(
                    book: book,
                    index: index,
                  );
                }),
              ),
            ],
          ),
          Divider(
            height: 2,
            color: Colors.grey[900],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
