import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';
import 'package:justbuyeight/constants/app_fonts.dart';

class CircleTextButton extends StatelessWidget {
  final String text;
  final bool? isSelected;
  final VoidCallback? onPressed;
  const CircleTextButton({
    Key? key,
    required this.text,
    this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40.h,
        width: 40.w,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor),
          color: isSelected == true
              ? AppColors.primaryColor
              : AppColors.appWhiteColor,
        ),
        alignment: Alignment.center,
        child: Center(
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
      ),
    );
  }
}
