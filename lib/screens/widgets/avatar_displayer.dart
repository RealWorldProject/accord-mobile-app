import 'package:accord/constant/accord_colors.dart';
import 'package:flutter/material.dart';

class AvatarDisplayer extends StatelessWidget {
  const AvatarDisplayer({
    Key key,
    @required this.avatarUrl,
    @required this.radius,
  }) : super(key: key);

  final String avatarUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: CircleAvatar(
        maxRadius: radius,
        backgroundImage:
            // checks if the given image url is valid.
            Uri.parse(avatarUrl).isAbsolute
                ? NetworkImage(avatarUrl)
                : AssetImage("assets/images/user2.png"),
        backgroundColor: AccordColors.loading_background,
      ),
    );
  }
}
