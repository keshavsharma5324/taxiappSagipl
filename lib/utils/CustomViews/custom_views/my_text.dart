import 'package:flutter/cupertino.dart';
//import 'package:customer/utils/app_colors.dart';

import '../../app_colors.dart';

class MyText extends StatefulWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? textDecoration;


  MyText({
    this.text,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.textDecoration
  });

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
        widget.text.toString(),
        maxLines: widget.maxLines,
        textAlign: widget.textAlign != null ? widget.textAlign : TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          decoration: widget.textDecoration == null ? TextDecoration.none : widget.textDecoration,
            color: widget.color!= null ? widget.color: AppColors.themeGreenColor,
            fontFamily: 'Gilroy',
            fontWeight: widget.fontWeight,
            fontSize: widget.fontSize));
  }
}
