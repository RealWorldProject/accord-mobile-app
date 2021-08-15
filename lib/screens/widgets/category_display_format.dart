import 'package:accord/models/category.dart';
import 'package:accord/screens/home/category/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryDisplayFormat extends StatelessWidget {
  final Category categoryObj;
  final int index;
  final double sizeRatio;
  final EdgeInsets margin;

  CategoryDisplayFormat({
    this.categoryObj,
    this.index,
    this.sizeRatio = 11 / 15,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: AspectRatio(
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
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      // color: Colors.black26,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.black87,
                            Colors.black54,
                            Colors.black54,
                            Colors.black38,
                            Colors.black26,
                            Colors.black12,
                            Colors.black12,
                            Colors.black12,
                          ])),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),

              Positioned(
                  bottom: 5,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          categoryObj.category,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        )
                      ],
                    ),
                  )),

              // Positioned(
              //   child: Center(
              //     child: Container(
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 5,
              //       ),
              //       color: Colors.white54,
              //       height: 38,
              //       width: MediaQuery.of(context).size.width,
              //       child: Center(
              //         child: Text(
              //           categoryObj.category,
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 16.0),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
