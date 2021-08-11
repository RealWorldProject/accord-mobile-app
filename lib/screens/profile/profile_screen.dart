import 'dart:developer';

import 'package:accord/models/user.dart';
import 'package:accord/screens/Request/request_tab_view.dart';
import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/profile/password/change_password.dart';
import 'package:accord/screens/profile/user/user_screen.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/services/storage.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  Future<void> logout() async {
    await Storage().deleteToken();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // set up the buttons
  // Widget cancelButton =

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Color(0xfff1f1f1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/profileBG.png"),
                        fit: BoxFit.cover,

                        // image: Image.asset("assets/images/profileBG.png",height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 95),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: UserViewModel().fetchUserDetails(),
                        builder: (context, userSnap) {
                          if (userSnap.hasData) {
                            User user = userSnap.data.result;
                            return userDetailsDisplayer(user);
                          }
                          return userDetailsDisplayer(User(
                            email: "dummyuser@gmail.com",
                            image: "",
                            fullName: "dummy user",
                          ));
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserScreen()));
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_rounded,
                                  size: 28,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "View Profile",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(
                                  Icons.favorite,
                                  size: 28,
                                  color: Colors.redAccent[700],
                                ),
                                title: Text(
                                  "Favourites",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RequestTabView()));
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.menu_book_rounded,
                                  size: 28,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "My Books Request",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  size: 28,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showLogoutDialog();
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  size: 28,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff1b98e0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 65,
                right: 15,
                child: IconButton(
                  onPressed: () {
                    showLogoutDialog();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  iconSize: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  userDetailsDisplayer(User user) {
    return Container(
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 74.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70.0,
                backgroundImage: user.image == "dummy.png" || user.image == ""
                    ? AssetImage("assets/images/user2.png")
                    : NetworkImage(user.image),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Text(
            TextUtils().capitalizeAll(user.fullName),
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          // title: "Action: Log out!",
          confirmMessage: "Are you sure you want to logout?",
          dontText: "Stay In",
          dontAction: () => Navigator.pop(context),
          doText: "Log Out",
          doAction: logout,
        );
      },
    );
  }
}
