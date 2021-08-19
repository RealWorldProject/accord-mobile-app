import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/notification/notification_tile.dart';
import 'package:accord/screens/notification/request_notification.dart';
import 'package:accord/screens/shimmer/notification_shimmer.dart';
import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            title: AccordLabels.notificationScreenTitle,
            backButton: false,
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationTile(),
              RequestNotification(),
              NotificationShimmer(),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
