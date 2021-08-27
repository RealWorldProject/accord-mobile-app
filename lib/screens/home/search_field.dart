import 'package:accord/constant/accord_labels.dart';
import 'package:accord/utils/exposer.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'search/search_screen.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      child: TextField(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        ),
        readOnly: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          isDense: true,
          hintText: AccordLabels.searchForBooksLabel,
          prefixIcon: Icon(Icons.search_rounded),
          suffixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
              child: Consumer<UserViewModel>(
                builder: (context, userViewModel, child) {
                  if (userViewModel.data.status == Status.COMPLETE) {
                    return CircleAvatar(
                      maxRadius: 10,
                      backgroundImage:
                          // checks if the given image url is valid.
                          Uri.parse(userViewModel.user.image).isAbsolute
                              ? NetworkImage(userViewModel.user.image)
                              : AssetImage("assets/images/user2.png"),
                      backgroundColor: Colors.black12,
                    );
                  } else {
                    return CircleAvatar(
                      maxRadius: 10,
                      backgroundColor: Colors.black12,
                    );
                  }
                },
              ),
            ),
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
