import 'package:accord/screens/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EditRatingAndReview extends StatelessWidget {
  const EditRatingAndReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: "Edit Rating & Reviews",
        ),
      ),
      body: Container(
        child: Text("Edit"),
      ),
    );
  }
}
