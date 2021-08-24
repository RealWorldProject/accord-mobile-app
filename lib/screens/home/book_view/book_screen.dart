import 'package:flutter/material.dart';

import 'book_description_section.dart';
import 'book_detail_section.dart';
import 'book_owner_section.dart';
import 'book_rating_section.dart';
import 'book_transaction_section.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookDetailSection(),
              BookOwnerSection(),
              BookDescriptionSection(),
              BookRatingSection(),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomSheet: BookTransactionSection(),
    );
  }
}
