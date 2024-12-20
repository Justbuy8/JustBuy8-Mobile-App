import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class SecondaryTextWidget extends StatelessWidget {
  const SecondaryTextWidget(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontFamily,
      this.fontWeight,
      this.textAlign,
      this.fontColor})
      : super(key: key);
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? AppFonts.openSansLight,
        color: fontColor ?? Colors.black,
      ),
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
