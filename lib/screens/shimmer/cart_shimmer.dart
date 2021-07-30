import 'package:accord/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({Key key}) : super(key: key);
  final double imageHeight = 110.0;
  final double imageWidth = 95.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Constant.shimmer_base_color,
                  highlightColor: Constant.shimmer_highlight_color,
                  child: Container(
                    height: imageHeight,
                    width: imageWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(

                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Constant.shimmer_base_color,
                          highlightColor: Constant.shimmer_highlight_color,
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.6,
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Shimmer.fromColors(
                          baseColor: Constant.shimmer_base_color,
                          highlightColor: Constant.shimmer_highlight_color,
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.6-30,
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Shimmer.fromColors(
                          baseColor: Constant.shimmer_base_color,
                          highlightColor: Constant.shimmer_highlight_color,
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.6-80,
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Shimmer.fromColors(
                          baseColor: Constant.shimmer_base_color,
                          highlightColor: Constant.shimmer_highlight_color,
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.6,
                            height: 12,

                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),

    );
  }
}
