import 'package:accord/models/category.dart';
import 'package:accord/screens/home/category/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryDisplayFormat extends StatelessWidget {
  final Category categoryObj;
  final int index;

  CategoryDisplayFormat({
    this.categoryObj,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
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
                child: Image.network(
                  categoryObj.image,
                  width: 132,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 132,
                height: 180,
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
                color: Colors.white54,
                height: 38,
                width: 132,
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
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
