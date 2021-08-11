import 'package:accord/screens/profile/user/book/post_book_screen.dart';
import 'package:accord/screens/profile/user/edit/user_edit_detail.dart';
import 'package:accord/screens/profile/user/user_owned_books_section.dart';
import 'package:accord/screens/profile/user/user_detail_section.dart';
import 'package:accord/screens/shimmer/view_profile_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            UserDetailSection(),
            Container(
              padding: EdgeInsets.all(8),

              width: double.infinity,
              // decoration: BoxDecoration(
              //     color: Colors.blue, borderRadius: BorderRadius.circular(5)),
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
                          print("Edit Profile");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditDetail()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.userEdit,
                                size: 22,
                                color: Colors.white,
                              ),
                              // Icon(Icons.user,size: 22,color: Colors.white,),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Edit Details",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                              Text(
                                "Add Book",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
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
            // ViewProfileShimmer(),
            UserOwnedBooksSection(),
          ],
        ),
      ),
    );
  }
}
