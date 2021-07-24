import 'package:accord/data/data.dart';
import 'package:accord/models/category.dart';
import 'package:accord/models/category_test.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class AllCategoriesScreen extends StatefulWidget {
  // final CategoryTest category;

  // CategoryScreen({this.category});

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  _buildCategory(Category categoryObj, index) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 10,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryScreen(categoryObj: categoryObj),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Hero(
                tag: categoryObj.category,
                child: Image.asset(
                  categoryObj.image,
                  height: 219,
                  width: 175,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 219,
                width: 175,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  color: Colors.white70,
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      categoryObj.category,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

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
              title: Text("All Categories"),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/b3.jpg",
                      fit: BoxFit.cover,
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
                (MediaQuery.of(context).size.height / 1.6),
            // children: List.generate(categories.length, (index) {
            //   CategoryTest categoryObj = categories[index];
            //   return _buildCategory(categoryObj, index);
            // }),
          ),
        ],
      ),
    );
  }
}
