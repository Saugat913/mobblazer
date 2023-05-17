import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,{bool isError=true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        height: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: isError==true? Colors.red:const Color.fromARGB(255, 212, 208, 208)),
        child: Center(
            child: Text(
          message,
          style:  TextStyle(color: isError?Colors.white:Colors.green),
        )),
      )));
}
