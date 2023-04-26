import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class PrimaryTextWidget extends StatelessWidget {
  const PrimaryTextWidget({
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
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily ?? AppFonts.openSansLight,
      ),
    );
  }
}
