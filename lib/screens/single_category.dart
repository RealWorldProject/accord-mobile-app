import 'package:accord/models/category.dart';
import 'package:accord/screens/widgets/search_field.dart';
import 'package:flutter/material.dart';

class SingleCategory extends StatefulWidget {
  final Category category;

  SingleCategory({this.category});

  @override
  _SingleCategoryState createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            // bottom: PreferredSize(
            //   child: Container(
            //     color:Colors.orange
            //   ),
            //   preferredSize: Size(0, 60),
            // ),
            elevation: 0,
            snap: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(


              title: Text(widget.category.name),
              background: Stack(

                children: [
                  Positioned.fill(
                    child: Image.asset(
                      widget.category.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   child: Container(
                  //     height: 25,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.vertical(
                  //         top: Radius.circular(40),
                  //       ),
                  //     ),
                  //   ),
                  //   bottom: -1,
                  //   left: 0,
                  //   right: 0,
                  // ),
                ],
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.305,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 850,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                          child: SearchField(),
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
