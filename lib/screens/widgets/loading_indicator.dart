import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';

loadingIndicator(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: BallClipRotateMultipleIndicator(
          maxRadius: 50,
          minRadius: 30,
          dashCircleRadius: 15,
        ),
      );
    },
  );
}
