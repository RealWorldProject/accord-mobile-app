import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key key}) : super(key: key);

  _ReviewListView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/user2.png",
                          ),
                          radius: 28,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(
                            textToShow: "Daya Ram Mahato",
                            fontSize: 14,
                            textColor: AccordColors.full_dark_blue_color,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RatingStars(5, 18),
                              SizedBox(
                                width: 15,
                              ),
                              CustomText(
                                textToShow: "5.0",
                                fontSize: 12,
                                textColor: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          CustomText(
                            textToShow: "1 day ago",
                            fontSize: 12,
                            textColor: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.grey[600]

                ),
                overflow: TextOverflow.clip,

              ),
              Divider(
                height: 35,
                thickness: 1,
                indent: 0,
                endIndent: 0,
                color: Color(0xffcdcdcd),
              ),

            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _ReviewListView();
          }),
    );
  }
}
