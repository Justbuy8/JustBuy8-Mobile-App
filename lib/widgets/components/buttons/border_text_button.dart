import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class BorderTextButton extends StatelessWidget {
  const BorderTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.isClicked,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final bool? isClicked;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () {},
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1,
          ),
          color: isClicked == true
              ? AppColors.primaryColor
              : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: isClicked == true
                  ? AppColors.appWhiteColor
                  : AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            maxFontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
