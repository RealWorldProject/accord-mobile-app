import 'package:accord/models/book.dart';
import 'package:flutter/material.dart';

import 'book_description_section.dart';
import 'book_detail_section.dart';
import 'book_owner_section.dart';
import 'book_rating_section.dart';
import 'book_transaction_section.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key key, this.book}) : super(key: key);

  final Book book;

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
              BookDetailSection(
                images: book.images,
                name: book.name,
                author: book.author,
                exchangable: book.isAvailableForExchange,
              ),
              BookOwnerSection(
                owner: book.userId,
                exchangable: book.isAvailableForExchange,
                bookID: book.id,
                bookName: book.name,
              ),
              BookDescriptionSection(
                description: book.description,
              ),
              BookRatingSection(),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomSheet: BookTransactionSection(
        bookId: book.id,
        price: book.price,
      ),
    );
  }
}
