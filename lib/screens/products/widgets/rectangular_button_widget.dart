import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class RectangleButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool? isSelected;
  const RectangleButtonWidget(
      {Key? key, required this.text, this.onPressed, this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor),
          color: isSelected == true
              ? AppColors.primaryColor
              : AppColors.appWhiteColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text.trim(),
          style: TextStyle(
            fontFamily: AppFonts.openSansRegular,
            color: isSelected == true
                ? AppColors.appWhiteColor
                : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
