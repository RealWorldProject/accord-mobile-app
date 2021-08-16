import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:accord/screens/shimmer/book_feed_shimmer.dart';
import 'package:accord/screens/widgets/custom_bottom_sheet.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../user_avatar_displayer.dart';
import 'book/edit_book_screen.dart';

class UserOwnedBooksSection extends StatelessWidget {
  const UserOwnedBooksSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookViewModel>().fetchUserPostedBooks();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Consumer<BookViewModel>(
            builder: (context, bookViewModel, child) {
              if (bookViewModel.data.status == Status.COMPLETE) {
                return BookFeedformat(
                  books: bookViewModel.userOwnedBooks,
                );
              } else {
                return BookFeedShimmer();
              }
            },
          ),
        ),
      ],
    );
  }
}

class BookFeedformat extends StatelessWidget {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  const BookFeedformat({
    Key key,
    @required this.books,
  }) : super(key: key);

  final List<Book> books;

  bookOptions(BuildContext context, Book book) {
    final bookViewModel = context.read<BookViewModel>();

    return showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        // option 1
        option1: AccordLabels.editBook,
        iconOpt1: Icons.edit_rounded,
        action1: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditBookScreen(
                      book: book,
                    )),
          );
        },
        // option 2
        option2: AccordLabels.deleteBook,
        iconOpt2: Icons.delete_forever_rounded,
        action2: () => {
          showDialog(
            context: context,
            builder: (context) {
              return ChangeNotifierProvider.value(
                value: bookViewModel,
                builder: (context, child) => CustomDialogBox(
                  title: "Action: Book Deletion!!!",
                  confirmMessage:
                      "Are you sure you want to delete, '${book.name}'?",
                  dontText: "Keep!",
                  dontAction: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  doText: AccordLabels.delete,
                  doAction: () async {
                    BookViewModel bookViewModel = context.read<BookViewModel>();
                    await bookViewModel.deleteBook(book.id);

                    if (bookViewModel.data.status == Status.COMPLETE) {
                      Navigator.of(context, rootNavigator: true).pop();
                    } else {
                      Navigator.of(context, rootNavigator: true).pop();
                      showDialog(
                        context: context,
                        builder: (context) => InformationDialogBox(
                          icon: Icons.error,
                          message: bookViewModel.data.message,
                          actionText: AccordLabels.tryAgain,
                          action: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          )
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return books.isEmpty
        ? Container(
            child: CustomText(
              textToShow: AccordLabels.noBookPostedLabel,
              textColor: Colors.black38,
              fontSize: 18,
              letterSpacing: -1,
              fontWeight: FontWeight.w400,
            ),
          )
        : CustomScrollView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, index) {
                    Book book = books[index];
                    return Container(
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8),
                              // fetch user-image (only) from the user data itself
                              // rather than book's data
                              leading: UserAvatarDisplayer(
                                outerRadius: 20,
                                innerRadius: 19,
                                outerColor: Colors.blue,
                              ),
                              title: CustomText(
                                textToShow: TextUtils()
                                    .capitalizeAll(book.userId.fullName),
                                fontWeight: FontWeight.bold,
                                textColor: Color(0xff13293d),
                              ),
                              trailing: ClipOval(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      bookOptions(context, book);
                                    },
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.8,
                                  width: double.infinity,
                                  child: book.images[0] != null
                                      ? Image.network(
                                          book.images[0],
                                          fit: BoxFit.contain,
                                        )
                                      : Center(
                                          child: Text("Image not found"),
                                        ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black26,
                                  ),
                                ),
                                Positioned(
                                  bottom: -20,
                                  right: 20,
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      padding: EdgeInsets.only(
                                        top: 4,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                      ),
                                      alignment: Alignment.center,
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      iconSize: 25,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 6,
                                    left: 6,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/tag-shape.png"),
                                      radius: 22,
                                      child: Center(
                                        child: RotationTransition(
                                          turns: new AlwaysStoppedAnimation(
                                              320 / 360),
                                          child: CustomText(
                                            textToShow: book.isNewBook
                                                ? AccordLabels
                                                    .positiveBookConditionValue
                                                    .toUpperCase()
                                                : AccordLabels
                                                    .negativeBookConditionValue
                                                    .toUpperCase(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            textColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ))
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    textToShow:
                                        TextUtils().capitalizeAll(book.name),
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    textColor: Colors.grey[900],
                                  ),
                                  CustomText(
                                    textToShow:
                                        TextUtils().capitalizeAll(book.author),
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    textColor: Colors.grey[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                  RatingStars(5, 18),
                                  CustomText(
                                    textToShow: book.isAvailableForExchange
                                        ? AccordLabels.availableForExchange
                                        : AccordLabels.notAvailableForExchange,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100,
                                    textColor: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          textToShow:
                                              "Rs. ${book.price.toString()}",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          textColor: Color(0xff247BA0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: books.length,
                ),
              ),
            ],
          );
  }
}
