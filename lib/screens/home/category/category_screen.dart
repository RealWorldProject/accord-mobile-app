import 'package:accord/models/book_test.dart';
import 'package:accord/models/category.dart';
import 'package:accord/models/category_test.dart';
import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category categoryObj;

  CategoryScreen({this.categoryObj});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // bool isLiked = false;
  // const isNew = widget.category.book.isNew;

  // _buildBooks(BookTest bookTest, int index) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 20, left: 10, bottom: 0),
  //     padding: EdgeInsets.all(7.0),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       borderRadius: BorderRadius.circular(15.0),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Stack(
  //           clipBehavior: Clip.none,
  //           children: [
  //             Container(
  //               height: 219.0,
  //               width: 175.0,
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: AssetImage(bookTest.images),
  //                   fit: BoxFit.cover,
  //                 ),
  //                 borderRadius: BorderRadius.circular(15.0),
  //               ),
  //             ),
  //             Positioned.fill(
  //               child: Container(
  //                 height: 180,
  //                 width: 132,
  //                 decoration: BoxDecoration(
  //                   color: Colors.black12,
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(20),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               bottom: -20,
  //               right: 10,
  //               child: Container(
  //                 padding: EdgeInsets.zero,
  //                 height: 40,
  //                 width: 40,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[200],
  //                   shape: BoxShape.circle,
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 3,
  //                       offset: Offset(0, 2), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: IconButton(
  //                   padding:
  //                       EdgeInsets.only(top: 4, bottom: 0, left: 0, right: 0),
  //                   alignment: Alignment.center,
  //                   icon: widget.category.book[index].isLiked == false
  //                       ? Icon(Icons.favorite_outline_rounded)
  //                       : Icon(
  //                           Icons.favorite,
  //                           color: Colors.red,
  //                         ),
  //                   iconSize: 25,
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               bottom: -20,
  //               left: 0,
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
  //                 alignment: Alignment.center,
  //                 decoration: widget.category.book[index].isNEW == false
  //                     ? BoxDecoration(
  //                         color: Colors.purple,
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(5),
  //                         ),
  //                       )
  //                     : BoxDecoration(
  //                         color: Colors.greenAccent[700],
  //                         borderRadius: BorderRadius.all(
  //                           Radius.circular(5),
  //                         ),
  //                       ),
  //                 child: widget.category.book[index].isNEW == false
  //                     ? Text(
  //                         "old",
  //                         style: TextStyle(color: Colors.white, fontSize: 10),
  //                       )
  //                     : Text(
  //                         "new",
  //                         style: TextStyle(color: Colors.white, fontSize: 10),
  //                       ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           widget.category.book[index].name,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.grey[900]),
  //         ),
  //         Text(
  //           widget.category.book[index].author,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //               fontSize: 12,
  //               fontWeight: FontWeight.w100,
  //               color: Colors.grey[700],
  //               fontStyle: FontStyle.italic),
  //         ),
  //         RatingStars(widget.category.book[index].rating),
  //         widget.category.book[index].isAvailableForExchange == false
  //             ? Text(
  //                 "Available for Exchange",
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.w100,
  //                     color: Colors.grey[800],
  //                     decoration: TextDecoration.lineThrough,
  //                     fontStyle: FontStyle.italic),
  //               )
  //             : Text(
  //                 "Available for Exchange",
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(
  //                     fontSize: 11,
  //                     fontWeight: FontWeight.w100,
  //                     color: Colors.blue,
  //                     fontStyle: FontStyle.italic),
  //               ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Rs. ${widget.category.book[index].price.toString()}",
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w800,
  //                 color: Color(0xff247BA0),
  //               ),
  //             ),
  //             Container(
  //               height: 30,
  //               width: 35,
  //               decoration: BoxDecoration(
  //                 color: Color(0xff13293D),
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(5),
  //                 ),
  //               ),
  //               child: IconButton(
  //                 onPressed: () {},
  //                 padding: EdgeInsets.zero,
  //                 icon: Icon(Icons.shopping_cart),
  //                 iconSize: 18,
  //                 color: Colors.white,
  //               ),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.categoryObj.category),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: widget.categoryObj.category,
                      child: Image.asset(
                        widget.categoryObj.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
          ),
          SliverGrid.count(
            crossAxisSpacing: 0,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.025),
            // children: List.generate(widget.categoryObj.book.length, (index) {
            //   BookTest bookTest = widget.category.book[index];
            //   return _buildBooks(bookTest, index);
            // }),
          ),
        ],
      ),
    );
  }
}
