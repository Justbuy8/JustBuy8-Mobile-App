import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class PrimaryText extends StatelessWidget {
  const PrimaryText({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontFamily,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? 20,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily ?? AppFonts.openSansLight,
      ),
    );
  }
}
