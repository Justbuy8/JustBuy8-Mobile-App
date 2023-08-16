import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class PrimaryTextWidget extends StatelessWidget {
  const PrimaryTextWidget({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontFamily,
    this.fontColor,
    this.textAlign,
    this.overflow,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final Color? fontColor;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily ?? AppFonts.openSansLight,
          color: fontColor ?? Colors.black,
          overflow: overflow ?? TextOverflow.fade),
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
