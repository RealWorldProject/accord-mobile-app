import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  File _image;
  int _conditionValue = 0;
  int _exchangeValue = 0;
  final _formKey = GlobalKey<FormState>();

  void _handleRadioValueForCondition(int value) {
    setState(() {
      _conditionValue = value;
      print(_conditionValue);
    });
  }

  void _handleRadioValueForExchange(int value) {
    setState(() {
      _exchangeValue = value;
      print(_exchangeValue);
    });
  }

  Future getImagefromcamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            Container(
              color: Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                        leading: Icon(
                          Icons.photo_library,
                        ),
                        title: Text(
                          'Choose from Gallery',
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          getImagefromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text(
                        'Open Camera',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        getImagefromcamera();
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  String valueChoose;
  List category = ["Cat 1", "Cat 2", "Cat 3", "Cat 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Add a Book",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image selection area
              Padding(
                padding: EdgeInsets.only(left: 6.0),
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
                        child: Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    color: Colors.grey[800],
                                    size: 50,
                                  ),
                                  Text("Add Image")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _image == null
                            ? Container()
                            : Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      _image,
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
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _image = null;
                                          });
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.grey[800],
                                          size: 15,
                                        ),
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
                      ),
                    ],
                  ),
                ),
              ),

              // form area
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        key: Key("bookName"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Book's Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:
                            RequiredValidator(errorText: "Name is required"),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Author's Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        key: Key("authorName"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Author's Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(
                            errorText: "Author Name is required"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.grey[200],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          hint: Text("Select Category"),
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          isExpanded: true,
                          value: valueChoose,
                          onChanged: (newvalue) {
                            setState(() {
                              valueChoose = newvalue;
                            });
                          },
                          items: category.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        key: Key("price"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Price",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator:
                            RequiredValidator(errorText: "Price is required"),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        key: Key("description"),
                        maxLines: 7,
                        keyboardType: TextInputType.multiline,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          hintText: "Description",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: RequiredValidator(
                            errorText: "Description is required"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Condition",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _conditionValue,
                            onChanged: _handleRadioValueForCondition,
                          ),
                          Text(
                            'New',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _conditionValue,
                            onChanged: _handleRadioValueForCondition,
                          ),
                          Text(
                            'Old',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "Exchange",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _exchangeValue,
                            onChanged: _handleRadioValueForExchange,
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _exchangeValue,
                            onChanged: _handleRadioValueForExchange,
                          ),
                          Text(
                            'No',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("1");
                            },
                            child: Center(
                              child: Text(
                                "Add Book",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
