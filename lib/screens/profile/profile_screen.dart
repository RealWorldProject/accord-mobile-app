import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/auth/login_screen.dart';
import 'package:accord/screens/widgets/custom_dialog_box.dart';
import 'package:accord/services/storage.dart';
import 'package:accord/viewModel/screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

import 'password/change_password.dart';
import 'user/user_screen.dart';
import 'user_avatar_displayer.dart';
import 'user_term_displayer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
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
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 95),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          // displays user profile images
                          Center(
                            child: UserAvatarDisplayer(
                              outerRadius: 74,
                              innerRadius: 70,
                              outerColor: Colors.white,
                            ),
                          ),
                          // displays user terms i.e, name & email
                          UserTermDisplayer(
                            termColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
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
                          ActionTab(
                            action: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserScreen(),
                              ),
                            ),
                            icon: Icons.person_rounded,
                            iconColor: Color(0xff0a78b2),
                            label: AccordLabels.myProfile,
                          ),
                          ActionTab(
                            action: () {},
                            icon: Icons.favorite,
                            iconColor: Colors.red[700],
                            label: AccordLabels.favorites,
                          ),
                          ActionTab(
                            action: () {},
                            icon: Icons.menu_book_rounded,
                            iconColor: Color(0xff0a78b2),
                            label: AccordLabels.myBooks,
                          ),
                          ActionTab(
                            action: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePassword(),
                              ),
                            ),
                            icon: Icons.edit,
                            iconColor: Color(0xff0a78b2),
                            label: AccordLabels.changePassword,
                          ),
                          ActionTab(
                            action: showLogoutDialog,
                            icon: Icons.logout,
                            iconColor: Color(0xff0a78b2),
                            label: AccordLabels.logout,
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

  // logout function.
  Future<void> logout() async {
    await Storage().deleteToken();

    // sets active bottom navigation tab to home screen.
    context.read<ScreenViewModel>().restoreInitialTab(HOME_SCREEN);

    // navigates to login screen
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));

    // removes dialog box after navigation
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<dynamic> showLogoutDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          confirmMessage: "Are you sure you want to logout?",
          dontText: AccordLabels.stayIn,
          dontAction: () => Navigator.pop(context),
          doText: AccordLabels.logout,
          doAction: logout,
        );
      },
    );
  }
}

// widget to display each tabs in profile screen
class ActionTab extends StatelessWidget {
  const ActionTab({
    Key key,
    @required this.action,
    @required this.icon,
    @required this.iconColor,
    @required this.label,
  }) : super(key: key);

  // on tab action
  final VoidCallback action;

  // icon to display
  final IconData icon;
  final Color iconColor;

  // text to show
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => action(),
            child: ListTile(
              leading: Icon(
                icon,
                size: 28,
                color: iconColor,
              ),
              title: Text(
                label,
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
      ],
    );
  }
}
