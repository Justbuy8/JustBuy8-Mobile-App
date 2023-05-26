import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class AvatarImageFileWidget extends StatelessWidget {
  const AvatarImageFileWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);
  final File imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // make it circle
      height: height ?? 100.h,
      width: width ?? 100.w,
      padding: EdgeInsets.all(5.0.w),
      decoration: BoxDecoration(
        color: AppColors.appGreyColor.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.appGreyColor.withOpacity(0.2),
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Image.file(
          imageUrl,
          height: height ?? 100.h,
          width: width ?? 100.w,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
