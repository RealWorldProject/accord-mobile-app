import 'package:accord/constant/accord_colors.dart';
import 'package:accord/constant/accord_labels.dart';
import 'package:accord/models/book.dart';
import 'package:accord/screens/widgets/back_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/custom_like_button.dart';
import 'package:accord/screens/widgets/star_rating_system.dart';
import 'package:accord/utils/text_utils.dart';
import 'package:accord/viewModel/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailSection extends StatelessWidget {
  const BookDetailSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Book book = context.read<BookViewModel>().activeBook;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(book.images[0]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: SafeArea(child: CutomeBackButton()),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: SafeArea(child: CustomLikeButton()),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textToShow: TextUtils().capitalizeAll(book.name),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  textColor: AccordColors.full_dark_blue_color,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "By ",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: TextUtils().capitalizeAll(book.author),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Color(0xff606060),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                StarRatingSystem(
                  isEditable: false,
                  ratingPoint: book.rating,
                  starSize: 20,
                ),
                Text(
                  AccordLabels.availableForExchange,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: book.isAvailableForExchange == true
                        ? Color(0xff1b98e0)
                        : Colors.grey[600],
                    decoration: book.isAvailableForExchange == false
                        ? (TextDecoration.lineThrough)
                        : (TextDecoration.none),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
