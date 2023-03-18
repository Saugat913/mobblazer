import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
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
    if(color==null){
      color= Color(0xffee3925);
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
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            height: this.widget.height,
            width: this.widget.width,
            decoration: BoxDecoration(
                color:this.widget.color,
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child:Text(this.widget.text!,style: TextStyle(fontSize: widget.fontFactor! * widget.fontSize!,color: Colors.white),)
            ))
        );
  }
}
