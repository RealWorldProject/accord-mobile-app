import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/notification.dart' as accord;
import 'package:accord/screens/widgets/avatar_displayer.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/information_dialog_box.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/utils/time_calculator.dart';
import 'package:accord/viewModel/notification_view_model.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'notification_options.dart';

class RequestTypeNotification extends StatefulWidget {
  const RequestTypeNotification({Key key, this.notification}) : super(key: key);

  final accord.Notification notification;

  @override
  _RequestTypeNotificationState createState() =>
      _RequestTypeNotificationState();
}

class _RequestTypeNotificationState extends State<RequestTypeNotification> {
  bool isSeen = false;

  Future<void> _toggleBookIsSeen() async {
    setState(() {
      isSeen = !isSeen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSeen ? Colors.white : Colors.blue[100],
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
                  avatarUrl: widget.notification.requesterPhoto,
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
                  //         text: " sent you a request to view your information.",
                  //       ),
                  //     ],
                  //     style: const TextStyle(
                  //       fontSize: 13.0,
                  //       fontWeight: FontWeight.w600,
                  //       color: Color(0xff606060),
                  //     ),
                  //   ),
                  // ),
                  CustomText(
                    textToShow: widget.notification.notificationBody,
                    noOfLines: 3,
                    fontSize: 16,
                    letterSpacing: -1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 1.8,
                  ),
                  CustomText(
                    textToShow: TimeCalculator.getTimeDifference(
                        widget.notification.createdAt),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    textColor: Color(0xff1b98e0),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,

                        // width: MediaQuery.of(context).size.width/2.2,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => acceptBookExchangeRequest(
                              widget.notification.request,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,

                        // width: MediaQuery.of(context).size.width/2.2,
                        decoration: BoxDecoration(
                            color: Color(0xff13293d),
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => rejectBookExchangeRequest(
                              widget.notification.request,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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
                      builder: (context) => NotificationOptions(
                            markasreadOption: _toggleBookIsSeen,
                            value: isSeen,
                          ));
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

  Future<void> acceptBookExchangeRequest(String requestID) async {
    RequestViewModel requestViewModel = context.read<RequestViewModel>();

    await requestViewModel.acceptExchangeRequest(
      requestID,
      actionPlace: ActionPlace.NOTIFICATION_BODY,
    );

    if (requestViewModel.data.status == Status.COMPLETE) {
      Toast.show(
        requestViewModel.data.message,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: AccordColors.full_dark_blue_color,
        backgroundRadius: 5.0,
      );
    } else if (requestViewModel.data.status == Status.ERROR) {
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
            contentType: ContentType.ERROR,
            content: requestViewModel.data.message,
            actionText: AccordLabels.tryAgain),
      );
    }

    // fetchs notification after request actions
    context.read<NotificationViewModel>().fetchNotifications();
  }

  Future<void> rejectBookExchangeRequest(String requestID) async {
    RequestViewModel requestViewModel = context.read<RequestViewModel>();
    await requestViewModel.rejectExchangeRequest(
      requestID,
      actionPlace: ActionPlace.NOTIFICATION_BODY,
    );

    if (requestViewModel.data.status == Status.COMPLETE) {
      Toast.show(
        requestViewModel.data.message,
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: AccordColors.full_dark_blue_color,
        backgroundRadius: 5.0,
      );
    } else if (requestViewModel.data.status == Status.ERROR) {
      showDialog(
        context: context,
        builder: (context) => InformationDialogBox(
            contentType: ContentType.ERROR,
            content: requestViewModel.data.message,
            actionText: AccordLabels.tryAgain),
      );
    }

    // fetchs notification after request actions
    context.read<NotificationViewModel>().fetchNotifications();
  }
}
