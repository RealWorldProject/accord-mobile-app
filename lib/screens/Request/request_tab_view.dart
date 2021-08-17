import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/Request/incoming_request.dart';
import 'package:accord/screens/Request/outgoing_requests.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/viewModel/request_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestTabView extends StatefulWidget {
  const RequestTabView({Key key}) : super(key: key);

  @override
  _RequestTabViewState createState() => _RequestTabViewState();
}

class _RequestTabViewState extends State<RequestTabView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(
      text: AccordLabels.outgoingRequestLabel,
    ),
    Tab(
      text: AccordLabels.incomingRequestLabel,
    ),
    // Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      if (!_controller.indexIsChanging) {
        print("Selected Index: " + _controller.index.toString());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: TabBar(
          indicatorColor: AccordColors.primary_blue_color,
          labelColor: AccordColors.primary_blue_color,
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _controller,
          tabs: list,
        ),
        title: CustomText(
          textToShow: AccordLabels.myRequests,
          textColor: AccordColors.primary_blue_color,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          OutgoingRequest(),
          IncomingRequest(),
        ],
      ),
    );
  }
}
