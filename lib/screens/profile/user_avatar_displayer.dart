import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAvatarDisplayer extends StatelessWidget {
  const UserAvatarDisplayer({
    Key key,
    @required this.outerRadius,
    @required this.innerRadius,
    @required this.outerColor,
  }) : super(key: key);

  final double outerRadius;
  final double innerRadius;
  final Color outerColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        if (userViewModel.data.status == Status.COMPLETE) {
          return CircleAvatar(
            radius: outerRadius,
            backgroundColor: outerColor,
            child: CircleAvatar(
              radius: innerRadius,
              backgroundImage: Uri.parse(userViewModel.user.image).isAbsolute
                  ? NetworkImage(userViewModel.user.image)
                  : AssetImage("assets/images/user2.png"),
              backgroundColor: Colors.black12,
            ),
          );
        } else {
          return const CircleAvatar(
            radius: 74.0,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.black12,
            ),
          );
        }
      },
    );
  }
}
