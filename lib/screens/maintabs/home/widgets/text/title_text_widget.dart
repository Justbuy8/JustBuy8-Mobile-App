import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return PrimaryTextWidget(
      text: text,
      fontSize: 23,
      fontFamily: AppFonts.robotoBold,
    );
  }
}
