import 'package:accord/screens/home/search_field.dart';
import 'package:accord/screens/profile/post_book.dart';
import 'package:accord/screens/search/search_test.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'categories_view_shimmer.dart';

class HomeScreenShimmer extends StatefulWidget {
  const HomeScreenShimmer({Key key}) : super(key: key);

  @override
  _HomeScreenShimmerState createState() => _HomeScreenShimmerState();
}

class _HomeScreenShimmerState extends State<HomeScreenShimmer> {
  _buildBooks() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 10, bottom: 0),
        padding: EdgeInsets.all(7.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 219.0,
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: 10,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[200],
                    child: Container(
                      padding: EdgeInsets.zero,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                        padding: EdgeInsets.only(
                            top: 4, bottom: 0, left: 0, right: 0),
                        alignment: Alignment.center,
                        // icon: book.isLiked == false
                        //     ? Icon(Icons.favorite_outline_rounded)
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        iconSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[200],
              child: Container(
                width: 120,
                height: 12,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[200],
              child: Container(
                width: 120,
                height: 12,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[200],
              child: Container(
                width: 100,
                height: 12,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.grey[200],
              child: Container(
                width: 120,
                height: 12,
                color: Colors.grey[300],
              ),
            ),
            // Text(
            //   "book.author",
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w100,
            //       color: Colors.grey[700],
            //       fontStyle: FontStyle.italic),
            // ),
            // "RatingStars(4.5),"

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    width: 60,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                ),
                // Text(
                //   "Rs. 500",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w800,
                //     color: Color(0xff247BA0),
                //   ),
                // ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 30,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),

                  ),
                ),
              ),
              CategoriesViewShimmer(),
              SizedBox(
                height: 20,
              ),
              Container(
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
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              height: 26.0,
                              width: 160.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              height: 20.0,
                              width: 60.0,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 500,
                      child: GridView.count(
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.025),
                        children: List.generate(4, (index) {
                          return _buildBooks();
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Shimmer.fromColors(
        baseColor: Colors.grey[400],
        highlightColor: Colors.grey[200],
        child: FloatingActionButton(
          backgroundColor: Colors.grey[300],

          // isExtended: true,
          // onPressed: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => PostBook()));
          // },
          // child: const Icon(
          //   Icons.add,
          //   size: 32,
          // ),
          // tooltip: "Add Book",
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   isExtended: true,
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => PostBook()));
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 32,
      //   ),
      //   tooltip: "Add Book",
      // ),
    );
  }
}
