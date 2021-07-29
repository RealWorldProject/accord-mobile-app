import 'dart:async';

import 'package:accord/models/book.dart';
import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:accord/screens/profile/user/book/edit_book_screen.dart';
import 'package:accord/screens/widgets/custom_bottom_sheet.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserOwnedBooksSection extends StatefulWidget {
  const UserOwnedBooksSection({Key key}) : super(key: key);

  @override
  _UserOwnedBooksSectionState createState() => _UserOwnedBooksSectionState();
}

class _UserOwnedBooksSectionState extends State<UserOwnedBooksSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: FutureBuilder(
              future: BookViewModel().fetchUserPostedBooks(),
              builder: (context, userOwnedBookSnap) {
                if (userOwnedBookSnap.hasData) {
                  List<Book> books = userOwnedBookSnap.data.result;
                  if (books.isEmpty) {
                    return Container(
                      child: Text(
                        "You have not posted any book yet.",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 18,
                          letterSpacing: -1,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    );
                  } else {
                    return CustomScrollView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, index) {
                              Book book = books[index];
                              return Container(
                                child: bookFeedStyleDisplay(book),
                              );
                            },
                            childCount: books.length,
                          ),
                        )
                      ],
                    );
                  }
                }
                return Container();
              }),
        ),
      ],
    );
  }

  bookFeedStyleDisplay(Book book) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage("assets/images/user2.png"),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              "John Doe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff13293d),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => CustomBottomSheet(
                          // option 1
                          option1: "Edit Book",
                          action1: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditBookScreen(
                                      book: book,
                                    )),
                          ).then(onReturn),
                          iconOpt1: Icons.edit_rounded,
                          // option 2
                          option2: "Delete Book",
                          action2: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: "Action: Book Deletion!!!",
                                  confirmMessage:
                                      "Are you sure you want to delete, '${book.name}'?",
                                  dontText: "Keep!",
                                  dontAction: () => Navigator.pop(context),
                                  doText: "Delete!",
                                  doAction: () async {
                                    await BookViewModel()
                                        .deleteBook(book.id)
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                );
                              },
                            ).then(onReturn)
                          },
                          iconOpt2: Icons.delete_forever_rounded,
                        ));
              },
              child: Icon(Icons.more_vert_rounded),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: double.infinity,
                child: Image.network(
                  book.images[0],
                  fit: BoxFit.contain,
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
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 0, left: 0, right: 0),
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
                    backgroundImage: AssetImage("assets/images/tag-shape.png"),
                    radius: 22,
                    child: Center(
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(320 / 360),
                        child: Text(
                          book.isNewBook ? "NEW" : "OLD",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // backgroundColor: Color(0xff19b128),
                    backgroundColor: Colors.transparent,
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900]),
                ),
                Text(
                  book.author,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic),
                ),
                RatingStars(5),
                Text(
                  book.isAvailableForExchange
                      ? "Available for exchange"
                      : "Not available for exchange.",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        book.price.toString(),
                        style: TextStyle(
                          fontSize: 16,
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // refresher: holds function that the screen depends on.
  Future<void> refreshData() async {
    await BookViewModel().fetchUserPostedBooks();
  }

  // triggers both refresher and setState
  FutureOr onReturn(dynamic value) {
    refreshData();
    setState(() {});
  }
}
