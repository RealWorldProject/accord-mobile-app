import 'package:accord/screens/add_book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(child: Text("Add Book"), onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBook()));
        }),
      ),
    );
  }
}
// return SingleChildScrollView(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Stack(
// overflow: Overflow.visible,
// children: <Widget>[
//
// ClipRRect(
// // borderRadius: BorderRadius.circular(8.0),
// child: Image.asset(
// 'assets/images/wat.jpg',
// height: 250,
// width: double.infinity,
// fit: BoxFit.cover,
// ),
// ),
// // Positioned(
// //   top: 1,
// //   left: 1,
// //   child: InkWell(
// //
// //     child: Container(
// //       height: 45,
// //       width: 45,
// //       child: Icon(
// //         Icons.arrow_back_ios,
// //         color: Colors.blue,
// //       ),
// //     ),
// //   ),
// // ),
// Positioned(
// bottom: 1,
// right: 1,
// child: Container(
// height: 45,
// width: 45,
// child: Icon(
// Icons.add_a_photo,
// color: Colors.white,
// ),
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.all(
// Radius.circular(25),
// ),
// ),
// ),
// ),
// ],
// ),
// Flexible(
// child: Container(
// child: TextFormField(),
// ))
// ],
// ),
// );