import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/shimmer/book_list_item.dart';
import 'package:accord/screens/widgets/book_display_format.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class FeaturedBooksSection extends StatelessWidget {
  const FeaturedBooksSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomText(
                  textToShow: AccordLabels.featuredBooksLabel,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            slivers: <Widget>[
              Consumer<BookViewModel>(
                builder: (context, bookViewModel, child) {
                  return SliverGrid.count(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height),
                    children: bookViewModel.data.status == Status.LOADING
                        ? List.generate(
                            4,
                            (index) {
                              return BookListItem(
                                index: index,
                              );
                            },
                          )
                        : List.generate(
                            bookViewModel.books.length,
                            (index) {
                              Book book = bookViewModel.books[index];
                              return BookDisplayFormat(
                                book: book,
                                index: index,
                              );
                            },
                          ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
