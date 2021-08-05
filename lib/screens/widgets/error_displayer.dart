import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDisplayer extends StatelessWidget {
  const ErrorDisplayer({
    Key key,
    this.error,
    this.retryOption,
  }) : super(key: key);

  final String error;
  final VoidCallback retryOption;

  @override
  Widget build(BuildContext context) {
    String errorTitle = error.split("\n").first;
    String errorMessage = error.split("\n").last;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              errorMessage,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
              // softWrap: false,
            ),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              retryOption();
            },
            child: Text(
              "Retry",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
