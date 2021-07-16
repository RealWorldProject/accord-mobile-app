import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddBookForm extends StatefulWidget {
  const AddBookForm({Key key}) : super(key: key);

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  int _conditionValue = 0;
  int _exchangeValue = 0;
  final _formKey = GlobalKey<FormState>();

  void _handleRadioValueForCondition(int value) {
    setState(() {
      _conditionValue = value;
      print(_conditionValue);

      switch (_conditionValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  void _handleRadioValueForExchange(int value) {
    setState(() {
      _exchangeValue = value;
      print(_exchangeValue);

      switch (_exchangeValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  String valueChoose;
  List category = ["Cat 1", "Cat 2", "Cat 3", "Cat 4"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                    color: Colors.black),
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
                      borderRadius: BorderRadius.circular(8))),
              validator: RequiredValidator(errorText: "Name is required"),
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
                    color: Colors.black),
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
                      borderRadius: BorderRadius.circular(8))),
              textInputAction: TextInputAction.next,
              validator:
                  RequiredValidator(errorText: "Author Name is required"),
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
                    color: Colors.black),
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8))),
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
            // TextFormField(
            //   key: Key("category"),
            //   autovalidateMode: AutovalidateMode.onUserInteraction,
            //   decoration: InputDecoration(
            //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
            //       hintText: "Category",
            //       hintStyle: TextStyle(color: Colors.grey),
            //       border: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.grey),
            //           borderRadius: BorderRadius.circular(8))
            //
            //       ),
            //   validator: RequiredValidator(errorText:"Category is required"),
            //
            //   textInputAction: TextInputAction.next,
            // ),
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
                    color: Colors.black),
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
                      borderRadius: BorderRadius.circular(8))),
              validator: RequiredValidator(errorText: "Price is required"),
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
                    color: Colors.black),
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8))),
              textInputAction: TextInputAction.next,
              validator:
                  RequiredValidator(errorText: "Description is required"),
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
                    color: Colors.black),
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
                      color: Colors.black),
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
                      color: Colors.black),
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
                    color: Colors.black),
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
                      color: Colors.black),
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
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("1");
                  },
                  child: Center(
                    child: Text(
                      "Add Book",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
