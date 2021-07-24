import 'package:accord/screens/home/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final double imageHeight = 125.0;
  final double imageWidth = 100.0;

  _ratingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star_rate_rounded : Icons.star_border_rounded,
          size: 18,
          color: Colors.orange,
        );
      }),
    );
  }

  _searchResultListView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fiction",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 140,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(20.0),
                          //   child: Image.asset(
                          //     "assets/images/b1.jpg",
                          //     height: 120,
                          //     width: 110,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              "assets/images/b1.jpg",
                              height: imageHeight,
                              width: imageWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 0),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent[700],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Text(
                                "new",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Badge(
                              //
                              //   badgeContent: Text(
                              //     "new",
                              //     style: TextStyle(color: Colors.white, fontSize: 9),
                              //   ),
                              //   position: BadgePosition.topEnd(top: -12, end: -12),
                              //   elevation: 0,
                              //   shape: BadgeShape.square,
                              //   badgeColor: Colors.greenAccent[700],
                              //   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
                              //   borderRadius: BorderRadius.circular(3),
                              //   child: Text(
                              //     "The Gravity of Us  ",
                              //     style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.bold,
                              //         color: Colors.grey[900]),
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              // ),
                              Text(
                                "The Gravity of Us  ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[900]),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "JK Rolling",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.grey[700],
                                    fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                              ),

                              _ratingStars(4),
                              SizedBox(
                                height: 2,
                              ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              //   decoration: BoxDecoration(
                              //     color: Colors.greenAccent[700],
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(5),
                              //     ),
                              //   ),
                              //   child: Text(
                              //     "new",
                              //     style: TextStyle(color: Colors.white, fontSize: 10),
                              //   ),
                              // ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Available for Exchange",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "Rs. 500",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff247BA0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color(0xff13293D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.shopping_cart),
                          iconSize: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 1,
              snap: true,
              floating: true,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                title: Text("Search Results"),
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                        Colors.blueAccent[700],
                        Colors.blue[600],
                        Colors.blue[300]
                      ])),
                ),
              ),
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.255,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SearchField(),
                _searchResultListView(),
              ]),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //         gradient: LinearGradient(begin: Alignment.topCenter, colors: [
    //       Colors.blueAccent[700],
    //       Colors.blue[600],
    //       Colors.blue[300]
    //     ])),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.max,
    //       children: [
    //         SizedBox(
    //           height: 80,
    //         ),
    //         IconButton(
    //           icon: Icon(
    //             Icons.arrow_back_ios_new_outlined,
    //             color: Colors.white,
    //           ),
    //           onPressed: () => Navigator.pop(context),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               CustomText(
    //                 holderKey: "ttlSearchResult",
    //                 textToShow: "Search Results",
    //                 textColor: Colors.white,
    //               ),
    //
    //
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: 30),
    //         Expanded(
    //           child: Container(
    //             // height: MediaQuery.of(context).size.height/1.3,
    //             width: double.infinity,
    //
    //             decoration: BoxDecoration(
    //                 color: Colors.grey,
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(35),
    //                     topRight: Radius.circular(35))),
    //             child: SingleChildScrollView(
    //               child: Padding(
    //                 padding: EdgeInsets.all(30),
    //                 child: Column(),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
