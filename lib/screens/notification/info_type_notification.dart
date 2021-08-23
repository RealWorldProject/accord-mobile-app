import 'package:accord/models/notification.dart' as accord;
import 'package:accord/screens/widgets/avatar_displayer.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:flutter/material.dart';

import 'notification_options.dart';

class InfoTypeNotification extends StatelessWidget {
  const InfoTypeNotification({
    Key key,
    this.notification,
  }) : super(key: key);

  final accord.Notification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AvatarDisplayer(
                  avatarUrl: notification.requesterPhoto,
                  radius: 30,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // RichText(
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 5,
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: "Keanu Reeves",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xff13293d),
                  //         ),
                  //       ),
                  //       TextSpan(
                  //         text:
                  //             " accepted your request. You can now see the contact information of ",
                  //       ),
                  //       // TextSpan(
                  //       //   text:
                  //       //   " declined your request. You can not see the contact information of ",
                  //       //   style: TextStyle(
                  //       //     fontWeight: FontWeight.bold,
                  //       //   ),
                  //       // ),
                  //       TextSpan(
                  //         text: "John Doe.",
                  //         style: TextStyle(
                  //           color: Color(0xff13293d),
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //     style: const TextStyle(
                  //       fontSize: 14.0,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color(0xff606060),
                  //     ),
                  //   ),
                  // ),
                  CustomText(
                    textToShow: notification.notificationBody,
                    noOfLines: 3,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                  ),

                  SizedBox(
                    height: 1.8,
                  ),
                  CustomText(
                    textToShow: TimeCalculator.getTimeDifference(
                        notification.createdAt),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xff1b98e0),
                  ),
                ],
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => NotificationOptions(),
                  );
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
        ],
      ),
    );
  }
}
