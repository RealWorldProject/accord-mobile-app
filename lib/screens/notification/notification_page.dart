import 'package:accord/screens/notification/notification_tile.dart';
import 'package:accord/screens/notification/request_notification.dart';
import 'package:accord/screens/shimmer/notification_shimmer.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Badge(
          badgeColor: Colors.blue,
          position: BadgePosition.topEnd(top: -12, end: -20),
          badgeContent: Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: Text(
            "Notifications",
            style: TextStyle(color: Color(0xff13293d)),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
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
      )
    );
  }
}
