import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),

            borderRadius: BorderRadius.circular(50),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          hintText: "Search",
          prefixIcon: Icon(Icons.search_rounded),
          suffixIcon: IconButton(onPressed:(){},icon: Icon(Icons.close_rounded)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
