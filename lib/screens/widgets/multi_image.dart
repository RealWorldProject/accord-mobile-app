// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:advance_image_picker/advance_image_picker.dart';
// import 'package:intl/intl.dart';
// class MultiImage extends StatefulWidget {
//   const MultiImage({Key key}) : super(key: key);
//
//   @override
//   _MultiImageState createState() => _MultiImageState();
// }
//
// class _MultiImageState extends State<MultiImage> {
//   List<ImageObject> _imgObjs = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text("multi image"),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: _imgObjs.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     mainAxisSpacing: 2,
//                     crossAxisSpacing: 2,
//                     childAspectRatio: 1),
//                 itemBuilder: (BuildContext context, int index) {
//                   var image = _imgObjs[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Image.file(File(image.modifiedPath),
//                         height: 80, fit: BoxFit.cover),
//                   );
//                 })
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           // Get max 5 images
//           List<ImageObject>? objects = await Navigator.of(context)
//               .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
//             return ImagePicker(maxCount: 5);
//           }));
//
//           if ((objects?.length ?? 0) > 0) {
//             setState(() {
//               _imgObjs = objects!;
//             });
//           }
//         },
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }