import 'package:flutter/material.dart';

void ShowErrorMessage(
    BuildContext context, String FirstLine, String SecondLine, double height) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 6),
    content: Container(
        padding: EdgeInsets.all(16),
        height: height,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(FirstLine,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(SecondLine),
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
