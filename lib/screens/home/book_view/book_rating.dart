import 'package:accord/constant/constant.dart';
import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  String desc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rating & Review",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Constant.semi_dark_blue_color),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "view more",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Asharya Pandey",
                    ),
                    TextSpan(text: "   -"),
                    TextSpan(
                      text: "19 Feb 2021",
                    ),
                  ],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              RatingStars(3, 15)
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            desc,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.grey[700]),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
