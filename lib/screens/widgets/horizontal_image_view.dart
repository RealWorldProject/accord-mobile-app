import 'package:flutter/material.dart';

class HorizontalImageView extends StatefulWidget {
  const HorizontalImageView({Key key}) : super(key: key);

  @override
  _HorizontalImageViewState createState() => _HorizontalImageViewState();
}

class _HorizontalImageViewState extends State<HorizontalImageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        height: 200.0,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle, color: Colors.grey[800],size: 50,),
                          Text("Add Image")
                        ],
                      ),
                    ),
                  ),
                )

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/wat.jpg',
                      height: 200,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      height: 25,
                      width: 25,
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[800],
                        size: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child: Container(
              //   width: 160.0,
              //   color: Colors.blue,
              // ),
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     width: 160.0,
            //     color: Colors.amber,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     width: 160.0,
            //     color: Colors.red,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     width: 160.0,
            //     color: Colors.green,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
