// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_fonts.dart';
import 'package:justbuyeight/constants/app_texts.dart';
import 'package:justbuyeight/widgets/components/text/primary_text_widget.dart';
import 'package:justbuyeight/widgets/components/text/secondary_text_widget.dart';

class TitleAndButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  const TitleAndButtonWidget({Key? key, required this.text, this.onPressed})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryTextWidget(
          text: text,
          fontSize: 20,
          fontFamily: AppFonts.robotoBold,
        ),
        GestureDetector(
          onTap: onPressed ?? () {},
          child: Row(
            children: [
              SecondaryTextWidget(
                text: AppText.viewAll,
                fontFamily: AppFonts.openSansMedium,
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 20),
            ],
          ),
        )
      ],
    );
  }
}

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Row(
        children: [
          SecondaryTextWidget(
            text: AppText.viewAll,
            fontFamily: AppFonts.robotoMonoMedium,
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }
}
