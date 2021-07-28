import 'package:accord/screens/home/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      child: TextField(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => SearchPage(),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        readOnly: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          hintText: "Search for Books",
          prefixIcon: Icon(Icons.search_rounded),
          suffixIcon: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.black54,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
