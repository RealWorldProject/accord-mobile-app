import 'package:accord/constant/constant.dart';
import 'package:direct_select/direct_select.dart';
import "package:flutter/material.dart";

class ExchangeRequestDialogBox extends StatefulWidget {
  @override
  _ExchangeRequestDialogBoxState createState() =>
      _ExchangeRequestDialogBoxState();
}

class _ExchangeRequestDialogBoxState extends State<ExchangeRequestDialogBox> {
  final books = [
    "Harry Potter the harry potter of the harry",
    "Book 2",
    "Book 3",
    "Book 4",
  ];

  int selectedIndex = 0;

  List<Widget> _buildItems3() {
    return books
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Exchange For:",
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Harry Potter the harry potter of the harry",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Exchange Request For:",
            style: TextStyle(fontSize: 11),
          ),
          SizedBox(
            height: 5,
          ),
          DirectSelect(
              itemExtent: 35.0,
              backgroundColor: Colors.white,
              selectedIndex: selectedIndex,
              child: Container(
                child: MySelectionItem(
                  isForList: false,
                  title: books[selectedIndex],
                ),
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: _buildItems3()),
        ],
      ),
      actions: [

        SizedBox(
          height: 30,
          width: 80,
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            child: Text("Cancel",style: TextStyle(color: Colors.red),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          height: 30,
          width: 80,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
               Constant.primary_blue_color,
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
            },
          ),
        ),
      ],
    );
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 45.0,
        child: isForList
            ? Padding(
                padding: EdgeInsets.all(10.0),
                child: _buildItem(context),
              )
            : Card(
                color: Colors.grey[100],

                // margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: <Widget>[
                    _buildItem(context),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
      ),

    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 18),
        child: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
