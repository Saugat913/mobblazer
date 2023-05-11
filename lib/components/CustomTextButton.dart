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
    fontFactor ??= 1;
    color ??= const Color(0xffee3925);
    fontSize ??= 14;
    text ??= "";
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
        onTap: widget.onTap,
        child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                color:widget.color,
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child:Text(widget.text!,style: TextStyle(fontSize: widget.fontFactor! * widget.fontSize!,color: Colors.white),)
            ))
        );
  }
}
