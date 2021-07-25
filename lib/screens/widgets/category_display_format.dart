import 'package:accord/models/category.dart';
import 'package:accord/screens/home/category/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryDisplayFormat extends StatelessWidget {
  final Category categoryObj;
  final int index;
  final double sizeRatio;

  CategoryDisplayFormat({
    this.categoryObj,
    this.index,
    this.sizeRatio = 11 / 15,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: sizeRatio,
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
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                categoryObj.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.black12,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Positioned(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  color: Colors.white54,
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
}
