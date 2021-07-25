import 'package:accord/data/data.dart';
import 'package:accord/models/category_test.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesViewShimmer extends StatefulWidget {
  const CategoriesViewShimmer({Key key}) : super(key: key);

  @override
  _CategoriesViewShimmerState createState() => _CategoriesViewShimmerState();
}

class _CategoriesViewShimmerState extends State<CategoriesViewShimmer> {
  _buildCategory( index) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            // child: Image.asset(
            //   category.imageUrl,
            //   height: 180,
            //   width: 132,
            //   fit: BoxFit.cover,
            // ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.grey[200],
            child: Container(
              height: 180,
              width: 132,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          // Shimmer.fromColors(
          //   baseColor: Colors.grey[400],
          //   highlightColor: Colors.grey[200],
          //   child: Center(
          //     child: Container(
          //
          //       color: Colors.grey[200],
          //       height: 38,
          //       width: 132,
          //
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      // padding: EdgeInsets.only(left: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 26.0,
                    width: 160.0,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 20.0,
                    width: 60.0,
                    color: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 180,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return _buildCategory( index);
              },
            ),
          )
        ],
      ),
    );
  }
}
