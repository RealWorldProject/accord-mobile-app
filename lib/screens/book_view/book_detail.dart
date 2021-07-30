import 'package:accord/constant/constant.dart';
import 'package:accord/screens/book_view/book_description.dart';
import 'package:accord/screens/book_view/book_detail_section.dart';
import 'package:accord/screens/book_view/book_rating.dart';
import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:accord/screens/widgets/back_button.dart';
import 'package:accord/screens/widgets/custom_like_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'book_uploaded_user_info.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({Key key}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
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
              BookUploadedUserInfo(),
              BookDescription(),
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
                  style: TextStyle(color: Constant.semi_dark_blue_color,fontWeight: FontWeight.bold,fontSize: 22),
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
                    onTap: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_rounded,size: 25,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
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
