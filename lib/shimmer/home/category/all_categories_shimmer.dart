import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllCategoriesShimmer extends StatelessWidget {
  const AllCategoriesShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[200],
                  child: Container(
                    height: 28,
                    width: 120,
                    color: Colors.grey[300],
                  )),
              centerTitle: true,
              background: Stack(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[200],
                    child: Container(
                      height: 270,
                      color: Colors.grey[300],
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
                  (MediaQuery.of(context).size.height / 1.6),
              children: List.generate(4, (index) {
                return Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Stack(children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400],
                      highlightColor: Colors.grey[300],
                      child: Container(
                        height: 219,
                        width: 175,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ]),
                );
              })),
        ],
      ),
    );
  }
}
