import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton(
      {super.key,
      this.width,
      this.height,
      this.color,
      this.fontFactor,
      this.fontSize,
      required this.onTap,this.text}) {
    if (fontFactor == null) {
      fontFactor = 1;
    }
    if(fontSize==null){
      fontSize=14;
    }
    if(text==null){
      text="";
    }
  }
  String? text;
  void Function()? onTap;
  double? height;
  double? width;
  Color? color;
  double? fontFactor;
  double? fontSize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            height: this.height,
            width: this.width,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child:Text(this.text!,style: TextStyle(fontSize: fontFactor! * fontSize!),)
            ))
        );
  }
}
