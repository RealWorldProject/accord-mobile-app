import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'book/post_book_screen.dart';
import 'edit/edit_user_details.dart';
import 'user_detail_section.dart';
import 'user_owned_books_section.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<BookViewModel>().fetchUserPostedBooks(),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              UserDetailSection(),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                          color: Color(0xff13293d),
                          borderRadius: BorderRadius.circular(5)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUserDetails()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LineIcons.userEdit,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                    textToShow: AccordLabels.editDetails,
                                    fontSize: 16,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostBookScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_circle_outline_rounded,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  textToShow: AccordLabels.addBookLabel,
                                  fontSize: 16,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UserOwnedBooksSection(),
            ],
          ),
        ),
      ),
    );
  }
}
