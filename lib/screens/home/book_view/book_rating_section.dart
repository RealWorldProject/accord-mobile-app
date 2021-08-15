import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class BookRatingSection extends StatelessWidget {
  const BookRatingSection({Key key}) : super(key: key);

  final String review =
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
              CustomText(
                textToShow: AccordLabels.ratingAndReviewTitle,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                textColor: AccordColors.semi_dark_blue_color,
              ),
              InkWell(
                onTap: () {},
                child: CustomText(
                  textToShow: AccordLabels.viewMore,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.grey[700],
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
          CustomText(
            textToShow: review,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            textColor: Colors.grey[700],
            noOfLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
