import 'package:accord/screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GetStartedScreen extends StatefulWidget {

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
    var _backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1000
        ),
      color:_backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(

              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 100
                    ),
                      child: Text("Accord",style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),)),
                  Container(margin: EdgeInsets.all(20),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      child: Text(
                        "We make exchange, buy and selling of book easy. Join us and get the book you like.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 16,

                      ),),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(

                  child:Image.asset("assets/images/start1.png"),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));

                },
                child: Container(
                margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40)
                  ),
                    child:Center(child: Text("Get Started",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
