import 'package:accord/service/storage.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // getUserToken();
    return Scaffold(
        body: Container(
      child: Center(
        child: FutureBuilder(
          future: Storage().fetchToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text('Welcome to dashboard:\n${snapshot.data}');
            } else {
              return Text('Token Loading...');
            }
          },
        ),
      ),
    ));
  }
}
