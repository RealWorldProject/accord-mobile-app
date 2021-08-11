import 'package:accord/constant/constant.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/book_view/book_description.dart';
import 'package:accord/screens/book_view/book_detail_section.dart';
import 'package:accord/screens/book_view/book_rating.dart';
import 'package:accord/viewModel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_owner.dart';

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
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => UserViewModel())
                ],
                child: BookOwner(
                    ownerID: book.userId,
                    exchangable: book.isAvailableForExchange),
              ),
              BookDescription(
                description: book.description,
              ),
              BookRating(),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: Color(0xFF0E3311).withOpacity(0.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Text(
                  "Book's Price",
                  style: TextStyle(color: Constant.primary_blue_color),
                ),
                Text(
                  "Rs. 999",
                  style: TextStyle(
                      color: Constant.semi_dark_blue_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ]),
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Constant.semi_dark_blue_color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white60,
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
