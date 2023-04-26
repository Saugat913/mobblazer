import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.red),
        child: Center(
            child: Text(
          message,
          style: TextStyle(color: Colors.white),
        )),
      )));
}
