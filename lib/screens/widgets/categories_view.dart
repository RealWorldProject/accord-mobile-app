import 'package:accord/data/data.dart';
import 'package:accord/models/category.dart';
import 'package:accord/screens/single_category.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key key}) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  _buildCategory(Category category, index) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SingleCategory(category: category),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Hero(
                tag: category.name,
                child: Image.asset(
                  category.imageUrl,
                  height: 180,
                  width: 132,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                height: 180,
                width: 132,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                color: Colors.white70,
                height: 38,
                width: 132,
                child: Center(
                  child: Text(
                    category.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
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
                padding: const EdgeInsets.only(left:3.0),
                child: Text(
                  "Categories",

                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500,letterSpacing: -1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
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
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                Category category = categories[index];
                return _buildCategory(category,index);
              },
            ),
          )
        ],
      ),
    );
  }
}
