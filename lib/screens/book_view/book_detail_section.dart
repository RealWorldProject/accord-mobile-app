import 'package:accord/constant/constant.dart';
import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:accord/screens/widgets/back_button.dart';
import 'package:accord/screens/widgets/custom_like_button.dart';
import 'package:flutter/material.dart';
class BookDetailSection extends StatefulWidget {
  const BookDetailSection({Key key}) : super(key: key);

  @override
  _BookDetailSectionState createState() => _BookDetailSectionState();
}

class _BookDetailSectionState extends State<BookDetailSection> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
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
                        image: AssetImage("assets/images/book2.jpg"),
                        fit: BoxFit.contain)),
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
                Text(
                  "The King of Drugs",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Constant.full_dark_blue_color),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "By",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: " Nora Barrett",
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
                SizedBox(height: 3,),
                RatingStars(4.5, 20),
                Text(
                  "Available for Exchange",
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1b98e0)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
