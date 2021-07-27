import 'package:accord/constant/constant.dart';
import 'package:accord/screens/shimmer/text_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ViewProfileShimmer extends StatefulWidget {
  const ViewProfileShimmer({Key key}) : super(key: key);

  @override
  _ViewProfileShimmerState createState() => _ViewProfileShimmerState();
}

class _ViewProfileShimmerState extends State<ViewProfileShimmer> {
  double sizeHight = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: Shimmer.fromColors(
              baseColor: Constant.shimmer_base_color,
              highlightColor: Constant.shimmer_highlight_color,
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: Constant.shimmer_base_color,
              highlightColor: Constant.shimmer_highlight_color,
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: 12,

                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

          ),
          Shimmer.fromColors(
            baseColor: Constant.shimmer_base_color,
            highlightColor: Constant.shimmer_highlight_color,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              color: Colors.grey[500],
              // child: Image.asset(
              //   "assets/images/a1.jpg",
              //   fit: BoxFit.contain,
              // ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Shimmer.fromColors(
                  baseColor: Constant.shimmer_base_color,
                  highlightColor: Constant.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.5,
                    height: 12,

                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: sizeHight,),
                Shimmer.fromColors(
                  baseColor: Constant.shimmer_base_color,
                  highlightColor: Constant.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.5 - 40,
                    height: 12,

                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: sizeHight,),

                Shimmer.fromColors(
                  baseColor: Constant.shimmer_base_color,
                  highlightColor: Constant.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.5 -80,
                    height: 12,

                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: sizeHight,),

                Shimmer.fromColors(
                  baseColor: Constant.shimmer_base_color,
                  highlightColor: Constant.shimmer_highlight_color,
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.5-10,
                    height: 12,

                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: sizeHight,),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Constant.shimmer_base_color,
                        highlightColor: Constant.shimmer_highlight_color,
                        child: Container(
                          width: MediaQuery.of(context).size.width/5,
                          height: 12,

                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
