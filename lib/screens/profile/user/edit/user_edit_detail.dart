import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/CustomButton.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:accord/screens/widgets/empty_text_field.dart';
import 'package:flutter/material.dart';

class UserEditDetail extends StatefulWidget {
  const UserEditDetail({Key key}) : super(key: key);

  @override
  _UserEditDetailState createState() => _UserEditDetailState();
}

class _UserEditDetailState extends State<UserEditDetail> {
  TextEditingController _phoneNumberController;
  TextEditingController _nameController;

  // final _phoneNumberController = TextEditingController( );

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController(text: '9846123654');
    _nameController = TextEditingController(text: 'John Doe');
  }

  void _toggleRemoveNumber() {
    setState(() {
      _phoneNumberController.clear();
    });
  }

  void _toggleRemoveName() {
    setState(() {
      _nameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff13293d)),
        title: Text(
          "Edit Detail",
          style: TextStyle(color: Color(0xff13293d)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                textToShow: "Name",
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // TextFormField(
                              //   initialValue: "9843693091",
                              // ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    height: 50,
                                    child: TextFormField(
                                      controller: _nameController,
                                      // initialValue: "9843693091",
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: EmptyTextField(
                                      toggleRemoveText: _toggleRemoveName,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: CustomButton(text: "Change Name"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AccordColors.full_dark_blue_color),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  textToShow: "Phone Number",
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // TextFormField(
                                //   initialValue: "9843693091",
                                // ),
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      height: 50,
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        // initialValue: "9843693091",
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: EmptyTextField(
                                        toggleRemoveText: _toggleRemoveNumber,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: CustomButton(text: "Change Number"),
                                ),
                                // SizedBox(
                                //   height: 30,
                                //   width: 300,
                                //   child: CustomButton(),
                                // )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AccordColors.full_dark_blue_color),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "9846123654",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800]),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ],
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
