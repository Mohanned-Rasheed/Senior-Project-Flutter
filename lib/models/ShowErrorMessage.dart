import 'package:flutter/material.dart';

void ShowErrorMessage(
    BuildContext context, String FirstLine, String SecondLine, double height) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 6),
    content: Container(
        padding: const EdgeInsets.all(16),
        height: height,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(FirstLine,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(SecondLine),
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
  ));
}
