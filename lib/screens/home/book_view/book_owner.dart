import 'package:accord/constant/constant.dart';
import 'package:accord/screens/widgets/CustomOutlineButton.dart';
import 'package:accord/services/handlers/exposer.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookOwner extends StatelessWidget {
  const BookOwner({
    Key key,
    this.ownerID,
    this.exchangable,
  }) : super(key: key);

  final String ownerID;
  final bool exchangable;

  @override
  Widget build(BuildContext context) {
    context.read<UserViewModel>().fetchUserDetail(ownerID);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer<UserViewModel>(builder: (context, userViewModel, child) {
            switch (userViewModel.data.status) {
              case Status.LOADING:
                return Text("Loading...");
              case Status.COMPLETE:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage:
                          // checks if the given image url is valid.
                          Uri.parse(userViewModel.user.image).isAbsolute
                              ? NetworkImage(userViewModel.user.image)
                              : AssetImage("assets/images/user2.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    Text(
                      userViewModel.user.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constant.full_dark_blue_color,
                          fontSize: 16),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                );
              case Status.ERROR:
                return Text(userViewModel.data.message);
            }
            return Container();
          }),
          exchangable ? CustomOutlineButton() : Container(),
        ],
      ),
    );
  }
}
